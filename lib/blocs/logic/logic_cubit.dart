import 'package:bloc/bloc.dart';
import 'package:calculator/model/historyitem.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:calculator/UI/history.dart';

part 'logic_state.dart';

class LogicCubit extends Cubit<LogicState> {
  LogicCubit() : super(LogicState(userInput:'',userOutput:'',enough: false));

  void equalPressed() {

    String userInputFC = state.userInput;


    userInputFC = userInputFC.replaceAll("x", "*");
    userInputFC = userInputFC.replaceAll("e", "2.7182818285");
    userInputFC = userInputFC.replaceAll("π", "3.1415926536");
    userInputFC = userInputFC.replaceAll("√", "sqrt");



    Parser p = Parser();
    Expression exp = p.parse(userInputFC);
    ContextModel ctx = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, ctx);
    state.userOutput = eval.toString();
    emit(LogicState(userInput: state.userInput,
        userOutput: state.userOutput,
        enough: false));


    final historyItem = HistoryItem()
      ..title = state.userOutput
      ..subtitle = state.userInput;
    Hive.box<HistoryItem>('history').add(historyItem);

  }

  void clearInputAndOutput() => emit(LogicState(userInput: state.userInput='', userOutput: state.userOutput='',enough: false));

  void deleteBtnAction() => emit(LogicState(userInput: state.userInput.substring(0, state.userInput.length - 1), userOutput: state.userOutput,enough: false));

  void deleteAllBtnAction() => emit(LogicState(userInput: state.userInput='', userOutput: state.userOutput,enough: false));

  void btnTap(String add) {
    if(add == "+/-"){
      add = "-";
    }
    if(add == "1/x"){
      add = "1/";
    }

    emit(LogicState(userInput: state.userInput+=add, userOutput: state.userOutput,enough: false));}

  void full() => emit(LogicState(userInput: state.userInput, userOutput: state.userOutput,enough: true));
}

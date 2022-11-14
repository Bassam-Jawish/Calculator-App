import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'switch_state.dart';

class SwitcheCubit extends Cubit<SwitcheState> {
  SwitcheCubit() : super( SwitcheInitial(switchValue: false));

  void switche() {
       emit( SwitcheState(switchValue: !state.switchValue));
  }

}

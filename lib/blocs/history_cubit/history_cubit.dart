import 'package:bloc/bloc.dart';
import 'package:calculator/model/historyitem.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'history_state.dart';

class HistoryCubit extends Cubit<HistoryState> {
  HistoryCubit() : super(HistoryInitial(empty: true));

  void wipeHistory(result, context) {
    if (!state.empty) {
      emit(HistoryState(empty: true));
      Navigator.pop(context);
      Hive.box<HistoryItem>('history').clear();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('History cleared successfully'),
          duration: Duration(milliseconds: 1300),
        ),
      );
    }
  }

  void addToHistory() {
    emit(HistoryState(empty: false));
  }
}

part of 'history_cubit.dart';


class HistoryState {

  bool empty;
  HistoryState({required this.empty});


  @override
  List<Object> get props => [empty];
}

class HistoryInitial extends HistoryState {
  HistoryInitial({required super.empty});

}

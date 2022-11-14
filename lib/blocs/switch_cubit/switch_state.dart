part of 'switch_cubit.dart';

class SwitcheState extends Equatable{
   bool switchValue;

   SwitcheState({required this.switchValue});

  @override
  List<Object> get props => [switchValue];
}

class SwitcheInitial extends SwitcheState {
   SwitcheInitial({required super.switchValue});
}

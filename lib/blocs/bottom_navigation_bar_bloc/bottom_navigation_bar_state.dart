part of 'bottom_navigation_bar_bloc.dart';

abstract class BottomNavigationBarState {}

class BottomNavigationBarInitial extends BottomNavigationBarState {
  int currentIndex;

  BottomNavigationBarInitial({this.currentIndex = 0});
}

class BottomNavigationBarCurrentState extends BottomNavigationBarState {
  final int currentIndex;

  BottomNavigationBarCurrentState(this.currentIndex);
}

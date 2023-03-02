part of 'bottom_navigation_bar_bloc.dart';

abstract class BottomNavigationBarEvent {}

class BottomNavigationCurrentEvent extends BottomNavigationBarEvent {
  final int currentIndex;

  BottomNavigationCurrentEvent(this.currentIndex);
}

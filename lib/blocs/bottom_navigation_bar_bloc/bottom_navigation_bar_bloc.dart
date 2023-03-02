import 'package:flutter_bloc/flutter_bloc.dart';

part 'bottom_navigation_bar_event.dart';

part 'bottom_navigation_bar_state.dart';

class BottomNavigationBarBloc
    extends Bloc<BottomNavigationBarEvent, BottomNavigationBarState> {
  BottomNavigationBarBloc() : super(BottomNavigationBarInitial()) {
    on<BottomNavigationCurrentEvent>((event, emit) {
      emit.call(BottomNavigationBarCurrentState(event.currentIndex));
    });
  }
}

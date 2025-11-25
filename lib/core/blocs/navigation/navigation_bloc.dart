import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../enums/navigation_destination.dart';

part 'navigation_event.dart';
part 'navigation_state.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc() : super(NavigationState.initial()) {
    on<DestinationChanged>((event, emit) {
      emit(NavigationState.change(destination: event.destination));
    });
  }
}

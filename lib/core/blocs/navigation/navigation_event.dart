part of 'navigation_bloc.dart';

abstract class NavigationEvent extends Equatable {
  const NavigationEvent();

  @override
  List<Object> get props => [];
}

class DestinationChanged extends NavigationEvent {
  final Destination destination;
  const DestinationChanged({required this.destination});

  @override
  List<Object> get props => [destination];
}

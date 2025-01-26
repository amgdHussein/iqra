part of 'connection_bloc.dart';

@immutable
abstract class InternetConnectionEvent extends Equatable {}

class ListenConnection extends InternetConnectionEvent {
  @override
  List<Object?> get props => [];
}

class ConnectionChanged extends InternetConnectionEvent {
  final bool isConnected;

  ConnectionChanged(this.isConnected);

  @override
  String toString() => 'ConnectionChanged(connection: $isConnected)';

  @override
  List<Object> get props => [isConnected];
}

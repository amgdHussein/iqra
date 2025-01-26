part of 'connection_bloc.dart';

class InternetConnectionState extends Equatable {
  final bool isConnected; // Determine if the app has connection or not

  const InternetConnectionState({required this.isConnected});

  factory InternetConnectionState.initial() {
    // Assume initially connected.
    return InternetConnectionState(isConnected: true);
  }

  @override
  String toString() => 'ConnectionState(connection: $isConnected)';

  @override
  List<Object?> get props => [isConnected];
}

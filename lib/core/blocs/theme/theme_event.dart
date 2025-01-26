part of 'theme_bloc.dart';

abstract class ThemeEvent extends Equatable {
  const ThemeEvent();

  @override
  List<Object> get props => [];
}

class ThemeChanged extends ThemeEvent {
  final Mode mode;
  const ThemeChanged({required this.mode});

  @override
  String toString() => 'ThemeChanged(mode: $mode)';

  @override
  List<Object> get props => [mode];
}

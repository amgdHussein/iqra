import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../enums/theme_mode.dart';
import '../../themes/theme_manager.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  final ThemeData theme;

  ThemeBloc(this.theme) : super(ThemeState(theme: theme)) {
    on<ThemeChanged>((event, emit) async {
      await ThemeManager.setTheme(event.mode);
      emit(ThemeState.change(mode: event.mode));
    });
  }
}

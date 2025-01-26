import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../enums/theme_mode.dart';
import '../../themes/theme_manager.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  final ThemeManager themeManager;

  ThemeBloc(this.themeManager) : super(ThemeState(theme: themeManager.loadTheme())) {
    on<ThemeChanged>((event, emit) async {
      await themeManager.setTheme(event.mode);
      final ThemeData theme = themeManager.getTheme(event.mode);
      emit(ThemeState(theme: theme));
    });
  }
}

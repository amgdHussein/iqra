import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../enums/languages.dart';
import '../../l10n/localization_manager.dart';

part 'localization_event.dart';
part 'localization_state.dart';

class LocalizationBloc extends Bloc<LocalizationEvent, LocalizationState> {
  final LanguageManager languageManager;

  LocalizationBloc(this.languageManager) : super(LocalizationState(locale: languageManager.loadLocalization())) {
    on<LocalizationChanged>((event, emit) async {
      await languageManager.setLocalization(event.language);
      final Locale locale = languageManager.getLocalization(event.language);
      emit(LocalizationState(locale: locale));
    });
  }
}

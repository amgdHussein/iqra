import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

part 'connection_event.dart';
part 'connection_state.dart';

class InternetConnectionBloc extends Bloc<InternetConnectionEvent, InternetConnectionState> {
  StreamSubscription<List<ConnectivityResult>>? _connectivitySubscription;
  final InternetConnectionChecker _internetChecker = InternetConnectionChecker.createInstance();

  InternetConnectionBloc() : super(InternetConnectionState.initial()) {
    on<ListenConnection>((event, emit) {
      _connectivitySubscription = Connectivity().onConnectivityChanged.listen((List<ConnectivityResult> result) async {
        final hasInternet = await _internetChecker.hasConnection;
        add(ConnectionChanged(hasInternet));
      });
    });

    on<ConnectionChanged>((event, emit) {
      emit(InternetConnectionState(isConnected: event.isConnected));
    });
  }

  @override
  Future<void> close() {
    _connectivitySubscription?.cancel(); // Cancel subscription when bloc is closed.
    return super.close();
  }
}

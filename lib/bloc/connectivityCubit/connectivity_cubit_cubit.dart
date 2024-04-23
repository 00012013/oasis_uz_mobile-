import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:oasis_uz_mobile/main.dart';

enum ConnectivityStatus { connected, disconnected }

class ConnectivityCubit extends Cubit<ConnectivityStatus> {
  final Connectivity _connectivity = Connectivity();

  ConnectivityCubit() : super(ConnectivityStatus.connected) {
    _connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
      if (result == ConnectivityResult.none) {
        emit(ConnectivityStatus.disconnected);
        _showNoInternetDialog();
      } else {
        emit(ConnectivityStatus.connected);
      }
    });
  }

  Future<void> checkConnectivity() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      emit(ConnectivityStatus.disconnected);
      _showNoInternetDialog();
    } else {
      emit(ConnectivityStatus.connected);
    }
  }

  void _showNoInternetDialog() {
    showDialog(
      context: navigatorKey.currentContext!,
      builder: (context) => AlertDialog(
        title: const Text('No Internet Connection'),
        content:
            const Text('Please check your network connection and try again.'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}

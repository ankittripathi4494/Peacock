
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'internet_state.dart';

class InternetCubit extends Cubit<InternetState> {
  //! Current Connection Status which is none
  List<ConnectivityResult> _connectionStatus = [ConnectivityResult.none];
  //! Connectivity class object which is responsible for conectivity
  final Connectivity _connectivity = Connectivity();

  InternetCubit() : super(InternetState.internetInitial) {
    // for automatic work call in constructor
    getConnectivity();
  _connectivity.onConnectivityChanged.listen((c) {
      if ((c.contains(ConnectivityResult.wifi)) ||
          (c.contains(ConnectivityResult.ethernet)) ||
          (c.contains(ConnectivityResult.mobile)) ||
          (c.contains(ConnectivityResult.vpn))) {
        emit(InternetState.internetAvailable);
      } else {
        emit(InternetState.internetLost);
      }
    });
  }

  getConnectivity() async {
    _connectionStatus = await (_connectivity.checkConnectivity());

    if ((_connectionStatus.contains(ConnectivityResult.wifi)) ||
        (_connectionStatus.contains(ConnectivityResult.ethernet)) ||
        (_connectionStatus.contains(ConnectivityResult.mobile)) ||
        (_connectionStatus.contains(ConnectivityResult.vpn))) {
      emit(InternetState.internetAvailable);
    } else {
      emit(InternetState.internetLost);
    }
  }
}

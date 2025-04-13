import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_database/firebase_database.dart';
import 'greenhouse_state.dart';

class GreenhouseCubit extends Cubit<GreenhouseState> {
  GreenhouseCubit() : super(GreenhouseState.initial()) {
    fetchSensorData();
  }

  void fetchSensorData() {
    DatabaseReference ref = FirebaseDatabase.instance.ref('sensorData');

    ref.onValue.listen((DatabaseEvent event) {
      final snapshot = event.snapshot;
      if (snapshot.exists && snapshot.value != null) {
        final rawData = snapshot.value as Map;
        final data =
            rawData.map((key, value) => MapEntry(key.toString(), value));

        emit(state.copyWith(sensorData: data, isLoading: false));
      } else {
        emit(state.copyWith(sensorData: {}, isLoading: false));
      }
    }, onError: (error) {
      emit(state.copyWith(isLoading: false, error: error.toString()));
    });
  }
}

import 'package:equatable/equatable.dart';

class GreenhouseState extends Equatable {
  final Map<String, dynamic> sensorData;
  final bool isLoading;
  final String? error;

  const GreenhouseState({
    required this.sensorData,
    required this.isLoading,
    this.error,
  });

  factory GreenhouseState.initial() => const GreenhouseState(
        sensorData: {},
        isLoading: true,
        error: null,
      );

  GreenhouseState copyWith({
    Map<String, dynamic>? sensorData,
    bool? isLoading,
    String? error,
  }) {
    return GreenhouseState(
      sensorData: sensorData ?? this.sensorData,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }

  @override
  List<Object?> get props => [sensorData, isLoading, error];
}

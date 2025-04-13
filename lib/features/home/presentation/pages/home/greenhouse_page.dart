import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plant_app/features/home/presentation/pages/cubits/greenhouse_cubit/greenhouse_cubit.dart';
import 'package:plant_app/features/home/presentation/pages/cubits/greenhouse_cubit/greenhouse_state.dart';
import 'package:plant_app/features/home/presentation/widgets/greenhouse_info_card.dart';

class GreenhousePage extends StatelessWidget {
  const GreenhousePage({super.key});

  List<Map<String, dynamic>> getInfoCards(Map<String, dynamic> sensorData) {
    return [
      {
        'title': 'Temperature',
        'value': '${sensorData['temperature']}°C',
        'icon': Icons.thermostat,
        'color': Colors.orange,
      },
      {
        'title': 'Humidity',
        'value': '${sensorData['humidity']}%',
        'icon': Icons.water_drop,
        'color': Colors.blue,
      },
      {
        'title': 'Light Level',
        'value': '${sensorData['lightLevel']}',
        'icon': Icons.wb_sunny,
        'color': Colors.yellow,
      },
      {
        'title': 'Soil Moisture',
        'value': '${sensorData['soilMoisture']}',
        'icon': Icons.grass,
        'color': Colors.green,
      },
      {
        'title': 'Fan',
        'value': '${sensorData['fanState']}',
        'icon': Icons.air,
        'color': Colors.grey,
      },
      {
        'title': 'Pump',
        'value': '${sensorData['pumpState']}',
        'icon': Icons.water,
        'color': Colors.blueGrey,
      },
      {
        'title': 'Heater',
        'value': '${sensorData['heaterState']}',
        'icon': Icons.fireplace,
        'color': Colors.redAccent,
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GreenhouseCubit(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: const Text('Greenhouse Monitor',
              style: TextStyle(color: Colors.white)),
          centerTitle: true,
        ),
        body: BlocBuilder<GreenhouseCubit, GreenhouseState>(
          builder: (context, state) {
            if (state.isLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state.sensorData.isEmpty) {
              return const Center(child: Text('No data available'));
            } else {
              final infoCards = getInfoCards(state.sensorData);

              return Padding(
                padding: const EdgeInsets.all(16),
                child: ListView.builder(
                  itemCount: infoCards.length,
                  itemBuilder: (context, index) {
                    final card = infoCards[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: GreenhouseInfoCard(
                        title: card['title'],
                        value: card['value'],
                        icon: card['icon'],
                        color: card['color'],
                      ),
                    );
                  },
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

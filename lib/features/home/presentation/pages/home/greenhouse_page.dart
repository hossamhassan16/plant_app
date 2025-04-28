import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plant_app/features/home/presentation/pages/cubits/greenhouse_cubit/greenhouse_cubit.dart';
import 'package:plant_app/features/home/presentation/pages/cubits/greenhouse_cubit/greenhouse_state.dart';
import 'package:plant_app/features/home/presentation/widgets/greenhouse_equiments_card.dart';
import 'package:plant_app/features/home/presentation/widgets/greenhouse_info_card.dart';

class GreenhousePage extends StatelessWidget {
  const GreenhousePage({super.key});

  List<Map<String, dynamic>> getInfoCards(Map<String, dynamic> sensorData) {
    return [
      {
        'title': 'TEMPERATURE',
        'value': '${sensorData['temperature']}°C',
        'icon': Icons.thermostat,
        'color': Colors.orange,
      },
      {
        'title': 'HUMIDITY',
        'value': '${sensorData['humidity']}%',
        'icon': Icons.water_drop,
        'color': Colors.blue,
      },
      {
        'title': 'LIGHT LEVEL',
        'value': '${sensorData['lightLevel']}',
        'icon': Icons.wb_sunny,
        'color': Colors.yellow,
      },
      {
        'title': 'SOIL MOISTURE',
        'value': '${sensorData['soilMoisture']}',
        'icon': Icons.grass,
        'color': Colors.green,
      },
    ];
  }

  List<Map<String, dynamic>> getEquipmentsCards(
      Map<String, dynamic> sensorData) {
    return [
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
      {
        'title': 'Light',
        'value': '${sensorData['lightState']}',
        'icon': Icons.light,
        'color': Colors.redAccent,
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GreenhouseCubit(),
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFE8F5E9), Color(0xFFA5D6A7)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.green,
            title: const Text('Greenhouse Monitor',
                style: TextStyle(color: Colors.white)),
            centerTitle: true,
            iconTheme: const IconThemeData(color: Colors.white),
          ),
          body: BlocBuilder<GreenhouseCubit, GreenhouseState>(
            builder: (context, state) {
              if (state.isLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state.sensorData.isEmpty) {
                return const Center(child: Text('No data available'));
              } else {
                final infoCards = getInfoCards(state.sensorData);
                final equipmentCards = getEquipmentsCards(state.sensorData);

                return SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListView.builder(
                        itemCount: infoCards.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          final card = infoCards[index];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: InfoCard(
                                icon: card['icon'],
                                title: card['title'],
                                value: card['value'],
                                color: card['color']),
                          );
                        },
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Equipments',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                      const SizedBox(height: 10),
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: equipmentCards.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                          childAspectRatio: 1.2,
                        ),
                        itemBuilder: (context, index) {
                          final card = equipmentCards[index];
                          return TweenAnimationBuilder(
                            duration: Duration(milliseconds: 400 + index * 100),
                            tween: Tween<double>(begin: 0, end: 1),
                            builder: (context, double value, child) {
                              return Opacity(
                                opacity: value,
                                child: Transform.scale(
                                  scale: value,
                                  child: EquipmentsCard(
                                    icon: card['icon'],
                                    label: card['title'],
                                    value: card['value'],
                                    color: card['color'],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}

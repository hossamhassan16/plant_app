import 'package:flutter/material.dart';
import 'package:plant_app/features/home/presentation/widgets/greenhouse_info_card.dart';

class GreenhousePage extends StatelessWidget {
  const GreenhousePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text(
          'Greenhouse Monitor',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: const Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            GreenhouseInfoCard(
              title: 'Temperature',
              value: '27°C',
              icon: Icons.thermostat,
              color: Colors.orange,
            ),
            GreenhouseInfoCard(
              title: 'Humidity',
              value: '60%',
              icon: Icons.water_drop,
              color: Colors.blue,
            ),
            GreenhouseInfoCard(
              title: 'Light',
              value: 'High',
              icon: Icons.wb_sunny,
              color: Colors.yellow,
            ),
            GreenhouseInfoCard(
              title: 'Soil Moisture',
              value: 'Moderate',
              icon: Icons.grass,
              color: Colors.green,
            ),
            GreenhouseInfoCard(
              title: 'CO2 Levels',
              value: '400 ppm',
              icon: Icons.cloud,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}

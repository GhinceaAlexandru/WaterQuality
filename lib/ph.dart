import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

final DatabaseReference database = FirebaseDatabase.instance.reference();

class PhDisplayPage extends StatelessWidget {
  const PhDisplayPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<DatabaseEvent>(
        stream: database.child('sensor_data').onValue,
        builder: (BuildContext context, AsyncSnapshot<DatabaseEvent> snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text('Loading...');
          }

          if (!snapshot.hasData || snapshot.data == null) {
            return const Text('No data found.');
          }

          final DataSnapshot data = snapshot.data!.snapshot;

          if (!data.exists) {
            return const Text('No sensor data available.');
          }

          final dynamic sensorData = data.value;
          if (sensorData is Map) {
            final double? pH = sensorData['pH'] as double?;

            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: const Text(
                    "PH Value",
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                Container(
                  alignment: Alignment.center,
                  height: 100,
                  child: Image.asset("assets/ph.png"),
                ),
                const SizedBox(
                  height: 50,
                ),
                Text(
                  '$pH pH',
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Column(
                  children: [
                    if (6.5 <= pH! && pH <= 8.5) ...[
                      const Text(
                        "Good",
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                    ] else ...[
                      const Text(
                        "Poor",
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                    ]
                  ],
                ),
                const Text(
                  'Condition Water',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                Container(
                  alignment: Alignment.topCenter,
                  width: 300,
                  child: RichText(
                    text: TextSpan(
                      style: DefaultTextStyle.of(context).style,
                      children: const <TextSpan>[
                        TextSpan(
                          text:
                              'The U.S. Environmental Protection Agency recommends that the pH level of water sources should be at',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  width: 300,
                  child: RichText(
                    text: TextSpan(
                      style: DefaultTextStyle.of(context).style,
                      children: const <TextSpan>[
                        TextSpan(
                          text:
                              'pH measurement level between 6.5 to 8.5 on a scale that ranges from 0 to 14. The best pH of drinking water sits right in the middle at a 7.',
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }
          return const Text('Invalid sensor data format.');
        },
      ),
    );
  }
}

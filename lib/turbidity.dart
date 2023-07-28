import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

final DatabaseReference database = FirebaseDatabase.instance.reference();

class TurbidityDisplayPage extends StatelessWidget {
  const TurbidityDisplayPage({Key? key}) : super(key: key);

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
            return Text('Loading...');
          }

          if (!snapshot.hasData || snapshot.data == null) {
            return Text('No data found.');
          }

          final DataSnapshot data = snapshot.data!.snapshot;

          if (!data.exists) {
            return Text('No sensor data available.');
          }

          final dynamic sensorData = data.value;
          if (sensorData is Map) {
            final num? turbidity = sensorData['turbidity'] as num?;

            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: const Text(
                    "Turbidity",
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
                  child: Image.asset("assets/turbidity.png"),
                ),
                const SizedBox(
                  height: 50,
                ),
                Text(
                  '${turbidity ?? 'N/A'} NTU',
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
                    if (turbidity != null && turbidity <= 5) ...[
                      Text(
                        "Good",
                        style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.black, // Set text color to green
                        ),
                      ),
                    ] else ...[
                      Text(
                        "Poor",
                        style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.black, // Set text color to red
                        ),
                      ),
                    ]
                  ],
                ),
                const SizedBox(
                  height: 20,
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
                    text: const TextSpan(
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black, // Set text color to black
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text:
                              'The WHO (World Health Organization) establishes that the turbidity of drinking water',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
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
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black, // Set text color to black
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text:
                              'should not be more than 5 NTU and should ideally be below 1 NTU.',
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

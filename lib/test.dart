import 'dart:async';
import 'dart:math';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

final DatabaseReference database = FirebaseDatabase.instance.reference();
final Random random = Random();

void sendRandomSensorData() {
  // Generate random values with 2 decimal places
  final double temperature = _generateRandomValue(min: 16.0, max: 18.0);
  final double pH = _generateRandomValue(min: 6.5, max: 7.0);
  final double TDS = _generateRandomValue(min: 300.0, max: 320.0);
  final double turbidity = _generateRandomValue(min: 2.0, max: 3.0);

  // Prepare the data to be sent
  final Map<String, dynamic> sensorData = {
    'temperature': num.parse(temperature.toStringAsFixed(2)),
    'pH': num.parse(pH.toStringAsFixed(2)),
    'TDS': num.parse(TDS.toStringAsFixed(2)),
    'turbidity': num.parse(turbidity.toStringAsFixed(2)),
  };

  // Send data to Firebase
  database.child('sensor_data').set(sensorData).then((value) {
    print('Sensor data sent successfully!');
  }).catchError((error) {
    print('Failed to send sensor data: $error');
  });
}

double _generateRandomValue({required double min, required double max}) {
  return min + random.nextDouble() * (max - min);
}

Future<void> main() async {
  // Initialize Firebase
  await Firebase.initializeApp();

  // Send random sensor data every 5 seconds
  Timer.periodic(Duration(seconds: 2), (timer) {
    sendRandomSensorData();
  });
}

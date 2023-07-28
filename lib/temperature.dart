import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

final DatabaseReference database = FirebaseDatabase.instance.reference();

class TemperatureDisplayPage extends StatelessWidget {
  const TemperatureDisplayPage({super.key});

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
            return  Text('Loading...');
          }

          if (!snapshot.hasData || snapshot.data == null) {
            return  Text('No data found.');
          }

          final DataSnapshot data = snapshot.data!.snapshot;

          if (!data.exists) {
            return  Text('No sensor data available.');
          }

          final dynamic sensorData = data.value;
          if (sensorData is Map) {
            final double? temperature = sensorData['temperature'] as double?;
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Text(
                      "Temperature",
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),
                  Container(
                    height: 250,
                      child: SfRadialGauge(
                          axes: <RadialAxis>[
                            RadialAxis(minimum: 0, maximum: 100,
                                ranges: <GaugeRange>[
                                  GaugeRange(startValue: 0, endValue: 40, color:Colors.lightBlue),
                                  GaugeRange(startValue: 40,endValue: 70,color: Colors.blueAccent),
                                  GaugeRange(startValue: 70,endValue: 100,color: Colors.blue)],
                                pointers: <GaugePointer>[
                                  NeedlePointer(value: 90)],
                                annotations: <GaugeAnnotation>[
                                  GaugeAnnotation(widget: Container(child:
                                  Text('$temperature°C',style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold))),
                                      angle: 90, positionFactor: 0.5
                                  )]
                            )])
                  ),
                  SizedBox(height: 20,),

                  Column(
                    children: [
                      if (10 <= temperature! && temperature <= 22)...[
                        const Text("Good", style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
                      ]else...[
                        const Text("Poor", style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
                      ]
                    ],
                  ),
                  const Text(
                    'Condition Water',
                    style:  TextStyle(
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
                          TextSpan(text: 'Most desired temperature range for drinking water', style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),
                  Container(
                    alignment: Alignment.centerLeft,
                    width: 300,
                    child: RichText(
                      text: TextSpan(
                        style: DefaultTextStyle.of(context).style,
                        children: const <TextSpan>[
                          TextSpan(text: 'Fahrenheit: 50 and 72 degrees \nCelsius: 10-22 degrees ',style: TextStyle(fontSize: 20),),
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

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class RiversApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: RiversHome(),
    );
  }
}

class RiversHome extends StatefulWidget {
  @override
  _RiversHomeState createState() => _RiversHomeState();
}

class _RiversHomeState extends State<RiversHome> {
  GoogleMapController? mapController; // Controller for Google Map
  Set<Marker> markers = Set(); // Markers for Google Map

  @override
  void initState() {
    addMarkers(); // Add markers to the map
    super.initState();
  }

  void addMarkers() {
    markers.add(Marker(
      markerId: MarkerId("somesul_mic"),
      position: LatLng(46.7671, 22.4805),
      infoWindow: InfoWindow(
        title: 'Someșul Mic',
        snippet: 'Crystal-clear river in the Apuseni Mountains',
      ),
      icon: BitmapDescriptor.defaultMarker,
    ));

    markers.add(Marker(
      markerId: MarkerId("jijia"),
      position: LatLng(47.2719, 26.6852),
      infoWindow: InfoWindow(
        title: 'Jijia River',
        snippet: 'Tributary of the Prut River with clean water',
      ),
      icon: BitmapDescriptor.defaultMarker,
    ));

    markers.add(Marker(
      markerId: MarkerId("cricovul_sarat"),
      position: LatLng(44.9664, 26.0527),
      infoWindow: InfoWindow(
        title: 'Cricovul Sărat',
        snippet: 'Mountain river with pristine water',
      ),
      icon: BitmapDescriptor.defaultMarker,
    ));

    markers.add(Marker(
      markerId: MarkerId("cerna"),
      position: LatLng(44.7746, 22.5689),
      infoWindow: InfoWindow(
        title: 'Cerna River',
        snippet: 'Turquoise river with excellent water quality',
      ),
      icon: BitmapDescriptor.defaultMarker,
    ));

    markers.add(Marker(
      markerId: MarkerId("bistrita"),
      position: LatLng(47.1526, 24.4994),
      infoWindow: InfoWindow(
        title: 'Bistrița River',
        snippet: 'Pristine river with exceptional water purity',
      ),
      icon: BitmapDescriptor.defaultMarker,
    ));

    markers.add(Marker(
      markerId: MarkerId("oas"),
      position: LatLng(47.8164, 23.3553),
      infoWindow: InfoWindow(
        title: 'Oaș River',
        snippet: 'Clean and transparent river for relaxation and fishing',
      ),
      icon: BitmapDescriptor.defaultMarker,
    ));

    markers.add(Marker(
      markerId: MarkerId("lotru"),
      position: LatLng(45.2564, 23.8653),
      infoWindow: InfoWindow(
        title: 'Lotru River',
        snippet: 'Wild river with exceptional water quality',
      ),
      icon: BitmapDescriptor.defaultMarker,
    ));

    markers.add(Marker(
      markerId: MarkerId("prahova"),
      position: LatLng(45.3217, 25.5371),
      infoWindow: InfoWindow(
        title: 'Prahova River',
        snippet: 'River with clear waters and picturesque landscapes',
      ),
      icon: BitmapDescriptor.defaultMarker,
    ));

    markers.add(Marker(
      markerId: MarkerId("apar"),
      position: LatLng(46.0175, 22.2234),
      infoWindow: InfoWindow(
        title: 'Apar River',
        snippet: 'Small river with clean water and scenic beauty',
      ),
      icon: BitmapDescriptor.defaultMarker,
    ));

    markers.add(Marker(
      markerId: MarkerId("cibin"),
      position: LatLng(45.7318, 24.0295),
      infoWindow: InfoWindow(
        title: 'Cibin River',
        snippet: 'River known for its clear and refreshing waters',
      ),
      icon: BitmapDescriptor.defaultMarker,
    ));

    markers.add(Marker(
      markerId: MarkerId("nera"),
      position: LatLng(45.0157, 21.9977),
      infoWindow: InfoWindow(
        title: 'Nera River',
        snippet: 'Pristine river flowing through a national park',
      ),
      icon: BitmapDescriptor.defaultMarker,
    ));

    markers.add(Marker(
      markerId: MarkerId("jiu"),
      position: LatLng(45.1001, 23.2726),
      infoWindow: InfoWindow(
        title: 'Jiu River',
        snippet: 'Important and clean river, a source of power',
      ),
      icon: BitmapDescriptor.defaultMarker,
    ));

    markers.add(Marker(
      markerId: MarkerId("mures"),
      position: LatLng(46.5591, 24.7037),
      infoWindow: InfoWindow(
        title: 'Mureș River',
        snippet: 'Scenic river flowing through Romania and Hungary',
      ),
      icon: BitmapDescriptor.defaultMarker,
    ));

    markers.add(Marker(
      markerId: MarkerId("olt"),
      position: LatLng(44.3684, 24.3529),
      infoWindow: InfoWindow(
        title: 'Olt River',
        snippet: 'Longest river in Romania with clear waters',
      ),
      icon: BitmapDescriptor.defaultMarker,
    ));

    markers.add(Marker(
      markerId: MarkerId("buzau"),
      position: LatLng(45.4273, 26.8494),
      infoWindow: InfoWindow(
        title: 'Buzău River',
        snippet: 'Picturesque river with clean and transparent waters',
      ),
      icon: BitmapDescriptor.defaultMarker,
    ));
    markers.add(Marker(
      markerId: MarkerId("nera"),
      position: LatLng(45.0157, 21.9977),
      infoWindow: InfoWindow(
        title: 'Nera River',
        snippet: 'Pristine river in Nera Gorges-Beușnița National Park',
      ),
      icon: BitmapDescriptor.defaultMarker,
    ));

    markers.add(Marker(
      markerId: MarkerId("izvorul_muntelui"),
      position: LatLng(46.2432, 25.2819),
      infoWindow: InfoWindow(
        title: 'Izvorul Muntelui',
        snippet: 'Scenic reservoir formed by Bicaz Dam',
      ),
      icon: BitmapDescriptor.defaultMarker,
    ));

    markers.add(Marker(
      markerId: MarkerId("oltet"),
      position: LatLng(45.6359, 24.4721),
      infoWindow: InfoWindow(
        title: 'Oltet River',
        snippet: 'Crystal-clear river with beautiful landscapes',
      ),
      icon: BitmapDescriptor.defaultMarker,
    ));
    markers.add(Marker(
      markerId: MarkerId("waterfall_seven_springs"),
      position: LatLng(45.8179, 22.9141),
      infoWindow: InfoWindow(
        title: 'Waterfall of the Seven Springs',
        snippet:
            'A waterfall in the Apuseni Mountains known for its pure and crystal-clear waters.',
      ),
      icon: BitmapDescriptor.defaultMarker,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        zoomGesturesEnabled: true,
        initialCameraPosition: CameraPosition(
          target: LatLng(45.7489, 21.2087),
          zoom: 6.0,
        ),
        markers: markers,
        mapType: MapType.normal,
        onMapCreated: (controller) {
          setState(() {
            mapController = controller;
          });
        },
      ),
    );
  }
}

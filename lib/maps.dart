// import 'package:flutter/material.dart';
// import 'package:flutter_map/flutter_map.dart';
// import 'package:flutter_map_animations/flutter_map_animations.dart';
// import 'package:latlong2/latlong.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       home: const MyHomePage(),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key});

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
//   late final _anim = AnimatedMapController(
//       vsync: this,
//       duration: Duration(
//         milliseconds: 500,
//       ),
//       curve: Curves.easeInOutCubic);
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: FlutterMap(
//         mapController: _anim.mapController,
//         options: MapOptions(
//           center: LatLng(22.76207466026901, 88.35567139947311),
//           zoom: 15,
//         ),
//         children: [
//           TileLayer(
//             urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
//             userAgentPackageName: 'com.example.app',
//           ),
//           AnimatedMarkerLayer(
//             markers: [
//               AnimatedMarker(
//                 point: LatLng(51.509364, -0.128928),
//                 builder: (_, __) => Icon(Icons.location_on),
//               ),
//             ],
//           ),
//           Center(
//             child: ElevatedButton(
//                 onPressed: () {
//                   _anim.animateTo(
//                       dest: LatLng(22.953009870005467, 88.3758676288401),
//                       zoom: 15);
//                 },
//                 child: Text("Change")),
//           ),
//           MarkerLayer(
//             markers: [
//               Marker(
//                 point: LatLng(22.953009870005467, 88.3758676288401),
//                 width: 100,
//                 height: 80,
//                 builder: (context) => Icon(
//                   Icons.pin_drop_sharp,
//                   size: 40,
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

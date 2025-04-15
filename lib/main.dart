import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Map App',
      theme: ThemeData(primarySwatch: Colors.blue, fontFamily: 'Roboto'),
      home: MainPage(),
    );
  }
}

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Flexible(
            child: Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.blue,
              child: Center(child: Text("MapWidget")),
            ),
            flex: 5,
          ),
          Flexible(
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: Colors.deepPurpleAccent,
                  child: Column(children: []),
                ),
              ],
            ),
            flex: 5,
          ),
        ],
      ),
    );
  }
}

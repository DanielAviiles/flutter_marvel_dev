import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Marvel Characters - Mobile',
      theme: ThemeData.light().copyWith(
          appBarTheme: const AppBarTheme(
        color: Colors.red,
      )),
      home: Scaffold(
        body: Center(child: Text('Hola mundo')),
      ),
    );
  }
}

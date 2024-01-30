import 'package:flutter/material.dart';

import 'src/ar_scene.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter AR Demo',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const ArScene(),
    );
  }
}

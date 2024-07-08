import 'package:alura/data/task_inherited.dart';
import 'package:alura/screens/initial_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(TaskInherited(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tasks',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TaskInherited(child: const InitialScreen()),
    );
  }
}

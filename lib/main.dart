import 'package:flutter/material.dart';
import 'package:app_odonto/widgets/lista_questionarios.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SB App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 56, 149, 77),
        ),
      ),
      home: const ListaQuestionariosPage(),
    );
  }
}

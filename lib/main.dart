import 'package:flutter/material.dart';
import 'package:target_technical_challenge/view/login_widget.dart';
import 'package:target_technical_challenge/view/text_list_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Desafio Target',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routes: {
        ListScreen.route: (context) => ListScreen(),
      },
      home: const LoginScreen(),
    );
  }
}

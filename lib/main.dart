import 'package:flutter/material.dart';
import 'package:pibd31_egorov_pmu/presentation/home_page/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.teal
      ),
      home: const MyHomePage(title: 'Егоров Максим Александрович'),
    );
  }
}

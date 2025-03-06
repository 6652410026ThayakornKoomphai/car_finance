import 'package:car_finance/views/home_ui.dart';
import 'package:flutter/material.dart';

void main(){
  runApp(CarFinanceApp());
}

class CarFinanceApp extends StatefulWidget {
  const CarFinanceApp({super.key});

  @override
  State<CarFinanceApp> createState() => _CarFinanceAppState();
}

class _CarFinanceAppState extends State<CarFinanceApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeUI(),
    );
  }
}
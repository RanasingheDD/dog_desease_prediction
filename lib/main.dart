import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:myapp/pages/home_page.dart';
import 'package:myapp/pages/response_page.dart';
import 'dart:convert';
import 'package:myapp/pages/start_page.dart';
import 'package:myapp/provider/dog_data_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => DogData(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dog Disease Detector',
      home: HomePage(),
    );
  }
}

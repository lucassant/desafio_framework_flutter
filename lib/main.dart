import 'package:desafio_flutter/app_controller.dart';
import 'package:desafio_flutter/db/database.dart';
import 'package:desafio_flutter/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void main() {
  getIt.registerSingleton<MyDatabase>(MyDatabase());
  getIt.registerSingleton<AppController>(AppController());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'models/app_config.dart';
import 'pages/game_page.dart';
import 'pages/home_page.dart';
import 'pages/lecture_page.dart';
import 'services/firebase_service.dart';
import 'services/http_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // TODO: Introduce Firebase
  // await Firebase.initializeApp();
  // GetIt.instance.registerSingleton<FirebaseService>(
  //   FirebaseService(),
  // );
  await loadConfig();
  registerHttpService();
  await Hive.initFlutter("hive_boxes");
  runApp(const MyApp());
}

Future<void> loadConfig() async {
  String configContent = await rootBundle.loadString("assets/config/main.json");
  Map configData = jsonDecode(configContent);
  print(configData);
  GetIt.instance.registerSingleton<AppConfig>(
    AppConfig(COIN_API_BASE_URL: configData["COIN_API_BASE_URL"]),
  );
}

void registerHttpService() {
  GetIt.instance.registerSingleton<HttpService>(
    HttpService(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Ella's Notes",
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      initialRoute: 'home',
      routes: {
        "home": (context) => HomePage(),
        "game": (context) => GamePage(),
      },
    );
  }
}

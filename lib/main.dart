import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'firebase_options.dart';
import 'googlesheet/drive_helper.dart';
import 'models/app_config.dart';
import 'models/chapter.dart';
import 'models/subject.dart';
import 'models/word.dart';
import 'pages/game_page.dart';
import 'ui/home/home_page.dart';
import 'services/firebase_service.dart';
import 'services/http_service.dart';
import 'themes/ellas_notes_theme_data.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  GetIt.instance.registerSingleton<FirebaseService>(
    FirebaseService(),
  );
  await loadConfig();
  registerHttpService();
  await Hive.initFlutter("hive_boxes"); // Hive 파일들 저장할 경로 지정
  Hive.registerAdapter(SubjectAdapter()); // add here
  Hive.registerAdapter(ChapterAdapter());
  Hive.registerAdapter(WordAdapter());

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

  GetIt.instance.registerSingleton<DriveHelper>(
      DriveHelper(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Ella's Notes",
      theme: EllasNotesThemeData.lightThemeData,
      initialRoute: 'home',
      routes: {
        "home": (context) => HomePage(),
        "game": (context) => GamePage(),
      },
      builder: EasyLoading.init(),
    );
  }
}

import 'dart:io';

import 'package:ellas_notes_flutter/services/firebase_service.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'feed_page.dart';
import 'profile_page.dart';

class FinstargramHomePage extends StatefulWidget {
  const FinstargramHomePage({Key? key}) : super(key: key);

  @override
  State<FinstargramHomePage> createState() => _FinstargramHomePageState();
}

class _FinstargramHomePageState extends State<FinstargramHomePage> {
  FirebaseService? _firebaseService;

  int _currentPage = 0;
  final List<Widget> _pages = [
    FeedPage(),
    ProfilePage(),
  ];

  @override
  void initState() {
    super.initState();
    _firebaseService = GetIt.instance.get<FirebaseService>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Finstargram"),
        actions: [
          GestureDetector(
            onTap: _postImage,
            child: const Icon(Icons.add_a_photo),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: GestureDetector(
              onTap: () async {
                await _firebaseService!.logout();
                Navigator.popAndPushNamed(context, 'login');
              },
              child: const Icon(Icons.logout),
            ),
          ),
        ],
      ),
      bottomNavigationBar: _bottomNavigationBar(),
      body: _pages[_currentPage],
    );
  }

  Widget _bottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: _currentPage,
      onTap: (index) {
        print(index);
        setState(() {
          _currentPage = index;
        });
      },
      items: const [
        BottomNavigationBarItem(label: "Feed", icon: Icon(Icons.feed)),
        BottomNavigationBarItem(label: "Profile", icon: Icon(Icons.account_box))
      ],
    );
  }

  void _postImage() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: FileType.image);
    File image = File(result!.files.first.path!);
    await _firebaseService!.postImage(image);
  }
}

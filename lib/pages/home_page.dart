import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../googlesheet/drive_helper.dart';
import '../googlesheet/sheet_helper.dart';
import '../models/subject.dart';
import '../repositories/subject_repository.dart';
import 'chapter_page.dart';
import 'pick_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late double _deviceHeight, _deviceWidth;
  late Future<Box?> subjectBox;
  Box? _box;
  String? _newSheetId;
  DriveHelper? _driveHelper;

  @override
  void initState() {
    super.initState();

    subjectBox = SubjectRepository().openBoxWithPreload();
    _driveHelper = GetIt.instance.get<DriveHelper>();
  }

  FutureOr onGoBack(dynamic value) {
    print("return from PickPage");
    subjectBox = SubjectRepository().openBoxWithPreload();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Ella's Notes"),
        actions: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: GestureDetector(
              onTap: () {
                print("login button");
              },
              child: const Icon(Icons.login),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Scrollbar(
          child: SingleChildScrollView(
            child: Column(
              children: [
                _subjectView(),
                _addView(),
                _bottomView(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _subjectView() {
    return FutureBuilder(
      future: subjectBox,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          _box = snapshot.data;
          return _subjectList();
        } else {
          return SizedBox(
            height: _deviceHeight,
            child: const Center(child: CircularProgressIndicator()),
          );
        }
      },
    );
  }

  Widget _addView() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          OutlinedButton(
            onPressed: _displayAddPopup,
            child: const Text("Add Public Sheet"),
          ),
          OutlinedButton(
            onPressed: () {
              _driveHelper?.signIn();
            },
            child: const Text("Sign in with Google"),
          )
        ],
      ),
    );
  }

  Widget _bottomView() {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, AsyncSnapshot<User?> user) {
        if (user.hasData) {
          return OutlinedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return const PickPage();
                    },
                  ),
                ).then(onGoBack);
              },
              child: const Text("Add Private Sheet"));
        } else {
          return const Text("No User");
        }
      },
    );
  }

  Widget _subjectList() {
    List subjects = _box!.values.toList();

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      // limit height
      shrinkWrap: true,
      // disable scrolling
      primary: false,
      itemCount: subjects.length,
      itemBuilder: (BuildContext context, int index) {
        return _subjectTile(subjects[index]);
      },
    );
  }

  Widget _subjectTile(Subject subject) {
    return Card(
      child: ListTile(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) {
                return ChapterPage(subject: subject);
              },
            ),
          );
        },
        visualDensity: const VisualDensity(vertical: 4),
        title: Text(subject.title),
        leading: Container(
          width: 75,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(subject.imageUrl!), // TODO: Consider null case
              fit: BoxFit.cover,
            ),
            borderRadius: const BorderRadius.all(
              Radius.circular(50),
            ),
          ),
        ),
        // TODO: Consider null case
        subtitle: Text(subject.description!),
        isThreeLine: true,
        trailing: PopupMenuButton(
          onSelected: (value) {
            print("$value command for ${subject.title}");
          },
          itemBuilder: (context) {
            return const [
              PopupMenuItem(
                value: "Delete",
                child: Text('Delete'),
              ),
            ];
          },
        ),
      ),
    );
  }

  void _displayAddPopup() {
    showDialog(
      context: context,
      builder: (BuildContext buildContext) {
        return AlertDialog(
          title: const Text("Add a new subject"),
          content: TextField(
            onSubmitted: (value) async {
              if (_newSheetId != null) {
                EasyLoading.instance.maskType = EasyLoadingMaskType.black;
                EasyLoading.show(status: 'loading...');
                await SheetHelper.fetchSpreadsheet(_newSheetId!, false);
                setState(() {
                  _newSheetId = null;
                  Navigator.pop(context);
                });
                EasyLoading.dismiss();
              }
            },
            decoration: const InputDecoration(hintText: "sheetId..."),
            onChanged: (value) {
              setState(() {
                _newSheetId = value;
              });
            },
          ),
        );
      },
    );
  }
}

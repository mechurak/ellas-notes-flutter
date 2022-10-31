import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../googlesheet/sheet_helper.dart';
import '../models/subject.dart';
import '../repositories/subject_repository.dart';
import 'chapter_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late double _deviceHeight, _deviceWidth;
  Box? _box;
  String? _newSheetId;

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
    );
  }

  Widget _subjectView() {
    return FutureBuilder(
      future: SubjectRepository().openBoxWithPreload(),
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
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("Add Public Sheet"),
            ),
          ),
          OutlinedButton(
            onPressed: () async {
              // Trigger the authentication flow
              final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
              print(googleUser);

              // Obtain the auth details from the request
              final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

              // Create a new credential
              final credential = GoogleAuthProvider.credential(
                accessToken: googleAuth?.accessToken,
                idToken: googleAuth?.idToken,
              );
              print(credential);

              // Once signed in, return the UserCredential
              final userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
              print(userCredential);
            },
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("Add Private Sheet"),
            ),
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
          return const Text("User login");
        } else {
          return const Text("No User");
        }
      },
    );
  }

  Widget _subjectList() {
    List subjects = _box!.values.toList();

    return ListView.separated(
      padding: const EdgeInsets.all(16.0),
      shrinkWrap: true, // limit height
      primary: false, // disable scrolling
      itemCount: subjects.length,
      itemBuilder: (BuildContext context, int index) {
        return _subjectTile(subjects[index]);
      },
      separatorBuilder: (BuildContext context, int index) {
        return const Divider();
      },
    );
  }

  Widget _subjectTile(Subject subject) {
    return ListTile(
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
        // height: 100,
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
      subtitle: Text(subject.description!), // TODO: Consider null case
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
                await SheetHelper.fetchSpreadsheet(_newSheetId!);
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

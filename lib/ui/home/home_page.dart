import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mvvm_plus/mvvm_plus.dart';

import '../../models/subject.dart';
import '../../pages/pick_page.dart';
import '../chapter/chapter_page.dart';
import 'home_viewmodel.dart';

class HomePage extends View<HomeViewModel> {
  String? _newSheetId;

  HomePage({Key? key}) : super(key: key, builder: () => HomeViewModel());

  @override
  Widget build(BuildContext context) {
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
    if (viewModel.subjects.value.isEmpty) {
      double deviceHeight = MediaQuery.of(context).size.height;
      return SizedBox(
        height: deviceHeight * 0.8,
        child: const Center(
          child: Text("No subjects!"),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      // limit height
      shrinkWrap: true,
      // disable scrolling
      primary: false,
      itemCount: viewModel.subjects.value.length,
      itemBuilder: (BuildContext context, int index) {
        return _subjectTile(viewModel.subjects.value[index]);
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
              viewModel.googleSignIn();
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
                );
              },
              child: const Text("Add Private Sheet"));
        } else {
          return const Text("No User");
        }
      },
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
                viewModel.addSubject(_newSheetId!);
              }
            },
            decoration: const InputDecoration(hintText: "sheetId..."),
            onChanged: (value) {
              _newSheetId = value;
            },
          ),
        );
      },
    );
  }
}

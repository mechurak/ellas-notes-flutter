import 'package:ellas_notes_flutter/pages/chapter_page.dart';
import 'package:flutter/material.dart';

import '../models/subject.dart';
import '../repositories/subject_repository.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late double _deviceHeight, _deviceWidth;

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
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: _deviceWidth * 0.05),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _subjectList(),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _subjectList() {
    List subjects = SubjectRepository().getSubjects();
    return Expanded(
      child: ListView.separated(
        itemCount: subjects.length,
        itemBuilder: (BuildContext context, int index) {
          return _subjectTile(subjects[index]);
        },
        separatorBuilder: (BuildContext context, int index) {
          return const Divider();
        },
      ),
    );
  }

  Widget _subjectTile(Subject subject) {
    return ListTile(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) {
              return ChapterPage(subject: subject.title);
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
            image: NetworkImage(subject.imageUrl),
            fit: BoxFit.cover,
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(50),
          ),
        ),
      ),
      subtitle: Text(subject.description),
    );
  }
}

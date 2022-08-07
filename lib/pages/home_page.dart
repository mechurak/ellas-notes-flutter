import 'package:flutter/material.dart';

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
                _lectureList(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _lectureList() {
    List lectures = ['lecture 1', 'lecture 2'];

    return Expanded(
      child: ListView(
        children: [
          ListTile(
            title: Text('Lecture 1'),
            subtitle: Text("temp description"),
            onTap: () {
              setState(() {
                Navigator.pushNamed(context, 'lecture');
              });
            },
            onLongPress: () {
              setState(() {
                Navigator.pushNamed(context, 'game');
              });
            },
          ),
          ListTile(
            title: Text('Lecture 2'),
            subtitle: Text("temp description"),
            onTap: () {
              setState(() {
                Navigator.pushNamed(context, 'lecture');
              });
            },
            onLongPress: () {
              setState(() {
                Navigator.pushNamed(context, 'game');
              });
            },
          ),
        ],
      ),
    );
  }
}

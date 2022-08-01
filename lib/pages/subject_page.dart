import 'package:flutter/material.dart';

class SubjectPage extends StatefulWidget {
  const SubjectPage({Key? key}) : super(key: key);

  @override
  State<SubjectPage> createState() {
    return _SubjectPageState();
  }
}

class _SubjectPageState extends State<SubjectPage> {
  late double _deviceHeight, _deviceWidth;

  String? _newTaskContent;

  _SubjectPageState();

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    print("Input Value: $_newTaskContent");

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: _deviceHeight * 0.15,
        title: const Text(
          "Taskly!",
          style: TextStyle(
            fontSize: 25,
          ),
        ),
      ),
      body: _taskList(),
      floatingActionButton: _addTaskButton(),
    );
  }

  Widget _taskList() {
    return ListView(
      children: [
        ListTile(
          title: const Text(
            "Do Laundry!",
            style: TextStyle(decoration: TextDecoration.lineThrough),
          ),
          subtitle: Text(
            DateTime.now().toString(),
          ),
          trailing: const Icon(
            Icons.check_box_outlined,
            color: Colors.red,
          ),
        ),
      ],
    );
  }

  Widget _addTaskButton() {
    return FloatingActionButton(
      onPressed: _displayTaskPopup,
      child: const Icon(Icons.add),
    );
  }

  void _displayTaskPopup() {
    showDialog(
      context: context,
      builder: (BuildContext _context) {
        return AlertDialog(
          title: const Text("Add New Task!"),
          content: TextField(
            onSubmitted: (_value) {},
            onChanged: (_value) {
              setState(() {
                _newTaskContent = _value;
              });
            },
          ),
        );
      },
    );
  }
}

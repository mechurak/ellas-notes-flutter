import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('ListView inside SingleChildScrollView'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 150,
                color: Colors.red,
                child: const Center(
                  child: Text("Some Widgets"),
                ),
              ),
              ListView.builder(
                shrinkWrap: true, // limit height
                primary: false, // disable scrolling
                itemCount: 10,
                itemBuilder: (context, index) => ListTile(
                  title: Text("Item ${index + 1}"),
                ),
              ),
              Container(
                height: 150,
                color: Colors.green,
                child: const Center(
                  child: Text("Some Widgets"),
                ),
              ),
              Container(
                height: 150,
                color: Colors.blue,
                child: const Center(
                  child: Text("Some Widgets"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

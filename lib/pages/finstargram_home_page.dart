import 'package:flutter/material.dart';

import 'feed_page.dart';
import 'profile_page.dart';

class FinstargramHomePage extends StatefulWidget {
  const FinstargramHomePage({Key? key}) : super(key: key);

  @override
  State<FinstargramHomePage> createState() => _FinstargramHomePageState();
}

class _FinstargramHomePageState extends State<FinstargramHomePage> {
  int _currentPage = 0;
  final List<Widget> _pages = [
    FeedPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Finstargram"),
        actions: [
          GestureDetector(
            onTap: () {},
            child: const Icon(Icons.add_a_photo),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: GestureDetector(
              onTap: () {},
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
}

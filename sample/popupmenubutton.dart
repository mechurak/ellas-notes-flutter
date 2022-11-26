import 'package:flutter/material.dart';

void main() => runApp(const PopupMenuButtonDemo());

class PopupMenuButtonDemo extends StatelessWidget {
  const PopupMenuButtonDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PopupMenuButton Demo',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('PopupMenuButton Demo'),
        ),
        body: const PopupMenuButtonPage(),
      ),
    );
  }
}

// 추가 기능 여러개 일때, enum 으로 관리하는 게 좋아 보임
enum MenuType {
  first,
  second,
  third,
}

class PopupMenuButtonPage extends StatelessWidget {
  const PopupMenuButtonPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListTile(
        title: const Text("Test Item"),
        trailing: PopupMenuButton<MenuType>(  // 오늘의 주인공, PopupMenuButton. 뒤에 <>안에 type 적어주는 게 깔끔해 보임
          // 선택된 버튼에 따라 원하는 로직 수행. (여기서는 SnackBar 표시)
          onSelected: (MenuType result) {
            final snackBar = SnackBar(
              content: Text("$result is selected."),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          },
          // itemBuilder 에서 PopMenuItem 리스트 리턴해줘야 함.
          itemBuilder: (BuildContext buildContext) {
            return [
              for (final value in MenuType.values)
                PopupMenuItem(
                  value: value,
                  child: Text(value.toString()),
                )
            ];
          },
        ),
      ),
    );
  }
}

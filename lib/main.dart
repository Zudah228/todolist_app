import 'package:flutter/material.dart';
import 'package:todolistapp/pages/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'List App',
      debugShowCheckedModeBanner: false,
      color: Colors.blue,
      home: HomePage(),
    );
  }
}

//todo 新しいデータ、dueDateを追加
//todo タスクの詳細設定ページ（新しいページ）の作成

// todo Githubへコミット

//todo completeしていないものだけ表示
//todo 設定で全て表示できるようにする





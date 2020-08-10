import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolistapp/pages/home_page.dart';
import 'db/theme.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => AppTheme(),
      child: MyApp()
  ));
}

class MyApp extends StatefulWidget {
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {

  @override

  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'List App',
      theme: Provider.of<AppTheme>(context).buildTheme(),
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





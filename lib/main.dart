import 'package:flutter/material.dart';
import 'home.dart';
import 'UI/my_theme.dart';



void main() {
  runApp(MyTD2App());
}

class MyTD2App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = MyTheme.dark();
    return MaterialApp(theme: theme, title: 'TD2', home: Home());
  }
}

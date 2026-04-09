import 'package:flutter/material.dart';
import 'package:to_do_app/app_theme.dart';
import 'package:to_do_app/screens/to_do_screen.dart';

void main(){
  runApp(ToDoApp());
}

class ToDoApp extends StatelessWidget {
  const ToDoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'To Do App',
      theme: AppTheme.lightTheme,
      themeMode: ThemeMode.light,
      home: const ToDoScreen(),
    );
  }
}
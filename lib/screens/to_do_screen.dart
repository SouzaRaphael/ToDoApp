import 'package:flutter/material.dart';
import 'package:to_do_app/models/task.dart';

class ToDoScreen extends StatefulWidget {
  const ToDoScreen({super.key});

  @override
  State<ToDoScreen> createState() => _ToDoScreenState();
}

class _ToDoScreenState extends State<ToDoScreen> {
  List<Task> taskList = [
    Task(name: "Teste", done: false),
    Task(name: "Teste", done: false),
    Task(name: "Teste", done: false)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: Text("To do", style: Theme.of(context).textTheme.headlineMedium,)
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: taskList.length,
                  itemBuilder: (context, index) => taskList.isNotEmpty 
                  ? Text(taskList[index].name)
                  : Text("texto")
                )
              ),
              TextField(
                cursorColor: Colors.black,
                style: TextStyle(
                  color: Colors.black
                ),
                decoration: InputDecoration(
                  prefixIconColor: Colors.black,
                  prefixIcon: Icon(Icons.add)
                )
              ),
            ],
          ),
        )
      ),
    );
  }
}
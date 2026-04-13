import 'package:flutter/material.dart';
import 'package:to_do_app/models/task.dart';

class ToDoScreen extends StatefulWidget {
  const ToDoScreen({super.key});

  @override
  State<ToDoScreen> createState() => _ToDoScreenState();
}

class _ToDoScreenState extends State<ToDoScreen> {
  List<Task> taskList = [];

  final inputController = TextEditingController();

  @override
  void initState() {
    super.initState();
    inputController.addListener(() => setState(() {}));
  }

  void addTask(String taskName) {
    setState(() {
      taskList.add(Task(name: taskName, done: false));
      inputController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final iconTheme = Theme.of(context).iconTheme;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            spacing: 20,
            children: [
              SizedBox(
                width: double.infinity,
                child: Text("To Do app", style: textTheme.headlineMedium,)
              ),
              Expanded(
                child: taskList.isNotEmpty 
                ? ListView.builder(
                  itemCount: taskList.length,
                  itemBuilder: (context, index) => Card(child: Row(
                    children: [
                      Checkbox(
                        value: taskList[index].done, 
                        onChanged: (value) => setState(() {
                          taskList[index].done = value!;
                        })
                      ),
                      SizedBox(width: 8),
                      Expanded(child: Text(taskList[index].name)),
                      IconButton(
                        onPressed: () => setState(() {
                          taskList.removeAt(index);
                        }),
                        icon: Icon(Icons.delete_outline)
                      )
                    ],
                  ))
                )
                : Center(child: Text("No task added", style: textTheme.titleMedium,))
              ),
              TextField(
                controller: inputController,
                onSubmitted: (value) => addTask(value),
                decoration: InputDecoration(
                  prefixIcon: IconTheme(data: iconTheme, child: Icon(Icons.add)),
                  hintText: "Add a task...",
                  suffixIcon: inputController.text.isNotEmpty
                  // ? Icon(Icons.send, color: Theme.of(context).primaryColor)
                  ? IconButton(
                    onPressed: () => addTask(inputController.text), 
                    icon: Icon(Icons.send, color: Theme.of(context).primaryColor)
                  )
                  : null
                )
              ),
            ],
          ),
        )
      ),
    );
  }
}
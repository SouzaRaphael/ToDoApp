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

  final FocusNode _focusNode = FocusNode();

  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  @override
  void initState() {
    super.initState();
    inputController.addListener(() => setState(() {}));
  }

  void addTask(String taskName) {
    setState(() {
      taskList.add(Task(name: taskName, done: false));
      _listKey.currentState?.insertItem(taskList.length - 1, duration: const Duration(milliseconds: 300));
      inputController.clear();
      _focusNode.requestFocus();
    });
  }

  void removeTask(int index) {
    final removedTask = taskList[index];

    _listKey.currentState?.removeItem(
      index,
      (context, animation) => SizeTransition(
        sizeFactor: animation,
        child: Card(
          child: Row(
            children: [
              Checkbox(value: removedTask.done, onChanged: null),
              const SizedBox(width: 8),
              Expanded(child: Text(removedTask.name)),
              const IconButton(
                onPressed: null,
                icon: Icon(Icons.delete_outline),
              ),
            ],
          ),
        ),
      ),
      duration: const Duration(milliseconds: 300),
    );

    setState(() {
      taskList.removeAt(index);
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
                child: Text("To Do app", style: textTheme.headlineMedium),
              ),
              Expanded(
                child: Stack(
                  children: [
                    AnimatedList(
                      key: _listKey,
                      initialItemCount: taskList.length,
                      itemBuilder: (context, index, animation) =>
                          SizeTransition(
                            sizeFactor: animation,
                            child: Card(
                              child: Row(
                                children: [
                                  Checkbox(
                                    value: taskList[index].done,
                                    onChanged: (value) => setState(() {
                                      taskList[index].done = value!;
                                    }),
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(child: Text(taskList[index].name)),
                                  IconButton(
                                    onPressed: () => removeTask(index),
                                    icon: const Icon(Icons.delete_outline),
                                  ),
                                ],
                              ),
                            ),
                          ),
                    ),
                    if (taskList.isEmpty)
                      Center(child: Text("No task added", style: textTheme.titleMedium))
                  ],
                ),
              ),
              TextField(
                controller: inputController,
                onSubmitted: (value) => addTask(value),
                focusNode: _focusNode,
                decoration: InputDecoration(
                  prefixIcon: IconTheme(
                    data: iconTheme,
                    child: Icon(Icons.add),
                  ),
                  hintText: "Add a task...",
                  suffixIcon: inputController.text.isNotEmpty
                      // ? Icon(Icons.send, color: Theme.of(context).primaryColor)
                      ? IconButton(
                          onPressed: () => addTask(inputController.text),
                          icon: Icon(
                            Icons.send,
                            color: Theme.of(context).primaryColor,
                          ),
                        )
                      : null,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

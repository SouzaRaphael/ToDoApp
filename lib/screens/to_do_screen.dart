import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:to_do_app/components/task_card.dart';
import 'package:to_do_app/models/task.dart';

class ToDoScreen extends StatefulWidget {
  const ToDoScreen({super.key});

  @override
  State<ToDoScreen> createState() => _ToDoScreenState();
}

class _ToDoScreenState extends State<ToDoScreen> {
  late final SharedPreferences prefs;

  // List<Task> taskList = prefs.getStringList('tasks').map((taskName) => Task(name: taskName, done: false)).toList();
  List<Task> taskList = [];

  int get totalTasksDone => taskList.where((t) => t.done).toList().length;

  final _inputController = TextEditingController();

  final FocusNode _focusNode = FocusNode();

  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  Future<void> initSharedPrefs() async {
    prefs = await SharedPreferences.getInstance();
  }

  @override
  void initState() {
    super.initState();
    initSharedPrefs();
    _inputController.addListener(() => setState(() {}));
  }

  void markAsDone(Task task, bool value) {
    setState(() {
      task.done = value;
    });
  }

  void addTask(String taskName) {
    setState(() {
      if (_inputController.text.isNotEmpty) {
        taskList.add(Task(name: taskName, done: false));
        _listKey.currentState?.insertItem(taskList.length - 1, duration: const Duration(milliseconds: 300));
        _inputController.clear();
      }
      _focusNode.requestFocus();
    });
  }

  void removeTask(Task removedTask) {
    if (!taskList.contains(removedTask))
      return;

    int index = taskList.indexOf(removedTask);

    setState(() {
      _listKey.currentState?.removeItem(
        index,
        (context, animation) => TaskCard(
          animation: animation, 
          task: removedTask, 
          markAsDone: markAsDone, 
          removeTask: removeTask
        ),
        duration: const Duration(milliseconds: 300),
      );
      taskList.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final iconTheme = Theme.of(context).iconTheme;

    void deleteAllDoneTasks() {
      [...taskList].where((t) => t.done).forEach((t) => removeTask(t));
    }

    void deleteAllTasks() {
      [...taskList].forEach((t) => removeTask(t));
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text("To Do app", style: textTheme.headlineMedium),
            SizedBox(width: 8),
            Text("$totalTasksDone/${taskList.length}", style: textTheme.titleMedium)
          ],
        ),
        actions: [
          PopupMenuButton(
            icon: Icon(Icons.more_horiz),
            onSelected: (value) => setState(() {
              value();
            }),
            itemBuilder: (BuildContext context) => <PopupMenuEntry>[
              PopupMenuItem(
                value: deleteAllDoneTasks,
                child: const Text('Delete all done'),
              ),
              PopupMenuItem(
                value: deleteAllTasks,
                child: const Text('Delete all'),
              ),
            ]
          )
        ],
      ),
      body: SafeArea(

        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            spacing: 20,
            children: [
              Expanded(
                child: Stack(
                  children: [
                    AnimatedList(
                      key: _listKey,
                      initialItemCount: taskList.length,
                      itemBuilder: (context, index, animation) => TaskCard(
                        animation: animation, 
                        task: taskList[index], 
                        markAsDone: markAsDone, 
                        removeTask: removeTask
                      ),
                    ),
                    if (taskList.isEmpty)
                      Center(child: Text("No task added", style: textTheme.titleMedium))
                  ],
                ),
              ),
              TextField(
                controller: _inputController,
                onSubmitted: (value) => addTask(value),
                focusNode: _focusNode,
                decoration: InputDecoration(
                  prefixIcon: IconTheme(
                    data: iconTheme,
                    child: Icon(Icons.add),
                  ),
                  hintText: "Add a task...",
                  suffixIcon: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 500),
                    reverseDuration: const Duration(milliseconds: 500),
                    switchInCurve: Curves.elasticOut,
                    switchOutCurve: Curves.easeInBack,
  
                    transitionBuilder: (child, animation) {
                      final slideAnimation = Tween<Offset>(
                        begin: const Offset(0.4, 0),
                        end: Offset.zero,
                      ).animate(animation);
  
                      return FadeTransition(
                        opacity: animation,
                        child: SlideTransition(
                          position: slideAnimation,
                          child: ScaleTransition(scale: animation, child: child),
                        ),
                      );
                    },
  
                    child: _inputController.text.isNotEmpty
                        ? IconButton(
                            key: const ValueKey("send_icon"),
                            icon: Icon(
                              Icons.send,
                              color: Theme.of(context).primaryColor,
                            ),
                            onPressed: () => addTask(_inputController.text),
                          )
                        : null
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
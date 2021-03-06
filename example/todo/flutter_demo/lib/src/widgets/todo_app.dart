import 'package:flutter/material.dart';
import 'package:flutter_demo/src/modules/todo_module.dart';
import 'package:flutter_demo/src/widgets/todo_list_smart.dart';
import 'package:summon/summon.dart';

class TodoApp extends StatelessWidget {
  const TodoApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext _) {
    return MaterialApp(
      title: 'Clerk package demo',
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
      ),
      home: const InjectorProvider(
        initialize: initializeTodoModule,
        child: TodoList(),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_demo/src/clerk_helpers/clerk.dart';
import 'package:flutter_demo/src/module_helpers/module.dart';
import 'package:flutter_demo/src/modules/todo_module.dart';
import 'package:flutter_demo/src/utils/build_context_utils.dart';
import 'package:flutter_demo/src/widgets/todo_list.dart';

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
      home: ModuleProvider(
        initializers: const [initializeTodoModule],
        builder: (context) {
          return StoreProvider(
            store: context.resolve(),
            child: const TodoList(),
          );
        },
      ),
    );
  }
}

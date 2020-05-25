import 'package:clerk/clerk.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/src/clerk_helpers/clerk.dart';
import 'package:flutter_demo/src/module_helpers/module.dart';
import 'package:flutter_demo/src/modules/todo_module.dart';
import 'package:flutter_demo/src/widgets/todo_list.dart';

class TodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Clerk package demo',
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
      ),
      home: ModuleBuilder(
        initializers: const [initializeTodoModule],
        builder: (context) {
          final store = context.get<Store>();

          return StoreProvider(
            store: store,
            child: const TodoList(),
          );
        },
      ),
    );
  }
}

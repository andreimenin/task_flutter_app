import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:task_flutter_app/data/task_inherited.dart';
import 'package:task_flutter_app/routes.dart';
import 'package:task_flutter_app/screens/initial_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      useInheritedMediaQuery: true,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: routes,
      // home: TaskInherited(child: const InitialScreen(),),
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case '/':
          case '/initial_screen':
            return MaterialWithModalsPageRoute(
                builder: (_) => const InitialScreen(), settings: settings);
        }
      },
    );
  }
}

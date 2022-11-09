import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            alignment: AlignmentDirectional.center,
            children: [
              Container(color: Colors.redAccent, height: 100, width: 100,),
              Container(color: Colors.blueAccent, height: 50, width: 50,),
            ],
          ),
          Stack(
            alignment: AlignmentDirectional.center,
            children: [
              Container(color: Colors.blueAccent, height: 100, width: 100,),
              Container(color: Colors.redAccent, height: 50, width: 50,),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(color: Colors.orange, height: 50, width: 50,),
              Container(color: Colors.pinkAccent, height: 50, width: 50,),
              Container(color: Colors.purple, height: 50, width: 50,),
            ]
          )
        ]
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:teslacaranimation/constanins.dart';

import 'screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}


class MyApp extends StatelessWidget{
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: titleApp,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.black
      ),
      home: HomeScreen(),
    );
  }
}

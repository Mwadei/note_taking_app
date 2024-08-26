import 'package:flutter/material.dart';
import 'package:note_taking/Screens/add_note.dart';
import 'package:note_taking/Screens/home_screen.dart';
import 'package:note_taking/Screens/view_note.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      routes: {
        "/": (context) => HomeScreen(),
        "/add_note": (context) => AddNote(),
        "/view_note" :(context) => ViewNote(),
      },
    );
  }
}

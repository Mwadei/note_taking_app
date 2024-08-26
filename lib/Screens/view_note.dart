import 'package:flutter/material.dart';
import 'package:note_taking/database/database_services.dart';
import 'package:note_taking/model/notes.dart';

class ViewNote extends StatelessWidget {
  const ViewNote({super.key});

  @override
  Widget build(BuildContext context) {
    final Note note = ModalRoute.of(context)?.settings.arguments as Note;
    return Scaffold(
      appBar: AppBar(
        title: Text(note.title),
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              DatabaseServices().deleteNote(note.id!);
              Navigator.pushNamedAndRemoveUntil(context, "/", (route) => false);
            },
          )
        ],
      ),
      body: Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            note.content,
            style: TextStyle(fontSize: 18.0),
          )),
    );
  }
}

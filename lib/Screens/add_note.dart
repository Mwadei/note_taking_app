import 'package:flutter/material.dart';
import 'package:note_taking/database/database_services.dart';
import 'package:note_taking/model/notes.dart';

class AddNote extends StatefulWidget {
  const AddNote({super.key});

  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  late String title;
  late String content;
  late DateTime dateTime;

  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  addNote(Note note) async {
    DatabaseServices().insertNote(note);
    print("note added successfully");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add note"),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.00),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Note Title",
              ),
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: contentController,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Content",
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          setState(() {
            title = titleController.text;
            content = contentController.text;
            dateTime = DateTime.now();
          });

          Note note =
              Note(title: title, content: content, creationDate: dateTime);

          addNote(note);
          Navigator.pushNamedAndRemoveUntil(context, "/", (route) => false);
        },
        label: Text("Save Note"),
        icon: Icon(Icons.save),
      ),
    );
  }
}

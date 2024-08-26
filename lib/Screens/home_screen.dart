import 'package:flutter/material.dart';
import 'package:note_taking/database/database_services.dart';
import 'package:note_taking/model/notes.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //getting notes
  Future<List<Map<String, dynamic>>> getNotes() async {
    final notes = await DatabaseServices().getNotes();
    return notes;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes'),
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.search))],
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: getNotes(),
        builder: (context, note) {
          switch (note.connectionState) {
            case ConnectionState.none:
              return Center(
                child: Text('No connection', style: TextStyle(fontSize: 18)),
              );
            case ConnectionState.waiting:
              return Center(
                child: CircularProgressIndicator(),
              );
            case ConnectionState.active:
              return Center(
                child: Text('Loading...', style: TextStyle(fontSize: 18)),
              );
            case ConnectionState.done:
              {
                if (note.data!.isEmpty) {
                  return Center(
                    child: Text('Enter Note', style: TextStyle(fontSize: 18)),
                  );
                } else {
                  return Padding(
                    padding: EdgeInsets.all(10.0),
                    child: ListView.builder(
                      itemCount: note.data!.length,
                      itemBuilder: (context, index) {
                        int id = note.data![index]['id'];
                        String title = note.data![index]['title'];
                        String content = note.data![index]['content'];
                        String creationDate = note.data![index]['creationDate'];

                        return Card(
                          child: ListTile(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                "/view_note",
                                arguments: Note(
                                  title: title,
                                  content: content,
                                  creationDate: DateTime.parse(creationDate),
                                  id: id,
                                ),
                              );
                            },
                            title: Text(title),
                            subtitle: Text(content),
                          ),
                        );
                      },
                    ),
                  );
                }
              }
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, "/add_note");
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

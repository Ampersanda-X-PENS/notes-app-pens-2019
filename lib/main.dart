import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Note> notes = [
    Note()
      ..title = 'Note 1'
      ..description = 'Lorem ipsum dolor sit amet adispicing elit.',
    Note()
      ..title = 'Note 1'
      ..description = 'Lorem ipsum dolor sit amet adispicing elit.',
    Note()
      ..title = 'Note 1'
      ..description = 'Lorem ipsum dolor sit amet adispicing elit.',
    Note()
      ..title = 'Note 1'
      ..description = 'Lorem ipsum dolor sit amet adispicing elit.',
    Note()
      ..title = 'Note 1'
      ..description = 'Lorem ipsum dolor sit amet adispicing elit.'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notes App'),
      ),
      body: ListView.builder(
        itemBuilder: (_, i) {
          return ListTile(
            title: Text(notes[i].title),
            subtitle: Text(notes[i].description),
            onTap: () async {
              Note updatedNote = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => EditPage(editNote: notes[i],),
                ),
              );

              if (updatedNote != null){
                notes[i] = updatedNote;
              }
            },
          );
        },
        itemCount: notes.length,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Note newNote = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => EditPage(editNote: null,),
            ),
          );

          if (newNote != null) {
            setState(() {
              notes.add(newNote);
            });
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class EditPage extends StatefulWidget {
  final Note editNote;

  const EditPage({Key key, @required this.editNote}) : super(key: key);
  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  TextEditingController titleController;
  TextEditingController descriptionController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    titleController = new TextEditingController(text: widget.editNote?.title);
    descriptionController = new TextEditingController(text: widget.editNote?.description);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(
              context,
              Note()
                ..title = titleController.text
                ..description = descriptionController.text);
        },
        child: Icon(Icons.save),
      ),
      appBar: AppBar(
        title: Text('EditPage'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: titleController,
              decoration: InputDecoration(hintText: 'Judul'),
            ),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(hintText: 'Deskripsi'),
            ),
          ],
        ),
      ),
    );
  }
}

class Note {
  String title, description;
}

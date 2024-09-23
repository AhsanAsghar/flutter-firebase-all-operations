import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/mynotesApp/note_card.dart';
import 'package:firebase/mynotesApp/note_model/note_model.dart';
import 'package:firebase/mynotesApp/note_screen.dart';
import 'package:flutter/material.dart';

class NoteHomeScreen extends StatefulWidget {
  const NoteHomeScreen({super.key});

  @override
  State<NoteHomeScreen> createState() => _NoteHomeScreenState();
}

class _NoteHomeScreenState extends State<NoteHomeScreen> {
  final CollectionReference myNotes =
      FirebaseFirestore.instance.collection("Notes");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          "My Notes App",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: myNotes.snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }
            final notes = snapshot.data!.docs;
            List<NoteCard> noteCards = [];
            for (var note in notes) {
              var data = note.data() as Map<String, dynamic>?;
              if (data != null) {
                Note noteObject = Note(
                    createdAt: data.containsKey('createdAt')
                        ? (data['createdAt'] as Timestamp).toDate()
                        : DateTime.now(),
                    updatedAt: data.containsKey('updatedAt')
                        ? (data['updatedAt'] as Timestamp).toDate()
                        : (data['createdAt'] as Timestamp).toDate(),
                    note: data['note'] ?? "",
                    id: note.id,
                    title: data['title'] ?? "",
                    color:
                        data.containsKey('color') ? data['color'] : 0xFFFFFFFF);
                noteCards.add(NoteCard(
                    note: noteObject,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  NoteScreen(note: noteObject)));
                    }));
              }
            }
            return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10),
                itemCount: noteCards.length,
                itemBuilder: (context, index) {
                  return noteCards[index];
                },
                padding: EdgeInsets.all(3));
          }),
      floatingActionButton: FloatingActionButton.large(
        backgroundColor: Colors.deepPurple,
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => NoteScreen(
                      note: Note(
                          createdAt: DateTime.now(),
                          updatedAt: DateTime.now(),
                          note: '',
                          id: '',
                          title: ''))));
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}

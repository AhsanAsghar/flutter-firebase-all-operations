import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/mynotesApp/note_model/note_model.dart';
import 'package:flutter/material.dart';

class NoteScreen extends StatefulWidget {
  final Note note;
  const NoteScreen({super.key, required this.note});

  @override
  State<NoteScreen> createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  late TextEditingController titleController;
  late TextEditingController noteController;
  late Note note;
  String titleString = '';
  String noteString = '';
  late int color;
  final CollectionReference myNotes =
      FirebaseFirestore.instance.collection("Notes");

  @override
  void initState() {
    super.initState();
    // TODO: implement setState
    note = widget.note;
    titleString = note.title;
    noteString = note.note;
    color = note.color == 0xFFFFFFFF ? generateRandomLightColor() : note.color;
    titleController = TextEditingController(text: titleString);
    noteController = TextEditingController(text: noteString);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey,
                  ),
                  child: BackButton(
                    color: Colors.white,
                  ),
                ),
                Text(
                  note.id.isEmpty ? 'Add Note' : 'Update Note',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey,
                    ),
                    child: Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              SaveNotes();
                              Navigator.pop(context);
                            },
                            icon: Icon(
                              Icons.save,
                              color: Colors.white,
                            )),
                        if (note.id.isNotEmpty)
                          IconButton(
                              onPressed: () {
                                myNotes.doc(note.id).delete();
                                Navigator.pop(context);
                              },
                              icon: Icon(
                                Icons.delete,
                                color: Colors.white,
                              )),
                      ],
                    )),
              ],
            ),
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Note Title",
              ),
              onChanged: (value) {
                titleString = value;
              },
            ),
            Expanded(
              child: TextField(
                controller: noteController,
                maxLines: null,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Notes",
                ),
                onChanged: (value) {
                  noteString = value;
                },
              ),
            )
          ],
        ),
      )),
    );
  }

  void SaveNotes() async {
    DateTime now = DateTime.now();
    if (note.id.isEmpty) {
      await myNotes.add({
        'title': titleString,
        'note': noteString,
        'color': color,
        'createdAt': now,
      });
    } else {
      await myNotes.doc(note.id).update({
        'title': titleString,
        'note': noteString,
        'color': color,
        'updatedAt': now,
      });
    }
  }
}

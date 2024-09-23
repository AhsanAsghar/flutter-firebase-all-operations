import 'package:firebase/mynotesApp/note_model/note_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NoteCard extends StatefulWidget {
  final Note note;
  final VoidCallback onPressed;
  const NoteCard({super.key, required this.note, required this.onPressed});

  @override
  State<NoteCard> createState() => _NoteCardState();
}

class _NoteCardState extends State<NoteCard> {
  late String formattedDateTime;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    DateTime displayTime = widget.note.updatedAt.isAfter(widget.note.createdAt)
        ? widget.note.updatedAt
        : widget.note.createdAt;
    formattedDateTime = DateFormat('h:mma MMMM d,y').format(displayTime);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      child: Card(
        color: Color(widget.note.color),
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.note.title,
                maxLines: 2,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    overflow: TextOverflow.ellipsis),
              ),
              Row(
                children: [
                  Container(),
                  Text(
                    formattedDateTime,
                    style: TextStyle(fontSize: 12),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Flexible(
                  child: Text(
                widget.note.note,
                maxLines: 4,
                style: TextStyle(
                  fontSize: 17,
                  overflow: TextOverflow.ellipsis,
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}

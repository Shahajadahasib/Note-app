import 'dart:developer';

import 'package:demo2/db/note_db.dart';
import 'package:demo2/models/note_model.dart';
import 'package:demo2/providers/note_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AddNotes extends StatefulWidget {
  const AddNotes({super.key});

  @override
  State<AddNotes> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<AddNotes> {
  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();
  @override
  void dispose() {
    title.dispose();
    description.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w600),
                    controller: title,
                    decoration: InputDecoration(
                      hintText: 'Title',
                      hintStyle: GoogleFonts.lobster(
                        textStyle: const TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      border: OutlineInputBorder(borderSide: BorderSide.none),
                    ),
                  ),
                ),
                IconButton(
                    onPressed: () {
                      var data = NoteModel(
                        id: DateTime.now().millisecondsSinceEpoch.toInt(),
                        title: title.text.trim(),
                        description: description.text.trim(),
                        createTime: DateTime.now().toLocal(),
                      );

                      context.read<NoteProvider>().createnote(data);
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.save))
              ],
            ),
            // TextFormField(
            //   controller: title,
            //   keyboardType: TextInputType.text,
            //   textInputAction: TextInputAction.next,
            //   decoration: const InputDecoration(
            //       border: OutlineInputBorder(), labelText: 'title'),
            //   onSaved: (value) {
            //     title.text = value!;
            //   },
            // ),

            Expanded(
              child: TextField(
                // cursorHeight: 200,
                // maxLength: 10,

                maxLines: 20,
                showCursor: false,
                style: const TextStyle(fontSize: 16),
                controller: description,
                decoration: InputDecoration(
                  hintText: "Write down your note here",
                  hintStyle: GoogleFonts.lobster(
                    textStyle: TextStyle(fontSize: 30),
                  ),
                  border: OutlineInputBorder(borderSide: BorderSide.none),
                ),
              ),
            ),
            // TextFormField(
            //   controller: description,
            //   onSaved: (value) {
            //     title.text = value!;
            //   },
            //   decoration: const InputDecoration(
            //       border: OutlineInputBorder(), labelText: 'description'),
            // ),
          ],
        ),
      ),
    );
  }
}

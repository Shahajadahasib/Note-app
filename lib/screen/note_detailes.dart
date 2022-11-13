import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../models/note_model.dart';
import '../providers/note_provider.dart';
import '../providers/theme_provider.dart';

class NoteDetails extends StatefulWidget {
  // final int noteId;
  const NoteDetails({
    super.key,
  });

  @override
  State<NoteDetails> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<NoteDetails> {
  TextEditingController textcontroller = TextEditingController();
  TextEditingController discripcontroller = TextEditingController();
  // late NoteModel note;
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    discripcontroller.text =
        context.read<NoteProvider>().single_data.description;
    textcontroller.text = context.read<NoteProvider>().single_data.title!;
  }

  // void initlize() async {
  //   await context.read<NoteProvider>().readNote(widget.noteId);
  // }

  @override
  Widget build(BuildContext context) {
    // final values = context.read<NoteProvider>().single_data;

    return WillPopScope(
      onWillPop: () {
        ontapfunction();
        return Future.value(true);
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          leading: InkWell(
            onTap: () {
              ontapfunction();
              Navigator.pop(context);
            },
            child: const Icon(Icons.arrow_back),
          ),
          actions: [
            InkWell(
              onTap: () {
                context.read<ThemeProvider>().setDarkMode =
                    !context.read<ThemeProvider>().isDarkMode;
              },
              child: Icon(context.watch<ThemeProvider>().isDarkMode
                  ? Icons.dark_mode
                  : Icons.light_mode),
            ),
          ],
          centerTitle: true,
          title: const Text('Note'),
        ),
        body: isLoading
            ? const Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  TextField(
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.w400),
                    controller: textcontroller,
                    decoration: InputDecoration(
                      filled: true,
                      hintText: 'Title',
                      hintStyle: GoogleFonts.lobster(
                        textStyle: const TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      border:
                          const OutlineInputBorder(borderSide: BorderSide.none),
                    ),
                  ),
                  Expanded(
                    child: TextField(
                      textAlign: TextAlign.start,
                      expands: true,
                      maxLines: null,
                      textCapitalization: TextCapitalization.characters,
                      textAlignVertical: TextAlignVertical.top,
                      showCursor: false,
                      style: const TextStyle(fontSize: 16),
                      controller: discripcontroller,
                      decoration: InputDecoration(
                        filled: true,
                        hintText: "Write down your note here",
                        hintStyle: GoogleFonts.lobster(
                          textStyle: const TextStyle(fontSize: 30),
                        ),
                        border: const OutlineInputBorder(
                            borderSide: BorderSide.none),
                      ),
                    ),
                  )
                ],
              ),
      ),
    );
  }

  void ontapfunction() {
    var data = NoteModel(
      id: context.read<NoteProvider>().viewnoteid,
      title: textcontroller.text.trim(),
      description: discripcontroller.text.trim(),
      createTime: DateTime.now(),
    );
    context.read<NoteProvider>().update(data);
    // Navigator.pop(context);
    log(discripcontroller.text);
  }
}

import 'dart:developer';

import 'package:demo2/db/note_db.dart';
import 'package:demo2/models/note_model.dart';
import 'package:demo2/screen/note_detailes.dart';
import 'package:flutter/material.dart';

class NoteProvider with ChangeNotifier {
  bool _isloading = false;
  bool get isloading => _isloading;

  List<NoteModel> _data = [];
  NoteModel _single_data = NoteModel(
    title: 'title',
    description: 'description',
    createTime: DateTime.now(),
  );
  NoteModel get single_data => _single_data;

  set single_data(NoteModel noteModel) {
    _single_data = noteModel;
    notifyListeners();
  }

  List<NoteModel> get data => _data;

  void get getData async {
    _data = [];

    try {
      var dara = await NotesDatabase.instance.readAllNotes();

      dara.map(
        (e) {
          _data.add(e);
          // log(e.toMap().toString());
        },
      ).toList();
    } catch (e) {
      e.toString();
    }
    log('get data');
    // log(_data.toString());

    notifyListeners();
  }

  void createnote(NoteModel noteModel) async {
    var db = NotesDatabase.instance;
    await db.create(noteModel);
    log('Created note ${noteModel.toMap()}');
    getData;
    notifyListeners();
  }

  Future<NoteModel> readNote(int value) async {
    var db = NotesDatabase.instance;
    var values = await db.readNote(value);
    single_data = values;
    // log(values.toMap().toString());
    notifyListeners();
    return values;
  }

  void update(NoteModel noteModel) async {
    final db = NotesDatabase.instance;
    var updatevalue = await db.update(noteModel);
    getData;
    notifyListeners();
    log(updatevalue.toString());
  }
}
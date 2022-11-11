import 'dart:developer';
// import 'dart:math';

import 'package:demo2/db/note_db.dart';
import 'package:demo2/models/note_model.dart';
import 'package:demo2/screen/note_detailes.dart';
import 'package:flutter/material.dart';

class NoteProvider with ChangeNotifier {
  bool _isloading = false;
  bool get isloading => _isloading;

  List<NoteModel> _data = [];

  List<NoteModel> _listData = [];
  List<NoteModel> get listData => _listData;

  set listData(List<NoteModel> noteModel) {
    _listData = [];
    for (var element in noteModel) {
      _listData.add(element);
    }
  }

  NoteModel _single_data = NoteModel(
    title: 'title',
    description: 'description',
    createTime: DateTime.now(),
  );

  int _viewnoteid = 0;
  int get viewnoteid => _viewnoteid;

  set viewnoteid(int id) {
    _viewnoteid = id;
    readNote(id);
    notifyListeners();
  }

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
    _single_data = values;
    // log(values.toMap().toString());
    // notifyListeners();
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

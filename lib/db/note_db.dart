import 'package:demo2/models/note_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class NotesDatabase {
  static final NotesDatabase instance = NotesDatabase._init();
  static Database? _database;

  NotesDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('notes.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute(
        'CREATE TABLE notes(id TEXT PRIMARY KEY,title TEXT,description TEXT,createTime TEXT)');
  }

  Future create(NoteModel noteModel) async {
    final db = await instance.database;
    await db.insert(
      'notes',
      noteModel.toMap(),
    );
  }

  Future<NoteModel> readNote(int noteid) async {
    final db = await instance.database;
    final maps = await db.query(
      'notes',
      where: 'id = ?',
      whereArgs: [noteid],
    );
    if (maps.isNotEmpty) {
      return NoteModel.fromMap(maps[0]);
    } else {
      throw Exception('ID $noteid not found');
    }
  }

  Future<List<NoteModel>> readAllNotes() async {
    final db = await instance.database;
    final result = await db.query('notes');

    return result.map((json) => NoteModel.fromMap(json)).toList();
  }

  Future<int> update(NoteModel noteModel) async {
    final db = await instance.database;
    return db.update(
      'notes',
      noteModel.toMap(),
      where: 'id = ?',
      whereArgs: [noteModel.id],
    );
  }

  Future<int> delete(NoteModel noteModel) async {
    final db = await instance.database;
    return db.delete(
      'notes',
      where: 'id',
      whereArgs: [noteModel.id],
    );
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}

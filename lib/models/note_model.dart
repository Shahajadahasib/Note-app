import 'package:intl/intl.dart';

class NoteModel {
  final int? id;
  String? title;
  String description;
  DateTime? createTime;

  NoteModel({
    this.id,
    required this.title,
    required this.description,
    required this.createTime,
  });

  factory NoteModel.fromMap(Map<String, dynamic> map) {
    return NoteModel(
      id: int.parse(map['id']),
      title: map['title'],
      description: map['description'],
      createTime: DateFormat.yMd().parse(
        map['createTime'],
      ),
    );
  }
  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "title": title,
      "description": description,
      "createTime": DateFormat.yMd().format(createTime!).toString(),
    };
  }
}

import 'package:json_annotation/json_annotation.dart';

part 'note_model.g.dart';

@JsonSerializable()
class Note {
  int id;
  String tittle;
  String content;
  DateTime createdDate;

  Note({
    required this.id,
    required this.tittle,
    required this.content,
    required this.createdDate,
  });
  factory Note.fromJson(Map<String, dynamic> json) {
    return _$NoteFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$NoteToJson(this);
  }
}

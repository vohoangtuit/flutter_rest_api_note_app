import 'package:flutter/cupertino.dart';

class NoteInsertModify{
  String noteTitle;
  String noteContent;
  NoteInsertModify({
    @required this.noteTitle,
    @required this.noteContent});

  Map<String, dynamic>toJson() {
    return {
      "noteTitle":noteTitle,
      "noteContent":noteContent
    };
  }
}
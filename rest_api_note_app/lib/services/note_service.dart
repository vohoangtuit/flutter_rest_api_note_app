import 'package:rest_api_note_app/models/note_model.dart';

class NotesService{
  List<NoteModel> getNoteList(){
   return[
      new NoteModel(noteID: '1',noteTitle: 'Note 1', createDatetime: DateTime.now(),lastEditDatetime: DateTime.now()),
      new NoteModel(noteID: '2',noteTitle: 'Note 2', createDatetime: DateTime.now(),lastEditDatetime: DateTime.now()),
      new NoteModel(noteID: '3',noteTitle: 'Note 3', createDatetime: DateTime.now(),lastEditDatetime: DateTime.now()),
    ];
  }
}
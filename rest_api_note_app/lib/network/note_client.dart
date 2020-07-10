import 'dart:convert';

import 'package:rest_api_note_app/models/api_response.dart';
import 'package:rest_api_note_app/models/note_insert.dart';
import 'package:rest_api_note_app/models/note_list_model.dart';
import 'package:http/http.dart' as http;
import 'package:rest_api_note_app/models/note_model.dart';

class NotesClient{
  // http://api.notes.programmingaddict.com/swagger/index.html
  static const API ="http://api.notes.programmingaddict.com/";
  static const header={
    'apiKey':'fe8d90c8-c1eb-4446-8abe-911b76065e2f',
    'Content-Type':'application/json'
};
  Future<APIResponse<List<NotesModel>>> getNoteList(){
    return http.get(API+'notes',headers: header)
        .then((data) {
      if(data.statusCode==200){
        final jsonData = json.decode(data.body);
        final notes = <NotesModel>[];
        for(var item in jsonData){
          notes.add(NotesModel.fromJson(item));
        }
        return APIResponse<List<NotesModel>>(data:notes);
      }
      return APIResponse<List<NotesModel>>(error:true, errorMessage:'An error occured');
    }).catchError((_)=>APIResponse<List<NotesModel>>(error:true, errorMessage:'An error occured'));
  }

  Future<APIResponse<NoteModel>> getDetailNote(String noteID){
    return http.get(API+'notes/'+noteID,headers: header)
        .then((data) {
      if(data.statusCode==200){
        final jsonData = json.decode(data.body);
        final note = NoteModel.fromJson(jsonData);
        return APIResponse<NoteModel>(data:note);
      }
      return APIResponse<NoteModel>(error:true, errorMessage:'An error occured');
    }).catchError((_)=>APIResponse<NoteModel>(error:true, errorMessage:'An error occured'));
  }

  Future<APIResponse<bool>> createNote(NoteInsert note){
    return http.post(API+'notes',headers: header, body: json.encode(note.toJson()))
        .then((data) {
      if(data.statusCode==201){
        return APIResponse<bool>(data:true);
      }
      return APIResponse<bool>(error:true, errorMessage:'An error occured');
    }).catchError((_)=>APIResponse<bool>(error:true, errorMessage:'An error occured'));
  }
}
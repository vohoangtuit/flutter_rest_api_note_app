import 'dart:convert';

import 'package:rest_api_note_app/models/api_response.dart';
import 'package:rest_api_note_app/models/note_model.dart';
import 'package:http/http.dart' as http;

class NotesClient{
  // http://api.notes.programmingaddict.com/swagger/index.html
  static const API ="http://api.notes.programmingaddict.com/";
  static const header={
    'apiKey':'fe8d90c8-c1eb-4446-8abe-911b76065e2f'
};
  Future<APIResponse<List<NoteModel>>> getNoteList(){
    return http.get(API+'notes',headers: header)
        .then((data) {
          if(data.statusCode==200){
            final jsonData = json.decode(data.body);
            print("jsonData "+jsonData.toString());
          // print("jsonData "+jsonData);
           //print("data.body "+data.body);
            var noteList = NoteModel.parseNotes(data.body);
            print("noteList "+noteList.toString());
            final notes = <NoteModel>[];

            for(var item in jsonData){
              final note = NoteModel(
                  noteID: item['noteID'],
                  noteTitle: item['noteTitle'],
                  createDateTime: DateTime.parse(item['createDateTime']),
                  latestEditDateTime: item['latestEditDateTime']!=null?DateTime.parse(item['latestEditDateTime']):null,
              );
              notes.add(note);
            }
            return APIResponse<List<NoteModel>>(data:notes);
          }
          return APIResponse<List<NoteModel>>(error:true, errorMessage:'An error occured');
    }).catchError((_)=>APIResponse<List<NoteModel>>(error:true, errorMessage:'An error occured'));
  }
}
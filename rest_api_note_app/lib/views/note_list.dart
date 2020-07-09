import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:rest_api_note_app/models/note_model.dart';
import 'package:rest_api_note_app/services/note_service.dart';
import 'package:rest_api_note_app/views/note_delete.dart';

import 'note_modify.dart';

class NoteList extends StatefulWidget {

  @override
  _NoteListState createState() => _NoteListState();
}

class _NoteListState extends State<NoteList> {
  NotesService get service => GetIt.I<NotesService>();
  List<NoteModel> notes =[];

  String formatDateTime(DateTime dateTime) {
    return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
  }

  @override
  void initState() {
    super.initState();
    notes = service.getNoteList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List of notes'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (_)=> NoteModify(null)));
        },
        child: Icon(Icons.add),
      ),
      body: ListView.separated(
        separatorBuilder: (_, __)=> Divider(height: 1,color: Colors.green,),
        itemBuilder: (_,index){
          return Dismissible(
            key: ValueKey(notes[index].noteID),
            direction:  DismissDirection.startToEnd,
//            onDismissed: (direction){
//            },
            confirmDismiss: (direction)async {

             final result= await showDialog(context: context, builder: (_)=> NoteDelete());
             print(result);
             return result;

            },
            background: Container(
              color: Colors.red,
              padding: EdgeInsets.only(left: 16),
              child: Align(child: Icon(Icons.delete, color: Colors.white,), alignment: Alignment.centerLeft,),
            ),
            child: ListTile(
              title: Text(notes[index].noteTitle, style: TextStyle(color: Theme.of(context).primaryColor),),
               subtitle: Text('Last edited on ${formatDateTime(notes[index].lastEditDatetime)}') ,
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (_)=> NoteModify(notes[index].noteID)));
              },
            ),
          );
        },
        itemCount: notes.isEmpty?0:notes.length,
      ),
    );
  }
}

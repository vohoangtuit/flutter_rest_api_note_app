import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:rest_api_note_app/models/api_response.dart';
import 'package:rest_api_note_app/models/note_list_model.dart';
import 'package:rest_api_note_app/network/note_client.dart';
import 'package:rest_api_note_app/views/note_delete.dart';

import 'note_modify.dart';

class NoteList extends StatefulWidget {

  @override
  _NoteListState createState() => _NoteListState();
}

class _NoteListState extends State<NoteList> {
  NotesClient get api => GetIt.I<NotesClient>();

  APIResponse<List<NotesModel>> _apiResponse;
  bool _isLoading =false;

  String formatDateTime(DateTime dateTime) {
    return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
  }

  @override
  void initState() {
    _fetchNotes();
    super.initState();

  }
  _fetchNotes() async {
    setState(() {
      _isLoading = true;
    });

    _apiResponse = await api.getNoteList();

    setState(() {
      _isLoading = false;
    });
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
          Navigator.of(context).push(MaterialPageRoute(builder: (_)=> NoteModify()))
              .then((value){
                _fetchNotes();

          });
        },
        child: Icon(Icons.add),
      ),
      body: Builder(
        builder: (_){
          if(_isLoading){
            return Center(child: CircularProgressIndicator());
          }
          if(_apiResponse.error){
            return Center(child: Text(_apiResponse.errorMessage));
          }
         return ListView.separated(
            separatorBuilder: (_, __)=> Divider(height: 1,color: Colors.green,),
            itemBuilder: (_,index){
              return Dismissible(
                key: ValueKey(_apiResponse.data[index].noteID),
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
                  title: Text(_apiResponse.data[index].noteTitle, style: TextStyle(color: Theme.of(context).primaryColor),),
                  subtitle: Text('Last edited on ${formatDateTime(_apiResponse.data[index].latestEditDateTime ?? _apiResponse.data[index].createDateTime)}'),
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (_)=> NoteModify(noteID:_apiResponse.data[index].noteID)));
                  },
                ),
              );
            },
            itemCount: _apiResponse.data.isEmpty?0:_apiResponse.data.length,
         );
        },
      ),
    );
  }
}

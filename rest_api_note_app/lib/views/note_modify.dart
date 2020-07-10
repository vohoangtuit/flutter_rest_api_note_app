import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:rest_api_note_app/models/api_response.dart';
import 'package:rest_api_note_app/models/note_model.dart';
import 'package:rest_api_note_app/network/note_client.dart';

class NoteModify extends StatefulWidget {
  final String noteID;
  NoteModify(this.noteID);

  @override
  _NoteModifyState createState() => _NoteModifyState();
}

class _NoteModifyState extends State<NoteModify> {
  NotesClient get api => GetIt.I<NotesClient>();
  APIResponse<NoteModel> _apiResponse;

  bool get isEditing => widget.noteID!=null;

  String errorMessage;
  NoteModel noteModel;
  TextEditingController _titleController = TextEditingController();
  TextEditingController _contentController = TextEditingController();

  bool _isLoading =false;

  @override
  void initState() {
    setState(() {
      _isLoading =true;
    });
    api.getDetailNote(widget.noteID).then((response){
      setState(() {
        _isLoading =false;
      });
      if(response.error){
        errorMessage =response.errorMessage ?? 'Error occurred';
      }
      noteModel = response.data;
      _titleController.text=noteModel.noteTitle;
      _contentController.text=noteModel.noteContent;
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
  //  print("isEditing $isEditing");
    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing==null?'Create note': 'Edit note'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: _isLoading? Center(child: CircularProgressIndicator(),):Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
              labelText: 'Title',
              hintText: 'Note title'
            ),),
            Container(height:15,),
            TextField(
              controller: _contentController,
              decoration: InputDecoration(
                labelText: 'Content',
                hintText: 'Note content'
            ),),
            Container(height:25,),
            SizedBox(
              width: double.infinity,
              height: 45,
              child: RaisedButton(
                child: Text('Submit', style: TextStyle(color: Colors.white, fontSize: 15),),
                color: Theme.of(context).primaryColor,
                onPressed: ()=>{
                  Navigator.of(context).pop(),
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

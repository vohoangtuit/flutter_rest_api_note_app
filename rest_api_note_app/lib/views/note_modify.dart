import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:rest_api_note_app/models/api_response.dart';
import 'package:rest_api_note_app/models/note_insert.dart';
import 'package:rest_api_note_app/models/note_model.dart';
import 'package:rest_api_note_app/network/note_client.dart';

class NoteModify extends StatefulWidget {
  final String noteID;
  NoteModify({this.noteID});

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
    if(isEditing){
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
    }
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
                onPressed: () async{
                  //Navigator.of(context).pop(),
                  setState(() {
                    _isLoading =true;
                  });
                  if(isEditing){
                    handelUpdate();
                  }else{
                    handelInsert();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

   handelInsert() async {
    final note = NoteInsertModify(noteTitle: _titleController.text, noteContent: _contentController.text);
    final result = await api.createNote(note);
    setState(() {
      _isLoading =false;
    });
    final title ='Done';
    final message = result.error? (result.errorMessage??'An Error occurred'): 'You create was a Note';
    showDialog(context: context,
        builder: (_) => AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            FlatButton(
              child: Text("OK"),
              onPressed: (){
                Navigator.of(context).pop();
              },
            )
          ],
        )
    ).then((data) {
      if(result.data){
        Navigator.of(context).pop();
      }
    });
  }
  void handelUpdate()async{
    final note = NoteInsertModify(noteTitle: _titleController.text, noteContent: _contentController.text);
    final result = await api.updateNote(widget.noteID,note);
    setState(() {
      _isLoading =false;
    });
    final title ='Done';
    final message = result.error? (result.errorMessage??'An Error occurred'): 'You updated was a Note';
    showDialog(context: context,
        builder: (_) => AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            FlatButton(
              child: Text("OK"),
              onPressed: (){
                Navigator.of(context).pop();
              },
            )
          ],
        )
    ).then((data) {
      if(result.data){
        Navigator.of(context).pop();
      }
    });
  }
}

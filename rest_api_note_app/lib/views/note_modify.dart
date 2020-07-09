import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NoteModify extends StatelessWidget {
  final String noteID;
  NoteModify(this.noteID);

  bool get isEditing => noteID!=null;


  @override
  Widget build(BuildContext context) {
    print("isEditing $isEditing");
    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing==null?'Create note': 'Edit note'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(decoration: InputDecoration(
              labelText: 'Title',
              hintText: 'Note title'
            ),),
            Container(height:15,),
            TextField(decoration: InputDecoration(
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

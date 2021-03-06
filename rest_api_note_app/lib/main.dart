import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:rest_api_note_app/network/note_client.dart';
import 'package:rest_api_note_app/views/note_list.dart';

void setupLocator(){
  GetIt.I.registerLazySingleton(() => NotesClient());
}
void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'VHT demo List',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
     // home: MyHomePage(),
      home: NoteList(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Note App"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Create Project',
            ),

          ],
        ),
      ),
    );
  }
}

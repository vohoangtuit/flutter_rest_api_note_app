class NoteModel{
  String noteID;
  String noteTitle;
  String noteContent;
  DateTime createDateTime;
  DateTime latestEditDateTime;
  NoteModel({this.noteID, this.noteTitle,this.noteContent, this.createDateTime, this.latestEditDateTime});

  factory NoteModel.fromJson(Map<String, dynamic> item){
    return NoteModel(
      noteID: item['noteID'],
      noteTitle: item['noteTitle'],
      noteContent: item['noteContent'],
      createDateTime: DateTime.parse(item['createDateTime']),
      latestEditDateTime: item['latestEditDateTime']!=null?DateTime.parse(item['latestEditDateTime']):null,);
  }
}
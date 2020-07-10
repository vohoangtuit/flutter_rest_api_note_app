class NotesModel{
  String noteID;
  String noteTitle;
  DateTime createDateTime;
  DateTime latestEditDateTime;
  NotesModel({this.noteID, this.noteTitle, this.createDateTime, this.latestEditDateTime});

  factory NotesModel.fromJson(Map<String, dynamic> item){
    return NotesModel(
        noteID: item['noteID'],
        noteTitle: item['noteTitle'],
        createDateTime: DateTime.parse(item['createDateTime']),
       latestEditDateTime: item['latestEditDateTime']!=null?DateTime.parse(item['latestEditDateTime']):null,);
  }
}
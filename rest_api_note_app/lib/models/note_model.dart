class NoteModel{
  String noteID;
  String noteTitle;
  DateTime createDateTime;
  DateTime latestEditDateTime;
  NoteModel({this.noteID, this.noteTitle, this.createDateTime, this.latestEditDateTime});
}
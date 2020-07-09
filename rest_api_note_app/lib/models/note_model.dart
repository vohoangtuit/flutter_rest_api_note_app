class NoteModel{
  String noteID;
  String noteTitle;
  DateTime createDateTime;
  DateTime latestEditDateTime;
  NoteModel({this.noteID, this.noteTitle, this.createDateTime, this.latestEditDateTime});

  static List<NoteModel> parseNotes(map) {
   // var list = map['data'] as List;
    print("map: "+map);
    var list;
    try {
       list = map[''] as List ;
    }catch (e){
      print("error: "+e.toString());
    }

    print("list: "+list.toString());
    return list.map((note) => NoteModel.fromJson(note)).toList();
  }

  factory NoteModel.fromJson(Map<String, dynamic> json) => NoteModel(
    noteID: json['noteID'],
    noteTitle: json['noteTitle'],
    createDateTime: DateTime.parse(json['createDateTime']),
    latestEditDateTime: json['latestEditDateTime']!=null?DateTime.parse(json['latestEditDateTime']):null,

  );
  Map<String, dynamic> toJson() => {
    "noteTitle": noteTitle,
    "createDateTime": createDateTime,
    "latestEditDateTime": latestEditDateTime,
  };
}
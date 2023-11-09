class Note {
  int? id;
  String? title;

  Note({this.id, required this.title});

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {'title': title};

    if (id != null) {
      map['id'] = id;
    }

    return map;
  }

  Note.fromMap(Map map) {
    id = map['id'];
    title = map['title'];
  }

  factory Note.fromJson(Map<String, dynamic> json) => Note(
    id: json["id"],
    title: json["title"],
  );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
      };
}

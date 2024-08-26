class Note {
  int? id;
  String title;
  String content;
  List<String> tag;
  DateTime? reminderTime;
  DateTime? creationDate;
  bool isPinned;

  Note(
      {this.id,
      required this.title,
      required this.content,
      this.tag = const [],
      this.reminderTime,
      required this.creationDate,
      this.isPinned = false});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'tag': tag.join(','),
      'reminderTime': reminderTime.toString(),
      'creationDate': creationDate.toString(),
      'isPinned': isPinned ? 1 : 0,
    };
  }

  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      id: map['id'],
      title: map['title'],
      content: map['content'],
      tag: map['tag'] != null ? (map['tag'] as String).split(',') : [],
      reminderTime: map['reminderTime'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['reminderTime'])
          : null,
      creationDate: map['creationDate'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['creationDate'])
          : null,
      isPinned: map['isPinned'],
    );
  }
}

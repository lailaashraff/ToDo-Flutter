class Task {
  static const String collectionName = 'tasks';
  String? title;
  String? description;
  DateTime? dateTime;
  bool? isDone;
  String? id;

  Task(
      {required this.title,
      required this.description,
      required this.dateTime,
      this.isDone = false,
      this.id = ''});

  Map<String, dynamic> toFirestore() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'dateTime': dateTime?.millisecondsSinceEpoch,
      'isDone': isDone,
    };
  }

  Task.fromFirestore(Map<String, dynamic> data)
      : this(
            id: data['id'],
            title: data['title'],
            dateTime: DateTime.fromMillisecondsSinceEpoch(data['dateTime']),
            description: data['description'],
            isDone: data['isDone']);
}

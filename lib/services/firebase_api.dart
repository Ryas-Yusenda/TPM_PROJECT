import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseApi {
  static Future<String> createTodo(Todo todo) async {
    final docTodo = FirebaseFirestore.instance.collection('bookmark').doc();

    todo.id = docTodo.id;

    await docTodo.set(todo.toJson());
  }
}

class Todo {
  String id;
  String judul;
  String link;
  String poster;
  String tipe;

  Todo({
    required this.id,
    required this.judul,
    required this.link,
    required this.poster,
    required this.tipe,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'judul': judul,
        'link': link,
        'poster': poster,
        'tipe': tipe,
      };
}

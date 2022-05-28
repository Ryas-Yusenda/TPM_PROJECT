class User {
  String id;
  final String judul;
  final String link;
  final String poster;
  final String tipe;

  User({
    this.id = '',
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
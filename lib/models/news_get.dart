// https://tiendung01023.github.io/json_to_dart/
class BeritaPost {
  BeritaPost({
    required this.success,
    this.message,
    required this.data,
  });

  bool success;
  dynamic message;
  Data data;

  factory BeritaPost.fromJson(Map<String, dynamic> json) => BeritaPost(
        success: json["success"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data.toJson(),
      };
}

class Data {
  Data({
    required this.link,
    required this.image,
    required this.description,
    required this.title,
    required this.posts,
  });

  String link;
  String image;
  String description;
  String title;
  List<Post> posts;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        link: json["link"],
        image: json["image"],
        description: json["description"],
        title: json["title"],
        posts: List<Post>.from(json["posts"].map((x) => Post.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "link": link,
        "image": image,
        "description": description,
        "title": title,
        "posts": List<dynamic>.from(posts.map((x) => x.toJson())),
      };
}

class Post {
  Post({
    required this.link,
    required this.title,
    required this.pubDate,
    required this.description,
    required this.thumbnail,
  });

  String link;
  String title;
  DateTime pubDate;
  String description;
  String thumbnail;

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        link: json["link"],
        title: json["title"],
        pubDate: DateTime.parse(json["pubDate"]),
        description: json["description"],
        thumbnail: json["thumbnail"],
      );

  Map<String, dynamic> toJson() => {
        "link": link,
        "title": title,
        "pubDate": pubDate.toIso8601String(),
        "description": description,
        "thumbnail": thumbnail,
      };
}

// https://tiendung01023.github.io/json_to_dart/
class BeritaPost {
  final bool? success;
  final dynamic message;
  final Data? data;

  BeritaPost({
    this.success,
    this.message,
    this.data,
  });

  BeritaPost.fromJson(Map<String, dynamic> json)
      : success = json['success'] as bool?,
        message = json['message'],
        data = (json['data'] as Map<String, dynamic>?) != null
            ? Data.fromJson(json['data'] as Map<String, dynamic>)
            : null;

  Map<String, dynamic> toJson() =>
      {'success': success, 'message': message, 'data': data?.toJson()};
}

class Data {
  final String? link;
  final String? image;
  final String? description;
  final String? title;
  final List<Posts>? posts;

  Data({
    this.link,
    this.image,
    this.description,
    this.title,
    this.posts,
  });

  Data.fromJson(Map<String, dynamic> json)
      : link = json['link'] as String?,
        image = json['image'] as String?,
        description = json['description'] as String?,
        title = json['title'] as String?,
        posts = (json['posts'] as List?)
            ?.map((dynamic e) => Posts.fromJson(e as Map<String, dynamic>))
            .toList();

  Map<String, dynamic> toJson() => {
        'link': link,
        'image': image,
        'description': description,
        'title': title,
        'posts': posts?.map((e) => e.toJson()).toList()
      };
}

class Posts {
  final String? link;
  final String? title;
  final String? pubDate;
  final String? description;
  final String? thumbnail;

  Posts({
    this.link,
    this.title,
    this.pubDate,
    this.description,
    this.thumbnail,
  });

  Posts.fromJson(Map<String, dynamic> json)
      : link = json['link'] as String?,
        title = json['title'] as String?,
        pubDate = json['pubDate'] as String?,
        description = json['description'] as String?,
        thumbnail = json['thumbnail'] as String?;

  Map<String, dynamic> toJson() => {
        'link': link,
        'title': title,
        'pubDate': pubDate,
        'description': description,
        'thumbnail': thumbnail
      };
}

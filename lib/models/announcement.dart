import 'dart:convert';

Announcement userFromJson(String str) =>
    Announcement.fromJson(json.decode(str));

// String anouncementToJson(Announcement data) => json.encode(data.toJson());

class Announcement {
  final int id;
  final String featured_image;
  final String title;
  final int status;
  final int views;
  final int category_id;
  final String created_at;
  final String updated_at;
  final bool liked_by_auth_user;
  final int likes_count;
  final int likes_count_formatted;
  final int views_count_formatted;
  final List get_announcement_key_moments;

  Announcement({
    required this.title,
    required this.id,
    required this.featured_image,
    required this.status,
    required this.views,
    required this.category_id,
    required this.created_at,
    required this.updated_at,
    required this.liked_by_auth_user,
    required this.likes_count,
    required this.likes_count_formatted,
    required this.views_count_formatted,
    required this.get_announcement_key_moments,
  });

  factory Announcement.fromJson(Map<String, dynamic> json) {
    return Announcement(
      title: json['title'] ?? '',
      id: json['id'] ?? 0,
      featured_image: json['featured_image'] ?? '',
      status: json['status'] ?? 0,
      views: json['views'] ?? 0,
      category_id: json['category_id'] ?? 0,
      created_at: json['created_at'] ?? 0,
      updated_at: json['updated_at'] ?? 0,
      liked_by_auth_user: json['liked_by_auth_user'] ?? false,
      likes_count: json['likes_count'] ?? 0,
      likes_count_formatted: json['likes_count_formatted'] ?? 0,
      views_count_formatted: json['views_count_formatted'] ?? 0,
      get_announcement_key_moments: json['get_announcement_key_moments'] ?? [],
    );
  }

  Map<String, dynamic> toJson() => {
        "title": title,
        "featured_image": featured_image,
        "status": status,
        "category_id": category_id,
        "views": views,
        "id": id,  //       'likes_count_formatted': likesCount,
        'views_count_formatted': viewsCount,
        'liked_by_auth_user': authUserLikes,
        'get_announcement_key_moments': get_announcement_key_moments,
        'liked_users': users,
        "created_at": date
      };
}

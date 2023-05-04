import 'dart:convert';

Announcement userFromJson(String str) =>
    Announcement.fromJson(json.decode(str));

String anouncementToJson(Announcement data) => json.encode(data.toJson());

class Announcement {
  final String title;
  final String featuredImage;
  final int status;
  final int id;
  final int views;
  final int categoryId;
  final String date;
  final int likesCount;
  final int viewsCount;
  final List users;
  final List get_announcement_key_moments;
  final bool authUserLikes;

  Announcement(
      {required this.title,
      required this.likesCount,
      required this.viewsCount,
      required this.users,
      required this.authUserLikes,
      required this.featuredImage,
      required this.status,
      required this.views,
      required this.id,
      required this.categoryId,
      required this.get_announcement_key_moments,
      required this.date});

  factory Announcement.fromJson(Map<String, dynamic> json) {
    return Announcement(
      title: json['title'],
      featuredImage: json['featured_image'],
      status: json['status'],
      views: json['views'],
      categoryId: json['category_id'],
      likesCount: json['likes_count_formatted'],
      viewsCount: json['views_count_formatted'],
      authUserLikes: json['liked_by_auth_user'],
      users: json['liked_users'] ?? [],
      get_announcement_key_moments: json['get_announcement_key_moments'] ?? [],
      id: json['id'],
      date: json['created_at'],
    );
  }

  Map<String, dynamic> toJson() => {
        "title": title,
        "featured_image": featuredImage,
        "status": status,
        "category_id": categoryId,
        "views": views,
        "id": id,
        'likes_count_formatted': likesCount,
        'views_count_formatted': viewsCount,
        'liked_by_auth_user': authUserLikes,
        'get_announcement_key_moments': get_announcement_key_moments,
        'liked_users': users,
        "created_at": date
      };
}

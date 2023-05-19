// To parse this JSON data, do
//
//     final announcement = announcementFromJson(jsonString);

import 'dart:convert';

Announcement announcementFromJson(String str) => Announcement.fromJson(json.decode(str));

String announcementToJson(Announcement data) => json.encode(data.toJson());

class Announcement {
    int id;
    String featuredImage;
    String title;
    int status;
    int views;
    int categoryId;
    dynamic createdAt;
    dynamic updatedAt;
    int likesCount;
    int likesCountFormatted;
    int viewsCountFormatted;
    bool likedByAuthUser;
    List<dynamic> likedUsers;

    Announcement({
        required this.id,
        required this.featuredImage,
        required this.title,
        required this.status,
        required this.views,
        required this.categoryId,
        this.createdAt,
        this.updatedAt,
        required this.likesCount,
        required this.likesCountFormatted,
        required this.viewsCountFormatted,
        required this.likedByAuthUser,
        required this.likedUsers,
    });

    factory Announcement.fromJson(Map<String, dynamic> json) => Announcement(
        id: json["id"],
        featuredImage: json["featured_image"],
        title: json["title"],
        status: json["status"],
        views: json["views"],
        categoryId: json["category_id"],
        createdAt: json["created_at"] ?? "",
        updatedAt: json["updated_at"],
        likesCount: json["likes_count"],
        likesCountFormatted: json["likes_count_formatted"],
        viewsCountFormatted: json["views_count_formatted"],
        likedByAuthUser: json["liked_by_auth_user"],
        likedUsers: List<dynamic>.from(json["liked_users"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "featured_image": featuredImage,
        "title": title,
        "status": status,
        "views": views,
        "category_id": categoryId,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "likes_count": likesCount,
        "likes_count_formatted": likesCountFormatted,
        "views_count_formatted": viewsCountFormatted,
        "liked_by_auth_user": likedByAuthUser,
        "liked_users": List<dynamic>.from(likedUsers.map((x) => x)),
    };
}

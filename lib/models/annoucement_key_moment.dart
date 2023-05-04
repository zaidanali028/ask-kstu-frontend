import 'dart:convert';

KeyMoments keyMomentsFromJson(String str) => KeyMoments.fromJson(json.decode(str));

String keyMomentsToJson(KeyMoments data) => json.encode(data.toJson());

class KeyMoments {
    int id;
    int announcementId;
    String imageSubTitle;
    String image;
    String imageDescription;
    DateTime createdAt;
    DateTime updatedAt;

    KeyMoments({
        required this.id,
        required this.announcementId,
        required this.imageSubTitle,
        required this.image,
        required this.imageDescription,
        required this.createdAt,
        required this.updatedAt,
    });

    factory KeyMoments.fromJson(Map<String, dynamic> json) => KeyMoments(
        id: json["id"],
        announcementId: json["announcement_id"],
        imageSubTitle: json["image_sub_title"],
        image: json["image"],
        imageDescription: json["image_description"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "announcement_id": announcementId,
        "image_sub_title": imageSubTitle,
        "image": image,
        "image_description": imageDescription,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}

// To parse this JSON data, do
//
//     final getPosts = getPostsFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/foundation.dart';

List<GetMyPosts> getPostsFromJson(String str) =>
    List<GetMyPosts>.from(json.decode(str).map((x) => GetMyPosts.fromJson(x)));

String getPostsToJson(List<GetMyPosts> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetMyPosts with ChangeNotifier {
  GetMyPosts({
    this.userId,
    this.id,
    this.title,
    this.body,
  });

  int? userId;
  int? id;
  String? title;
  String? body;

  factory GetMyPosts.fromJson(Map<String, dynamic> json) => GetMyPosts(
    userId: json["userId"],
    id: json["id"],
    title: json["title"],
    body: json["body"],
  );

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "id": id,
    "title": title,
    "body": body,
  };
}

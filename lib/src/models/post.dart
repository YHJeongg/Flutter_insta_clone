// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'instagram_user.dart';

class Post {
  final String? id;
  final String? thumbnail;
  final String? description;
  final int? likeCount;
  final IUser? userInfo;
  final String? uid;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final DateTime? deletedAt;

  Post({
    this.id,
    this.thumbnail,
    this.description,
    this.likeCount,
    this.userInfo,
    this.uid,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  factory Post.init(IUser userInfo) {
    var time = DateTime.now();
    return Post(
      thumbnail: '',
      userInfo: userInfo,
      uid: userInfo.uid,
      description: '',
      createdAt: time,
      updatedAt: time,
      deletedAt: time,
    );
  }

  factory Post.fromJson(String docId, Map<String, dynamic> json) {
    return Post(
      id: json['id'] == null ? '' : json['id'] as String,
      thumbnail: json['thumbnail'] == null ? '' : json['thumbnail'] as String,
      description:
          json['description'] == null ? '' : json['description'] as String,
      likeCount: json['likeCount'] == null ? 0 : json['likeCount'] as int,
      userInfo:
          json['userInfo'] == null ? null : IUser.fromJson(json['userInfo']),
      uid: json['uid'] == null ? '' : json['uid'] as String,
      createdAt: json['createdAt'] == null
          ? DateTime.now()
          : json['createdAt'].toDate(),
      updatedAt: json['updatedAt'] == null
          ? DateTime.now()
          : json['updatedAt'].toDate(),
      deletedAt: json['deletedAt'] == null ? null : json['deletedAt'].toDate(),
    );
  }
}

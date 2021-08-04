import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:reddit_clone/entities/post_entity.dart';
import 'package:reddit_clone/models/post.dart';

class PostsRepository {
  final String endPoint =
      'https://www.reddit.com/r/flutterdev/top.json?count=20';

  @override
  Future<List<Post>>? getPosts() async {
    final response = await http.get(Uri.parse(endPoint));
    if (response.statusCode == 200) {
      final data = List<dynamic>.from(
        json.decode(response.body)['data']['children'].map<dynamic>(
              (dynamic item) => item,
            ),
      );
      List<Post> postList = data.map((doc) {
        return Post.fromEntity(
          PostEntity.fromJson(
            doc['data'],
          ),
        );
      }).toList();
      return postList;
    } else {
      throw "Error on this link";
    }
  }
}

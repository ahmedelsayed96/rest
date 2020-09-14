import 'dart:convert';

import 'package:posts_app/model/posts.dart';
import 'package:http/http.dart' as http;

class PostRepository {
  static Future<List<Post>> fetchPosts() async {
    final response =
        await http.get('https://jsonplaceholder.typicode.com/posts');
    print(response.body);
    if (response.statusCode == 200) {
      List list = json.decode(response.body);
      List<Post> posts = list.map((e) => Post.fromJson(e)).toList();
      return posts;
    }
  }
}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:posts_app/posts.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String url = 'https://jsonplaceholder.typicode.com/posts';

  Future<List<Post>> posts;

  @override
  void initState() {
    posts = fetchPosts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Posts'),
        ),
        body: FutureBuilder<List<Post>>(
          future: posts,
          builder: (context, snapShot) {
            if (!snapShot.hasData) {
              return Center(child: CircularProgressIndicator());
            }
            List<Post> posts = snapShot.data;
            return ListView(
              children: posts
                  .map((e) => Card(
                elevation: 8,
                          child: Column(
                        children: [
                          Text(e.title,style: TextStyle(fontSize: 20),),
                          Text(e.body),
                        ],
                      )))
                  .toList(),
            );
          },
        ));
  }

  Future<List<Post>> fetchPosts() async {
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

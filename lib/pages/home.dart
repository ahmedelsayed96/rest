import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_app/bloc/posts_bloc.dart';
import 'package:posts_app/bloc/posts_event.dart';
import 'package:posts_app/bloc/posts_state.dart';
import 'package:posts_app/model/posts.dart';
import 'package:posts_app/repository/posts_repository.dart';

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: Text('Posts'),
          actions: [
            InkWell(onTap: () {
              PostBloc postBloc =BlocProvider.of<PostBloc>(context);
              postBloc.add(PostFetch());

            }, child: Icon(Icons.refresh))],
        ),
        body: buildBody());
  }

  Widget buildBody() {
    return BlocBuilder<PostBloc, PostState>(
      builder: (context, state) {
        if (state is PostLoading) {
          return buildLoading();
        } else if (state is PostSuccess) {
          return buildListView(state.list);
        }

        return Container();
      },
    );
  }

  ListView buildListView(List<Post> posts) {
    return ListView(
      children: posts
          .map((e) => Card(
              elevation: 8,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      e.title,
                      style: TextStyle(fontSize: 20),
                    ),
                    Text(e.body,style: TextStyle(color: Colors.grey),),
                  ],
                ),
              )))
          .toList(),
    );
  }

  Center buildLoading() => Center(child: CircularProgressIndicator());
}

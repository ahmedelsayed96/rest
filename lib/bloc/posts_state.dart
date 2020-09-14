import 'package:equatable/equatable.dart';
import 'package:posts_app/model/posts.dart';

abstract class PostState extends Equatable {
  const PostState();

  @override
  List<Object> get props => [];
}

class PostInitial extends PostState {}

class PostLoading extends PostState {}

class PostSuccess extends PostState {
  List<Post> list;

  PostSuccess({this.list});

  List<Object> get props => [list];
}

class PostFail extends PostState {
  String  error;

  PostFail({this.error});

  List<Object> get props => [error];
}

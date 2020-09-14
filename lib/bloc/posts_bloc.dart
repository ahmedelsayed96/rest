import 'package:bloc/bloc.dart';
import 'package:posts_app/bloc/posts_event.dart';
import 'package:posts_app/bloc/posts_state.dart';
import 'package:posts_app/model/posts.dart';
import 'package:posts_app/repository/posts_repository.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  PostBloc() : super(PostInitial());

  @override
  Stream<PostState> mapEventToState(PostEvent event) async* {
    if (event is PostFetch) {
      yield* fetchPosts(event);
    }

  }

  Stream<PostState> fetchPosts(PostFetch event) async* {
    yield PostLoading();
    List<Post> posts = await PostRepository.fetchPosts();

    if (posts != null) {
      yield PostSuccess(list: posts);
    } else {
      yield PostFail(error: 'Error');
    }
  }
}

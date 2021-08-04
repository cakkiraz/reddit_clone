import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:reddit_clone/blocs/postsBloc/posts_event.dart';
import 'package:reddit_clone/blocs/postsBloc/posts_state.dart';
import 'package:reddit_clone/models/post.dart';
import 'package:reddit_clone/repositories/posts_repository.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  PostsRepository? postsRepository;
  PostsBloc({
    @required this.postsRepository,
  }) : super(PostsInitial());

  @override
  Stream<PostsState> mapEventToState(PostsEvent event) async* {
    if (event is LoadPosts) {
      yield PostsLoading();
      try {
        List<Post> postList = await postsRepository!.getPosts()!;
        yield PostsLoaded(postList: postList);
      } catch (e) {
        yield PostsLoadFailure(
          message: e.toString(),
        );
      }
    }
  }
}

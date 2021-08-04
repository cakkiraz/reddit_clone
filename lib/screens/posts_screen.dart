import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reddit_clone/blocs/postsBloc/posts_bloc.dart';
import 'package:reddit_clone/blocs/postsBloc/posts_event.dart';
import 'package:reddit_clone/blocs/postsBloc/posts_state.dart';
import 'package:reddit_clone/models/post.dart';

import 'loader_screen.dart';

class PostsScreen extends StatelessWidget {
  PostsScreen({Key? key}) : super(key: key);

  PostsBloc? postsBloc;
  @override
  Widget build(BuildContext context) {
    postsBloc = BlocProvider.of<PostsBloc>(context);

    return BlocListener<PostsBloc, PostsState>(
      listener: (context, state) {
        if (state is PostsLoadFailure) {
          debugPrint(
            "There is an error during load operation of posts, error message: " +
                state.message!,
          );
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                "There is an error during load process for posts! Please try later!",
              ),
            ),
          );
        }
      },
      child: BlocBuilder<PostsBloc, PostsState>(
        builder: (context, state) {
          if (state is PostsLoading) {
            return LoaderScreen();
          } else if (state is PostsLoaded) {
            return Scaffold(
              appBar: AppBar(
                title: Text(
                  "Reddit Clone Demo",
                ),
              ),
              body: Column(
                children: [
                  headerForum(context),
                  Divider(),
                  Expanded(
                    child: bodyForum(state),
                  ),
                  // bodyForum(state),
                ],
              ),
            );
          }
          return Container();
        },
      ),
    );
  }

  Widget headerForum(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundImage: AssetImage(
              'assets/images/flutter_dev.png',
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 10),
            child: Text(
              "FlutterDev",
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
          Expanded(child: Container()),
          IconButton(
            color: Theme.of(context).primaryColor,
            icon: Icon(
              Icons.refresh,
            ),
            onPressed: () {
              postsBloc!.add(LoadPosts());
            },
          )
        ],
      ),
    );
  }

  Widget bodyForum(PostsLoaded postsLoaded) {
    return ListView.builder(
      itemCount: postsLoaded.postList!.length,
      itemBuilder: (context, index) {
        return postWidget(
          context: context,
          post: postsLoaded.postList![index],
        );
      },
    );
  }

  Widget postWidget({
    BuildContext? context,
    Post? post,
  }) {
    return InkWell(
      onTap: () {},
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          postVoteWidget(
            context: context,
            score: post!.score!,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              postTitleWidget(
                context: context,
                title: post.title,
              ),
              if (post.thumbnail == "self")
                postDescriptionWidget(
                  context: context,
                  description: post.description,
                ),
              if (post.thumbnail != "self")
                postThumbnailWidget(
                  context: context,
                  thumbnail: post.thumbnail,
                )
            ],
          )
        ],
      ),
    );
  }

  Widget postVoteWidget({
    BuildContext? context,
    int? score,
  }) {
    return Container(
      // color: Colors.grey[100],
      child: Column(
        children: [
          IconButton(
            icon: Icon(Icons.arrow_upward),
            onPressed: () {
              ScaffoldMessenger.of(context!).showSnackBar(
                SnackBar(
                  content: Text("This feature is not active"),
                ),
              );
            },
          ),
          Text(score.toString()),
          IconButton(
            icon: Icon(Icons.arrow_downward),
            onPressed: () {
              ScaffoldMessenger.of(context!).showSnackBar(
                SnackBar(
                  content: Text("This feature is not active"),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget postTitleWidget({
    BuildContext? context,
    String? title,
  }) {
    return Container(
      padding: EdgeInsets.only(
        top: 8,
      ),
      child: Row(
        children: [
          Container(
            width: MediaQuery.of(context!).size.width - 64,
            child: Text(
              title!,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
                letterSpacing: 0.1,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget postDescriptionWidget({
    BuildContext? context,
    String? description,
  }) {
    return Container(
      padding: EdgeInsets.only(
        top: 8,
      ),
      child: Row(
        children: [
          Container(
            width: MediaQuery.of(context!).size.width - 64,
            child: Text(
              description!,
            ),
          ),
        ],
      ),
    );
  }

  Widget postThumbnailWidget({
    BuildContext? context,
    String? thumbnail,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 5,
        horizontal: 10,
      ),
      child: Image.network(
        thumbnail!,
      ),
    );
  }
}

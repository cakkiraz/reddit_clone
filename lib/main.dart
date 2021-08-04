import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reddit_clone/blocs/postsBloc/posts_event.dart';
import 'package:reddit_clone/repositories/posts_repository.dart';
import 'package:reddit_clone/screens/posts_screen.dart';

import 'blocs/postsBloc/posts_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  PostsRepository postsRepository = PostsRepository();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Reddit Clone Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: BlocProvider(
        create: (context) => PostsBloc(
          postsRepository: postsRepository,
        )..add(LoadPosts()),
        child: PostsScreen(),
      ),
    );
  }
}

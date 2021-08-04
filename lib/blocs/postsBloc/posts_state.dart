import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:reddit_clone/models/post.dart';

abstract class PostsState extends Equatable {}

class PostsInitial extends PostsState {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class PostsLoading extends PostsState {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class PostsLoaded extends PostsState {
  List<Post>? postList;
  PostsLoaded({@required this.postList});
  @override
  List<Object?> get props => throw UnimplementedError();
}

class PostsLoadFailure extends PostsState {
  String? message;
  PostsLoadFailure({@required this.message});
  @override
  List<Object?> get props => throw UnimplementedError();
}

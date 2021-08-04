import 'package:equatable/equatable.dart';

abstract class PostsEvent extends Equatable {}

class LoadPosts extends PostsEvent {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

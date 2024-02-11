import 'package:dio/dio.dart';
import 'package:list_app/models/post_model.dart';

class PostRepository {
  static Future<List<PostModel>> getPosts() async {
    final dio = Dio(BaseOptions(
      baseUrl: 'https://jsonplaceholder.typicode.com',
    ));

    final response = await dio.get('/posts');
    final body = response.data;
    print(body);
    return body.map<PostModel>((e) => PostModel.fromJson(e)).toList();
  }

  static Future<PostModel> getPost(int postId) async {
    final dio = Dio(BaseOptions(
      baseUrl: 'https://jsonplaceholder.typicode.com/posts',
    ));

    final response = await dio.get('/$postId');
    final body = response.data;
    print(body);
    return PostModel.fromJson(body);
  }
}

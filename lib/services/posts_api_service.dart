import 'package:desafio_flutter/constants.dart';
import 'package:desafio_flutter/db/database.dart';
import 'package:dio/dio.dart';

class PostsApiService {
  String baseUrl = API_URL + 'posts';

  Future<List<Post>> getPosts() async {
    try {
      Response response = await Dio().get(baseUrl);

      List<Post> lista = [];

      response.data.map((el) {
        lista.add(Post.fromJson(el));
      }).toList();

      return lista;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}

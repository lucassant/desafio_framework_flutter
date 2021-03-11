import 'package:desafio_flutter/constants.dart';
import 'package:desafio_flutter/db/database.dart';

import 'package:dio/dio.dart';

class TodosApiService {
  Future<List<Todo>> getTodos() async {
    String baseUrl = API_URL + 'todos';
    try {
      Response response = await Dio().get(baseUrl);

      List<Todo> lista = [];

      response.data.map((el) {
        lista.add(Todo.fromJson(el));
      }).toList();

      return lista;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}

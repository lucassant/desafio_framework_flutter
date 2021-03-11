import 'package:desafio_flutter/constants.dart';
import 'package:desafio_flutter/db/database.dart';
import 'package:dio/dio.dart';

class AlbumsApiService {
  String baseUrl = API_URL + 'albums';

  Future<List<Album>> getAlbums() async {
    try {
      Response response = await Dio().get(baseUrl);

      List<Album> lista = [];

      response.data.map((el) {
        lista.add(Album.fromJson(el));
      }).toList();

      return lista;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}

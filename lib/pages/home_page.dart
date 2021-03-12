import 'package:desafio_flutter/app_controller.dart';
import 'package:desafio_flutter/db/daos/albums_dao.dart';
import 'package:desafio_flutter/db/daos/posts_dao.dart';
import 'package:desafio_flutter/db/daos/todos_dao.dart';
import 'package:desafio_flutter/db/database.dart';
import 'package:desafio_flutter/main.dart';
import 'package:desafio_flutter/pages/albums_page.dart';
import 'package:desafio_flutter/pages/posts_page.dart';
import 'package:desafio_flutter/pages/todos_page.dart';
import 'package:desafio_flutter/pages/widgets/bottom_bar_widget.dart';
import 'package:desafio_flutter/services/albums_api_service.dart';
import 'package:desafio_flutter/services/posts_api_service.dart';
import 'package:desafio_flutter/services/todos_api_service.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<bool> _funcaoFetch;

  @override
  void initState() {
    super.initState();
    _funcaoFetch = _fetchAllData();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Object>(
        future: _funcaoFetch,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Scaffold(
              body: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(child: CircularProgressIndicator()),
                  SizedBox(
                    height: 16,
                  ),
                  Center(child: Text('Sincronizando dados, aguarde...'))
                ],
              ),
            );
          }
          if (!snapshot.data) {
            return Scaffold(
                body: Center(
              child: Text('Erro ao sincronizar dados'),
            ));
          }
          return Scaffold(
              bottomNavigationBar: BottomBarWidget(),
              body: PageView(
                controller: getIt<AppController>().pageViewController,
                children: [AlbumsPage(), PostsPage(), TodosPage()],
              ));
        });
  }

  Future<bool> _fetchAllData() async {
    final db = getIt<MyDatabase>();

    final albumsDao = AlbumsDao(db);
    final todosDao = TodosDao(db);
    final postsDao = PostsDao(db);

    try {
      await albumsDao.insertAllAlbums(await AlbumsApiService().getAlbums());
      print('_inseriu albuns_');
      await postsDao.insertAllPosts(await PostsApiService().getPosts());
      print('_inseriu posts_');
      await todosDao.insertAllTodos(await TodosApiService().getTodos());
      print('_inseriu todos_');

      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }
}

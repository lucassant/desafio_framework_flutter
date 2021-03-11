import 'package:desafio_flutter/db/daos/albums_dao.dart';
import 'package:desafio_flutter/db/database.dart';
import 'package:desafio_flutter/main.dart';

import 'package:flutter/material.dart';

class AlbumsPage extends StatelessWidget {
  final db = getIt<MyDatabase>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        centerTitle: true,
        title: Text(
          'Albums',
          style: TextStyle(color: Colors.blue),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: StreamBuilder<List<Album>>(
          stream: AlbumsDao(db).allAlbums,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            List<Album> lista = snapshot.data;

            return Scrollbar(
              child: ListView.builder(
                itemCount: lista.length,
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) => Column(
                  children: [
                    ListTile(
                      leading: CircleAvatar(
                        child: Text('${lista[index].id}'),
                      ),
                      title: Text(lista[index].title),
                      subtitle: Text('User id: ${lista[index].userId}'),
                    ),
                    Divider()
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

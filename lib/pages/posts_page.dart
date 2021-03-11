import 'package:desafio_flutter/db/daos/posts_dao.dart';
import 'package:desafio_flutter/db/database.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class PostsPage extends StatelessWidget {
  final db = getIt<MyDatabase>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        centerTitle: true,
        title: Text(
          'Posts',
          style: TextStyle(color: Colors.blue),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: StreamBuilder<List<Post>>(
          stream: PostsDao(db).allPosts,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            List<Post> lista = snapshot.data;

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
                      subtitle: Text('${lista[index].body}'),
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

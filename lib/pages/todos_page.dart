import 'package:desafio_flutter/db/daos/todos_dao.dart';
import 'package:desafio_flutter/db/database.dart';
import 'package:desafio_flutter/main.dart';
import 'package:flutter/material.dart';

class TodosPage extends StatelessWidget {
  final db = getIt<MyDatabase>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        centerTitle: true,
        title: Text(
          'To-Dos',
          style: TextStyle(color: Colors.blue),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: StreamBuilder<List<Todo>>(
          stream: TodosDao(db).allTodos,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            List<Todo> lista = snapshot.data;

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
                        trailing: lista[index].completed
                            ? Icon(
                                Icons.check,
                                color: Colors.green,
                              )
                            : Icon(
                                Icons.error_outline,
                                color: Colors.red,
                              )),
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

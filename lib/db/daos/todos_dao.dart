import 'package:desafio_flutter/db/database.dart';
import 'package:desafio_flutter/db/todos_table.dart';
import 'package:moor/moor.dart';

part 'todos_dao.g.dart';

@UseDao(tables: [Todos])
class TodosDao extends DatabaseAccessor<MyDatabase> with _$TodosDaoMixin {
  TodosDao(MyDatabase db) : super(db);

  Stream<List<Todo>> get allTodos =>
      (select(todos)..orderBy([(t) => OrderingTerm.asc(t.id)])).watch();

  Future insertAllTodos(List<Todo> listTodos) async {
    await batch((batch) => batch.insertAllOnConflictUpdate(todos, listTodos));
  }
}

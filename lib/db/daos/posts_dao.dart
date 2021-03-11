import 'package:desafio_flutter/db/database.dart';
import 'package:desafio_flutter/db/posts_table.dart';
import 'package:moor/moor.dart';

part 'posts_dao.g.dart';

@UseDao(tables: [Posts])
class PostsDao extends DatabaseAccessor<MyDatabase> with _$PostsDaoMixin {
  PostsDao(MyDatabase db) : super(db);

  Stream<List<Post>> get allPosts =>
      (select(posts)..orderBy([(t) => OrderingTerm.asc(t.id)])).watch();

  Future insertAllPosts(List<Post> listPosts) async {
    await batch((batch) => batch.insertAllOnConflictUpdate(posts, listPosts));
  }
}

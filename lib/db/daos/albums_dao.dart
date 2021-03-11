import 'package:desafio_flutter/db/albums_table.dart';
import 'package:desafio_flutter/db/database.dart';
import 'package:moor/moor.dart';

part 'albums_dao.g.dart';

@UseDao(tables: [Albums])
class AlbumsDao extends DatabaseAccessor<MyDatabase> with _$AlbumsDaoMixin {
  AlbumsDao(MyDatabase db) : super(db);

  Stream<List<Album>> get allAlbums =>
      (select(albums)..orderBy([(t) => OrderingTerm.asc(t.id)])).watch();

  Future insertAllAlbums(List<Album> listAlbums) async {
    await batch((batch) => batch.insertAllOnConflictUpdate(albums, listAlbums));
  }
}

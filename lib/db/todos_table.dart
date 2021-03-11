import 'package:moor/moor.dart';

class Todos extends Table {
  IntColumn get id => integer()();
  IntColumn get userId => integer()();
  TextColumn get title => text()();
  BoolColumn get completed => boolean()();

  @override
  Set<Column> get primaryKey => {id};
}

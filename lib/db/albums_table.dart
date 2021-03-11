import 'package:moor/moor.dart';

class Albums extends Table {
  IntColumn get id => integer()();
  TextColumn get title => text()();
  IntColumn get userId => integer()();

  @override
  Set<Column> get primaryKey => {id};
}

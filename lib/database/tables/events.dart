import 'package:moor_flutter/moor_flutter.dart';

class Events extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get price => integer().withDefault(Constant(0))();
  TextColumn get location => text()();
  TextColumn get cityLocation => text()();
  TextColumn get name => text()();

  @override
  Set<Column> get primaryKey => {id};
}
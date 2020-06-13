import 'package:moor_flutter/moor_flutter.dart';

class TrackEvents extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get eventId => integer()();
  IntColumn get index => integer()();

  @override
  Set<Column> get primaryKey => {id};
}
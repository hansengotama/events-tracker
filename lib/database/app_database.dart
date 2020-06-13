import 'package:eventstracker/database/dao/event_dao.dart';
import 'package:eventstracker/database/dao/track_event_dao.dart';
import 'package:eventstracker/database/tables/events.dart';
import 'package:eventstracker/database/tables/track_events.dart';
import 'package:moor_flutter/moor_flutter.dart';

part 'app_database.g.dart';

@UseMoor(
    tables: [Events, TrackEvents],
    daos: [EventDao, TrackEventDao],
)

class AppDatabase extends _$AppDatabase {
  AppDatabase()
      : super(FlutterQueryExecutor.inDatabaseFolder(path: "db.sqlite", logStatements: true));

  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    beforeOpen: (details) async {
      await customStatement('PRAGMA foreign_keys = ON');
    },
    onCreate: (Migrator m) {
      m.createTable(events);
      m.createTable(trackEvents);

      return;
    },
  );
}

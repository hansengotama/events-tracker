import 'package:eventstracker/database/app_database.dart';
import 'package:eventstracker/database/tables/events.dart';
import 'package:moor_flutter/moor_flutter.dart';

part 'event_dao.g.dart';

@UseDao(
  tables: [Events],
)

class EventDao extends DatabaseAccessor<AppDatabase> with _$EventDaoMixin {
  AppDatabase db;

  EventDao(this.db) : super(db);

  Future insertData({
    @required EventsCompanion event,
  }) {
    return into(events).insert(event);
  }

  Future<List<Event>> get() {
    return select(events).get();
  }

  Future<Event> getEventById({@required int eventId}) async {
    return await (select(events)..where((event) => event.id.equals(eventId))).getSingle();
  }
}
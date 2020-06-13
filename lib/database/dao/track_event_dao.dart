import 'package:eventstracker/database/app_database.dart';
import 'package:eventstracker/database/tables/events.dart';
import 'package:eventstracker/database/tables/track_events.dart';
import 'package:eventstracker/database/relations/track_event_with_event.dart';
import 'package:moor_flutter/moor_flutter.dart';

part 'track_event_dao.g.dart';

@UseDao(
  tables: [TrackEvents, Events],
)
class TrackEventDao extends DatabaseAccessor<AppDatabase> with _$TrackEventDaoMixin {
  AppDatabase db;

  TrackEventDao(this.db) : super(db);

  Future insertData({
    @required TrackEventsCompanion trackEvent,
  }) {
    return into(trackEvents).insert(trackEvent);
  }

  Future<List<TrackEventWithEvent>> get() async {
    final rows = await (select(trackEvents)
      ..orderBy(
        [
              (trackEvent) => OrderingTerm(
            expression: trackEvent.index,
            mode: OrderingMode.asc,
          )
        ],
      )).join([
        leftOuterJoin(
          events,
          events.id.equalsExp(trackEvents.eventId),
        ),
      ]).get();

    return rows.map((row) {
      return TrackEventWithEvent(
        event: row.readTable(events),
        trackEvent: row.readTable(trackEvents),
      );
    }).toList();
  }

  Future<TrackEvent> getTrackEventById({@required int id}) async {
    return await (select(trackEvents)..where((trackEvent) => trackEvent.id.equals(id))).getSingle();
  }

  Future<TrackEvent> getTrackEventByEventId({@required int eventId}) async {

    return await (select(trackEvents)..where((trackEvent) => trackEvent.eventId.equals(eventId))).getSingle();
  }

  Future<int> getTrackEventLength() async {
    return (await select(trackEvents).get()).length;
  }

  Future<void> deleteEntry() {
    return delete(trackEvents).go();
  }
}

import 'package:eventstracker/base/BaseViewModel.dart';
import 'package:eventstracker/database/app_database.dart';
import 'package:eventstracker/database/dao/event_dao.dart';
import 'package:eventstracker/database/dao/track_event_dao.dart';
import 'package:flutter/cupertino.dart';
import 'package:moor_flutter/moor_flutter.dart';

class EventDetailViewModel extends BaseViewModel {
  EventDao _eventDao;
  TrackEventDao _trackEventDao;
  bool _isLoadingTrackEvent = false;
  bool get isLoadingTrackEvent => _isLoadingTrackEvent;
  TrackEvent _eventTrack;
  TrackEvent get eventTracked => _eventTrack;
  Event _event;
  Event get event => _event;

  EventDetailViewModel({
    @required EventDao eventDao,
    @required TrackEventDao trackEventDao,
  }) {
    _eventDao = eventDao;
    _trackEventDao = trackEventDao;
  }

  void getEventById({@required int eventId}) async {
    setBusy(true);
    _event = await _eventDao.getEventById(eventId: eventId);
    await getEventTrack();
    setBusy(false);
  }

  Future<void> getEventTrack() async {
    _eventTrack = await _trackEventDao.getTrackEventByEventId(eventId: _event.id);
  }

  Future<int> getTrackEventLength() {
    return _trackEventDao.getTrackEventLength();
  }

  Future<void> trackEvent({@required int id}) async {
    _isLoadingTrackEvent = true;

    int trackEventLength = await getTrackEventLength();

    TrackEventsCompanion trackEvent = TrackEventsCompanion(
      eventId: Value(id),
      index: Value(trackEventLength + 1),
    );

    _trackEventDao.insertData(trackEvent: trackEvent);
    await getEventTrack();

    _isLoadingTrackEvent = false;
    notifyListeners();
  }
}
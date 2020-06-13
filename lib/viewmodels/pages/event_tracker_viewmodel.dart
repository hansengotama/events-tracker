import 'package:eventstracker/base/BaseViewModel.dart';
import 'package:eventstracker/database/app_database.dart';
import 'package:eventstracker/database/dao/track_event_dao.dart';
import 'package:eventstracker/database/relations/track_event_with_event.dart';
import 'package:flutter/cupertino.dart';
import 'dart:developer' as dev;

import 'package:moor_flutter/moor_flutter.dart';

class EventTrackerViewModel extends BaseViewModel {
  TrackEventDao _trackEventDao;
  bool _isEdit = false;
  bool get isEdit => _isEdit;
  List<TrackEventWithEvent> _eventTrackers;
  List<TrackEventWithEvent> get eventTrackers => _eventTrackers;

  EventTrackerViewModel({
    @required TrackEventDao trackEventDao,
  }) {
    _trackEventDao = trackEventDao;
  }

  void getEventTracker() async {
    setBusy(true);
    _eventTrackers = await _trackEventDao.get();
    setBusy(false);
  }

  void setEdit({@required bool status}) async {
    _isEdit = status;

    if(!_isEdit) {
      setBusy(true);
      await _trackEventDao.deleteEntry();

      if(_eventTrackers != null) {
        _eventTrackers.asMap().forEach((index, eventTracker) => {
          _trackEventDao.insertData(
            trackEvent: TrackEventsCompanion(
              eventId: Value(eventTracker.event.id),
              index: Value(index+1),
            ),
          ),
        });
      }

      return getEventTracker();
    }

    notifyListeners();
  }

  bool onHorizontalDrag(DragEndDetails details) {
    if (details.primaryVelocity != 0 && details.primaryVelocity.compareTo(0) != -1) {
      return true;
    }

    return false;
  }
}
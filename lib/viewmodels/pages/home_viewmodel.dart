import 'package:eventstracker/base/BaseViewModel.dart';
import 'package:eventstracker/database/app_database.dart';
import 'package:eventstracker/database/dao/event_dao.dart';
import 'package:eventstracker/dummy_data/events.dart';
import 'package:eventstracker/enum/event_display_type.dart';
import 'package:flutter/cupertino.dart';
import 'package:moor_flutter/moor_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeViewModel extends BaseViewModel {
  SharedPreferences _sharedPreferences;
  EventDao _eventDao;
  String _userName = "";
  String get userName => _userName;
  List<Event> _events;
  List<Event> get events => _events;
  EventDisplayType _eventDisplayType = EventDisplayType.LIST;
  EventDisplayType get eventDisplayType => _eventDisplayType;

  HomeViewModel({
    @required SharedPreferences sharedPreferences,
    @required EventDao eventDao,
  }) {
    _sharedPreferences = sharedPreferences;
    _eventDao = eventDao;
  }

  void getUserName() async {
    _userName = _sharedPreferences.getString("name");
  }

  void toggleEventDisplayType() {
    if (_eventDisplayType == EventDisplayType.LIST)
      _eventDisplayType = EventDisplayType.GRID;
    else
      _eventDisplayType = EventDisplayType.LIST;

    notifyListeners();
  }

  void initEvent() async {
    setBusy(true);

    _events = await getEvent();

    if (_events.isEmpty) {
      final List<EventsCompanion> _eventsCompanion = eventsCompanion;

      await insertAllEventData(
        events: _eventsCompanion,
      );

      _events = await getEvent();
    }

    setBusy(false);
  }

  Future<void> insertAllEventData({@required List<EventsCompanion> events}) async {
    events.forEach((event) async {
      await _eventDao.insertData(event: event);
    });
  }

  Future<List<Event>> getEvent() {
    return _eventDao.get();
  }

  bool onHorizontalDrag(DragEndDetails details) {
    if (details.primaryVelocity != 0 && details.primaryVelocity.compareTo(0) == -1) {
      return true;
    }

    return false;
  }
}

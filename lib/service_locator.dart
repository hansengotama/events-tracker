import 'package:eventstracker/database/app_database.dart';
import 'package:eventstracker/database/dao/event_dao.dart';
import 'package:eventstracker/database/dao/track_event_dao.dart';
import 'package:eventstracker/ui/pages/event_tracker.dart';
import 'package:eventstracker/viewmodels/pages/event_detail_viewmodel.dart';
import 'package:eventstracker/viewmodels/pages/event_tracker_viewmodel.dart';
import 'package:eventstracker/viewmodels/pages/home_viewmodel.dart';
import 'package:eventstracker/viewmodels/pages/welcome_viewmodel.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

GetIt locator = GetIt.instance;

Future<void> setupLocators() async {
  locator.registerSingleton<AppDatabase>(AppDatabase());

  locator.registerFactory<EventDao>(() => EventDao(locator<AppDatabase>()));

  locator.registerFactory<TrackEventDao>(() => TrackEventDao(locator<AppDatabase>()));

  locator.registerSingleton<SharedPreferences>(
    await SharedPreferences.getInstance(),
  );

  locator.registerFactory<WelcomeViewModel>(
    () => WelcomeViewModel(
      sharedPreferences: locator<SharedPreferences>(),
    ),
  );

  locator.registerFactory<HomeViewModel>(
    () => HomeViewModel(
      sharedPreferences: locator<SharedPreferences>(),
      eventDao: locator<EventDao>(),
    ),
  );

  locator.registerFactory<EventDetailViewModel>(
    () => EventDetailViewModel(
      eventDao: locator<EventDao>(),
      trackEventDao: locator<TrackEventDao>(),
    ),
  );

  locator.registerFactory<EventTrackerViewModel>(
    () => EventTrackerViewModel(
      trackEventDao: locator<TrackEventDao>(),
    ),
  );
}


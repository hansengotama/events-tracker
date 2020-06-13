import 'package:eventstracker/enum/route_paths.dart';
import 'package:eventstracker/ui/pages/event_detail.dart';
import 'package:eventstracker/ui/pages/event_tracker.dart';
import 'package:eventstracker/ui/pages/home.dart';
import 'package:eventstracker/ui/pages/welcome.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutePaths.WELCOME:
        return MaterialPageRoute(
          settings: RouteSettings(
            name: RoutePaths.WELCOME,
          ),
          builder: (_) => WelcomePage(),
        );
      case RoutePaths.HOME:
        return MaterialPageRoute(
            settings: RouteSettings(
              name: RoutePaths.HOME,
            ),
            builder: (_) => HomePage(),
        );
      case RoutePaths.EVENT_DETAIL:
        int eventId = settings.arguments;

        return MaterialPageRoute(
          settings: RouteSettings(
            name: RoutePaths.EVENT_DETAIL,
          ),
          builder: (_) => EventDetailPage(
            eventId: eventId,
          ),
        );
      case RoutePaths.EVENT_TRACKER:
        return MaterialPageRoute(
          builder: (_) => EventTrackerPage(),
        );
      default:
        break;
    }
  }
}
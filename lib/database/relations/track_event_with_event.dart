import 'package:eventstracker/database/app_database.dart';
import 'package:flutter/cupertino.dart';

class TrackEventWithEvent {
  final TrackEvent trackEvent;
  final Event event;

  TrackEventWithEvent({@required this.event, @required this.trackEvent});
}

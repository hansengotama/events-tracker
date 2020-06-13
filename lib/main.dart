import 'package:eventstracker/enum/route_paths.dart';
import 'package:eventstracker/router.dart';
import 'package:eventstracker/service_locator.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await setupLocators();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Events Tracker',
      initialRoute: RoutePaths.WELCOME,
      onGenerateRoute: Router.generateRoute,
    );
  }
}
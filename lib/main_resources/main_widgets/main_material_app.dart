import 'package:flutter/material.dart';

import '../main_constants.dart';
import '../../screens/UnitDetails/unit_details_screen.dart';
import '../../screens/auth_wrapper.dart';
import '../../screens/call_details/call_details_screen.dart';
import '../../screens/unit_status/unit_status_screen.dart';
import '../../screens/unknown_screen.dart';

/* The MainMaterialApp creates the applications MaterialApp.
   The class also defined the onGenerateRoute parameter to set up the
   app navigation.
 */

class MainMaterialApp extends StatelessWidget {
  const MainMaterialApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.grey,
        canvasColor: Colors.black,
        textTheme: getDefaultTextTheme(context),
        inputDecorationTheme: defaultInputDecorationTheme,
      ),
      onGenerateRoute: (settings) {
        // Default uri returns AuthWrapper, which is either a sign in
        // screen or the home screen depending on whether the user is
        // signed in or not:
        if (settings.name == "/") {
          return MaterialPageRoute(builder: (context) => AuthWrapper());
        }
        // For anything other than default uri, parse the uri:
        var uri = Uri.parse(settings.name!);

        // Go to UnitStatus Screen:
        if (uri.pathSegments.length == 2 &&
            uri.pathSegments.first == "UnitStatus") {
          var uid = uri.pathSegments[1];
          return createPageRouteWithSlideAnimation(
              context: context,
              begin: const Offset(-1.0, 0.0),
              screen: UnitStatusScreen(uid: uid));
        }
        // Go to Unit Details Screen:
        else if (uri.pathSegments.length == 2 &&
            uri.pathSegments.first == 'Units') {
          var documentId = uri.pathSegments[1];
          return createPageRouteWithSlideAnimation(
              context: context,
              screen: UnitDetailsScreen(uid: documentId),
              begin: const Offset(0.0, 1.0));
        }
        // Go to Call Details Screen:
        else if (uri.pathSegments.length == 2 &&
            uri.pathSegments.first == "CallsForService") {
          var documentId = uri.pathSegments[1];
          return createPageRouteWithSlideAnimation(
              context: context,
              screen: CallDetailsScreen(uid: documentId),
              begin: const Offset(0.0, 1.0));
        }
        // Else the uri didn't match any screen, go to Unknown Screen:
        else {
          return MaterialPageRoute(builder: (context) => const UnknownScreen());
        }
      },
    );
  }
}

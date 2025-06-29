import 'package:flutter/material.dart';
import 'package:mobile_cad/shared/app_constants.dart';

import '../screens/unit_status/unit_status_screen.dart';

// Default Themes for Material App:
InputDecorationTheme defaultInputDecorationTheme = InputDecorationTheme(
  filled: true,
  fillColor: Colors.grey[200],
  hintStyle: TextStyle(
    color: Colors.grey[600],
  ),
  errorStyle: TextStyle(color: Colors.red[300]),
  border: const OutlineInputBorder(),
);

getDefaultTextTheme(BuildContext context) {
  return Theme.of(context).textTheme.apply(
        fontSizeFactor: 1.5,
      );
}

// Since multiple screens use animation when going to them, this method
// standardizes the process of creating a PageRouteBuilder with Slide animation:
PageRouteBuilder createPageRouteWithSlideAnimation({
  required BuildContext context,
  Curve curve = Curves.ease,
  Offset begin = const Offset(0.0, 1.0),
  Offset end = Offset.zero,
  required Widget screen,
}) {
  final curveTween = CurveTween(curve: curve);

  return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => screen,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final tween = Tween(begin: begin, end: end).chain(curveTween);
        final offsetAnimation = animation.drive(tween);
        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      });
}

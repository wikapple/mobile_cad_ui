import 'package:flutter/material.dart';

import '../app_constants.dart';

/* Surface creates a background surface for app content, The surface
   is intended to be slightly brighter than the background, representing
   elevation.
 */

class Surface extends StatelessWidget {
  const Surface(
      {required this.child,
      this.padding = const EdgeInsets.all(6),
      this.margin = const EdgeInsets.all(3),
      Key? key})
      : super(key: key);

  final Widget child;
  final EdgeInsets padding;
  final EdgeInsets margin;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: padding,
        margin: EdgeInsets.all(3),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: Colors.grey[800]!),
          color: surfaceColor,
        ),
        child: child);
  }
}

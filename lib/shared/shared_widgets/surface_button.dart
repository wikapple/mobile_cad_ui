import 'package:flutter/material.dart';
import 'package:mobile_cad/shared/app_constants.dart';

/* Surface button is very similar to Surface widget, except it has a Function
   parameter for an onTap event, and has rounded edges.
 */

class SurfaceButton extends StatelessWidget {
  const SurfaceButton(
      {required this.child,
      this.margin = const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
      this.padding = const EdgeInsets.all(6),
      this.onTap,
      Key? key})
      : super(key: key);
  final Widget child;
  final EdgeInsets margin;
  final EdgeInsets padding;
  final Function? onTap;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      margin: margin,
      decoration: BoxDecoration(
        color: surfaceColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey[800]!),
      ),
      child: InkWell(
          onTap: () {
            if (onTap != null) {
              onTap!();
            }
          },
          child: child),
    );
  }
}

import 'package:flutter/material.dart';

class UnknownScreen extends StatelessWidget {
  const UnknownScreen({Key? key}) : super(key: key);

  /* This screen shows up if the application route isn't recognized. This
     screen should never be seen by user.
   */

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Flexible(
        child: Text(
          "Attempted to route to an invalid screen",
          style: TextStyle(
            color: Colors.red,
            fontSize: 22,
          ),
        ),
      ),
    );
  }
}

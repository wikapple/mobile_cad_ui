import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

/* This class displays an error message in the event the connection attempt
   to firebase fails.
 */

class LoadErrorWidget extends StatelessWidget {
  const LoadErrorWidget({
    required this.snapshot,
    super.key,
  });

  final AsyncSnapshot<FirebaseApp> snapshot;

  @override
  Widget build(BuildContext context) {
    return Center(
      // Wrap text if needed:
      child: Flexible(
        // Output a message including the snapshot's error:
        child: Text(
          "Failed to connect to database: ${snapshot.error.toString()}",
          textDirection: TextDirection.ltr,
          style: TextStyle(
            fontSize: 20,
            color: Colors.red[300],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../../shared/shared_widgets/loading.dart';

/* Loading screen while attempting to connect to Firebase.
   This class must must define Directionality for Widgets because it
   does not a child of Material App.
 */

class LoadingDbWidget extends StatelessWidget {
  const LoadingDbWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Center(
          child: Text(
            "Connecting to database...",
            textDirection: TextDirection.ltr,
            style: TextStyle(fontSize: 20, color: Colors.lightBlue),
          ),
        ),
        Directionality(textDirection: TextDirection.ltr, child: Loading()),
      ],
    );
  }
}

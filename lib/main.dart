import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mobile_cad/models/app_user.dart';
import 'package:mobile_cad/services/auth.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'main_resources/main_widgets/LoadingDbWidget.dart';
import 'main_resources/main_widgets/load_error_widget.dart';
import 'main_resources/main_widgets/main_material_app.dart';

void main() {
  runApp(const MyApp());
}

/* MyApp attempts to initialize a Firebase connection.
   If successful, it  begins a StreamProvider to keep track of this AppUser.
   It then creates a MaterialApp to launch the application.
 */
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // Attempt to initialize app with Firebase connection:
    return FutureBuilder(
        future: Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        ),
        builder: (context, snapshot) {
          // If error received, show the Error screen:
          if (snapshot.hasError) {
            return LoadErrorWidget(snapshot: snapshot);
          }
          // If the connection is successful,
          if (snapshot.connectionState == ConnectionState.done) {
            // Initialize StreamProvider of AppUser, which keeps track of this
            // user's unique identifier (uid). The uid will be null if not
            // signed in.
            return StreamProvider<AppUser?>.value(
              value: AuthService().user,
              initialData: null,
              // Launch Material App:
              child: const MainMaterialApp(),
            );
          }
          // Else (if connection isn't successful yet, but there is no error),
          // return a Loading screen:
          return const LoadingDbWidget();
        });
  }
}

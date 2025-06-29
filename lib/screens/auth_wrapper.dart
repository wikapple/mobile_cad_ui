import 'package:flutter/material.dart';
import 'package:mobile_cad/screens/home/home.dart';
import 'package:provider/provider.dart';

import '../models/app_user.dart';
import 'authenticate/sign_in_screen.dart';

/* The AuthWrapper used Provider.of to check if the current user is null,
   which would indicate the user is not logged in. If the user is not
   logged in, it displayed the Login screen, if the user is
   logged in, it displays the Home screen.

 */

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AppUser?>(context);
    // Return either home or authenticate widget
    return (user == null) ? const SignIn() : Home(uid: user!.uid);
  }
}

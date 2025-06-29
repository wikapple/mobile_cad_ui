import 'package:flutter/material.dart';
import 'package:mobile_cad/services/auth.dart';

import '../../shared/app_constants.dart';
import '../../shared/shared_widgets/loading.dart';
import '../../shared/shared_widgets/surface_button.dart';

/*  Sign in screen takes a user's email address and password and attempts to
    sign the user into Firebase Authentication. If login attempt succeeds,
    The screen switches to the Home screen.
 */

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  // Service for connecting to firebase authentication:
  final AuthService _auth = AuthService();

  // _formKey keeps track of form input in order to validate user input:
  final _formKey = GlobalKey<FormState>();

  // _loading displays a loading circle if true:
  bool _loading = false;

  // text field states
  String _email = '';
  String _password = '';
  String _error = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        leading: Icon(
          Icons.lock_rounded,
          color: Colors.grey[400],
          size: 30,
        ),
        backgroundColor: Colors.blueGrey.withOpacity(.1),
        title: Text("Cad Sign In",
            style: defaultTextStyle(
                color: defaultTextColor, fontFamily: "Oswald")),
      ),
      body: _loading
          ? const Loading(size: 100)
          : Container(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 50),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    const SizedBox(height: 30),
                    // Email form field:
                    TextFormField(
                      style: const TextStyle(color: Colors.black),
                      validator: (val) => (val != null && val.isEmpty)
                          ? 'Enter an email address'
                          : null,
                      decoration: const InputDecoration(
                        hintText: "Email Address",
                      ),
                      onChanged: (val) {
                        setState(() => _email = val);
                      },
                    ),
                    const SizedBox(height: 30),
                    // Password form field:
                    TextFormField(
                        style: const TextStyle(color: Colors.black),
                        validator: (val) => (val != null && val.isEmpty)
                            ? 'Enter a password'
                            : null,
                        obscureText: true,
                        decoration: const InputDecoration(
                          hintText: "Password",
                        ),
                        onChanged: (val) {
                          setState(() => _password = val);
                        }),
                    const SizedBox(height: 30),
                    // Sign in / enter button:
                    SurfaceButton(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 30),
                      onTap: () async {
                        // Check if user input is valid:
                        if (_formKey.currentState!.validate()) {
                          // Set state to loading (show loading circle) while
                          // processing sign in attempt:
                          setState(() => _loading = true);
                          // Get sign in result from Firebase
                          dynamic result = await _auth
                              .signInWithEmailAndPassword(_email, _password);
                          // If result is null, then it failed, otherwise,
                          // The screen will automatically go to Home screen since
                          // this SignIn widget is inside of the AuthWrapper widget.
                          if (result == null) {
                            setState(() {
                              _loading = false;
                              _error = 'Sign in attempt failed';
                            });
                          }
                        }
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.login,
                            color: primaryColor,
                            size: 30,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text("Sign in",
                              style: defaultTextStyle(
                                  color: primaryColor,
                                  fontFamily: "Oswald",
                                  fontSize: 30)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}

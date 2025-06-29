import 'package:firebase_auth/firebase_auth.dart';
import 'package:mobile_cad/models/app_user.dart';

/* AuthService connects to Firebase Authentication via an instance of the
   FirebaseAuth class. The class provides a Stream for getting the current user
   logged into Firebase. The class also has methods to sign in and sign out
   of Firebase.
 */

class AuthService {
  // Connects to Firebase Authentication:
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Create user obj based on FirebaseUser (null if no user logged in):
  AppUser? _appUserFromFirebaseUser(User? user) {
    return user != null ? AppUser(uid: user.uid) : null;
  }

  // current logged in user stream:
  Stream<AppUser?> get user {
    return _auth.authStateChanges().map(_appUserFromFirebaseUser);
  }

  // Method to sign into Firebase:
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      return _appUserFromFirebaseUser(user);
    } catch (e) {
      return null;
    }
  }

  // sign out of Firebase:
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      return null;
    }
  }
}

/* AppUser keeps track of the user's unique identifier (uid) from Firebase
   authentication. This is retrieved from an instance of the Firebase User
   class.
 */

class AppUser {
  final String uid;

  AppUser({required this.uid});
}

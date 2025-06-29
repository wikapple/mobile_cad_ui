import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/call_for_service.dart';
import '../../models/unit.dart';
import '../../services/auth.dart';
import '../../services/call_service.dart';
import '../../services/unit_details_service.dart';
import '../../shared/app_constants.dart';
import '../../shared/shared_widgets/surface_button.dart';
import 'home_widgets/CallList/call_list.dart';
import 'home_widgets/Dashboard/dashboard.dart';

/* The Home widget is the default screen for this application. It
   shows information for the user as well as a list of current calls for
   service.
 */
class Home extends StatelessWidget {
  Home({required this.uid, Key? key}) : super(key: key);

  // This user's unique identifier:
  final String uid;

  // Service connects to Firebase authentication:
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backgroundColor,
        //Colors.blueGrey!.withOpacity(.1),
        appBar: AppBar(
          leading: Icon(Icons.cell_tower, size: 30, color: Colors.grey[400]),
          title: Text(
            "Calls For Service",
            style: TextStyle(color: Colors.grey[300], fontFamily: "Oswald"),
          ),
          backgroundColor: Colors.blueGrey.withOpacity(.1),
          actions: <Widget>[
            TextButton.icon(
              icon: const Icon(
                Icons.person,
                color: Colors.lightBlue,
              ),
              label: const Text('logout',
                  style: TextStyle(color: Colors.lightBlue)),
              onPressed: () async {
                await _auth.signOut();
              },
            )
          ],
        ),
        body: Container(
          margin: const EdgeInsets.all(10),
          child: Column(children: [
            Expanded(
              child: ListView(children: [
                // Show user dashboard:
                StreamProvider<Unit>.value(
                  value: UnitDetailsService(uid: uid).unit,
                  initialData: Unit(),
                  child: const Dashboard(),
                ),
                const SizedBox(
                  height: 15,
                ),
                // Show call for service list:
                StreamProvider<List<CallForService>>.value(
                  value: CallService().callList,
                  initialData: const <CallForService>[],
                  child: CallList(uid),
                ),
              ]),
            ),
            // Screen footer contains a button to the unit status screen:
            Row(
              children: [
                SurfaceButton(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  onTap: () {
                    Navigator.pushNamed(context, "UnitStatus/$uid");
                  },
                  child: Center(
                    child: Row(
                      children: [
                        const SizedBox(
                          width: 5,
                        ),
                        const Icon(Icons.arrow_back_ios,
                            color: primaryColor, size: 25),
                        const Icon(Icons.arrow_back_ios,
                            color: primaryColor, size: 25),
                        Text(
                          "Go to status screen",
                          style: defaultTextStyle(
                              color: primaryColor, fontFamily: "Oswald"),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        const Icon(Icons.people, color: primaryColor, size: 25),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ]),
        ));
  }
}

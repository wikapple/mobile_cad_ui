import 'package:flutter/material.dart';
import 'package:mobile_cad/screens/unit_status/unit_status_widgets/unit_list.dart';
import 'package:provider/provider.dart';

import '../../models/unit.dart';
import '../../services/auth.dart';
import '../../services/unit_service.dart';
import '../../shared/app_constants.dart';
import '../../shared/shared_widgets/surface_button.dart';

/* UnitStatusScreen displays a List of all the units. Each unit can be
   clicked in order to display details screen.
 */

class UnitStatusScreen extends StatelessWidget {
  UnitStatusScreen({required this.uid, Key? key}) : super(key: key);

  // This user's unique identifier:
  final String uid;

  // Service connects to Firebase authentication:
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          leading: Icon(
            Icons.people,
            color: Colors.grey[400],
            size: 30,
          ),
          title: Text(
            "Unit Status",
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
                Navigator.pop(context);
                await _auth.signOut();
              },
            )
          ],
        ),
        body: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Center(
                    // Begin stream provider to track list of units:
                    child: StreamProvider<List<Unit>>.value(
                  value: UnitService().unitList,
                  initialData: const <Unit>[],
                  child: const UnitList(),
                )),
              ),
            ),
            // Footer contains button to return to Home screen:
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SurfaceButton(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  onTap: () => Navigator.pop(context),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          width: 5,
                        ),
                        const Icon(Icons.cell_tower,
                            color: primaryColor, size: 25),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          "Go to call screen",
                          style: defaultTextStyle(
                              color: primaryColor, fontFamily: "Oswald"),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        const Icon(Icons.arrow_forward_ios,
                            color: primaryColor, size: 25),
                        const Icon(Icons.arrow_forward_ios,
                            color: primaryColor, size: 25),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ));
  }
}

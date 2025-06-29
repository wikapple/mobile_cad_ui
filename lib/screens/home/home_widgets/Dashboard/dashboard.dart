import 'package:flutter/material.dart';
import 'package:mobile_cad/models/call_summary.dart';
import 'package:mobile_cad/services/call_summary_service.dart';
import 'package:provider/provider.dart';
import '../../../../models/unit.dart';
import '../../../../shared/shared_widgets/loading.dart';
import '../../../../shared/shared_widgets/surface.dart';
import 'call_summary_tile.dart';

/* The Dashboard widget displays information specific to the user on the
   top of the Home screen.
 */

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard>
    with AutomaticKeepAliveClientMixin {
  // override for the AutomaticKeepAliveClientMixin forces widget to stay alive
  // even when it is scrolled out of screen view. Doing this prevents the
  // widget from having to be rebuilt when returning into view, which
  // causes the screen position to jump.
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    // Use provider to get the Unit information (uid):
    final unit = Provider.of<Unit>(context);
    return Surface(
      child: unit.id == null
          ? const Loading(size: 50)
          : Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "${unit.unitNumber} Dashboard",
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 24,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Current Status: ",
                      style: TextStyle(
                        color: Colors.grey[300],
                        fontSize: 26,
                      ),
                    ),
                    Text(
                      "${unit.status}",
                      style: TextStyle(
                          color: unit.status == 'Unavailable' ||
                                  unit.status == 'Busy'
                              ? Colors.grey[400]
                              : unit.status == 'Available'
                                  ? Colors.teal
                                  : unit.status == "Assigned"
                                      ? Colors.purple[300]
                                      : unit.status == "En Route"
                                          ? Colors.yellow[800]
                                          : Colors.orange[800],
                          fontSize: 28,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                // Display the Call summary information for the user (if on
                // a call):
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                  child: StreamProvider<CallSummary>.value(
                    value: CallSummaryService(uid: unit.id!).callSummary,
                    initialData: CallSummary(),
                    child: const CallSummaryTile(),
                  ),
                ),
              ],
            ),
    );
  }
}

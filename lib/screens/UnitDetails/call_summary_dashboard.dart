import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mobile_cad/models/call_summary.dart';
import 'package:provider/provider.dart';
import '../../shared/app_constants.dart';
import '../../shared/shared_widgets/surface.dart';

/* The CallSummaryDashboard displays call information for the call assigned to
   the given unit. The widget listens for changes from the StreamProvider
   in the UnitDetailsScreen.
 */

class CallSummaryDashboard extends StatefulWidget {
  const CallSummaryDashboard({Key? key}) : super(key: key);

  @override
  State<CallSummaryDashboard> createState() => _CallSummaryDashboardState();
}

class _CallSummaryDashboardState extends State<CallSummaryDashboard> {
  // Widget timer sets the state again once every minute (in addition
  // to setState being called due to provider:
  @override
  void initState() {
    super.initState();
    // Initialize timer to update app state every second:
    Timer.periodic(const Duration(minutes: 1), (Timer t) {
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Track changes to the CallSummary from StreamProvider created
    // in UnitDetailsScreen widget:
    final callSummary = Provider.of<CallSummary>(context);

    // Entire Widget works like a button, which will navigate to the
    // Call's details screen when pressed:
    return InkWell(
      onTap: () {
        if (callSummary.id != null) {
          Navigator.pop(context);
          Navigator.pushNamed(context, 'CallsForService/${callSummary.id}');
        }
      },
      child: Surface(
        child: Column(
          children: [
            // Call Summary Header:
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.phone,
                  color: Colors.grey[400],
                  size: 30,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  "Current Assigned Call:",
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 26,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            // If the callSummary.id is null, then no CallSummary exists,
            // indicating the unit is not assigned to a call:
            Container(
              child: callSummary.id == null
                  ? Center(
                      // If not assigned a call, show "None":
                      child: Text(
                        "None",
                        style: TextStyle(
                          color: Colors.grey[400],
                          fontSize: 24,
                        ),
                      ),
                    )
                  // Else if assigned to a call, display call summary information:
                  : Column(
                      children: [
                        Text(
                          "Call No: ${callSummary.callNumber}",
                          style: TextStyle(
                            color: Colors.grey[300],
                            fontSize: 24,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        // Show call type:
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Call Type: ",
                              style: TextStyle(
                                color: Colors.grey[300],
                                fontSize: 24,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              "${callSummary.callType}",
                              style: TextStyle(
                                  color: Colors.orange[700], fontSize: 26),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        // Display address to call:
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.house,
                              color: Colors.grey[400],
                              size: 24,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Flexible(
                              child: Text(
                                "${callSummary.address}",
                                style:
                                    defaultTextStyle(color: Colors.grey[300]!),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        // Display the time unit has been on call:
                        Text(
                          "Total time on call: ${callSummary.timeSinceCreatedToString()}",
                          style: TextStyle(
                            color: Colors.grey[400],
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        // Display UI hint to click for details:
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "(",
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 18,
                                ),
                              ),
                              Text(
                                "Click for details",
                                style: TextStyle(
                                  color: Colors.grey[300],
                                  fontSize: 16,
                                ),
                              ),
                              const Text(
                                ")",
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 18,
                                ),
                              ),
                            ])
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:mobile_cad/models/call_summary.dart';
import 'package:mobile_cad/shared/app_constants.dart';
import 'package:provider/provider.dart';

/* The CallSummaryTile displays Call information on the user's dashboard.
   It can also be clicked to display a full call details screen.
 */

class CallSummaryTile extends StatefulWidget {
  const CallSummaryTile({Key? key}) : super(key: key);

  @override
  State<CallSummaryTile> createState() => _CallSummaryTileState();
}

class _CallSummaryTileState extends State<CallSummaryTile>
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
    super.build(context);
    final CallSummary callSummary = Provider.of<CallSummary>(context);

    return InkWell(
      // On tap, go the call's details screen:
      onTap: () {
        Navigator.pushNamed(context, 'CallsForService/${callSummary.id}');
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              'Current call assigned:',
              style: TextStyle(
                color: Colors.grey[400],
                fontSize: 22,
              ),
            ),
            const SizedBox(height: 10),
            Container(
              // If the user is not on a call, show text 'None' instead:
              child: callSummary.id == null
                  ? const Text('None', style: TextStyle(color: Colors.grey))
                  : Column(
                      children: [
                        // Display Call Number and call type:
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("${callSummary.callNumber} - ",
                                style: TextStyle(
                                    fontSize: 24, color: Colors.grey[300])),
                            Text(
                              "${callSummary.callType}",
                              style: TextStyle(
                                fontSize: 24,
                                color: altColor,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        // Display Address:
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.house,
                              color: Colors.grey[500],
                              size: 30,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Flexible(
                              child: Text(
                                "${callSummary.address}",
                                style: TextStyle(
                                  color: Colors.grey[300],
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              '(',
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
                              ')',
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

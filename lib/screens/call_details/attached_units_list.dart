import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mobile_cad/screens/call_details/unit_summary_tile.dart';
import 'package:provider/provider.dart';

import '../../models/unit_summary.dart';
import '../../shared/shared_widgets/surface.dart';

/* Widget displays a Listview of units assigned to a call and tracks changes
   to stream provider created in the call details screen using provider.of.
 */

class AttachedUnitsList extends StatefulWidget {
  const AttachedUnitsList({Key? key}) : super(key: key);

  @override
  State<AttachedUnitsList> createState() => _AttachedUnitsListState();
}

class _AttachedUnitsListState extends State<AttachedUnitsList>
    with AutomaticKeepAliveClientMixin {
  // Create a timer to keep updating the widget's state in order to
  // show accurate time on call for units:
  @override
  void initState() {
    super.initState();
    // Initialize timer to update app state every second:
    Timer.periodic(const Duration(seconds: 1), (Timer t) {
      if (mounted) {
        setState(() {});
      }
    });
  }

  // override for the AutomaticKeepAliveClientMixin forces widget to stay alive
  // even when it is scrolled out of screen view. Doing this prevents the
  // widget from having to be rebuilt when returning into view, which
  // causes the screen position to jump.
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    // Track changes to the stream provider created in the call details screen:
    final units = Provider.of<List<UnitSummary>>(context);
    return Surface(
        child: Column(
      children: [
        // Widget title:
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.local_police,
              color: Colors.lightBlue,
              size: 24,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              "Units Assigned:",
              style: TextStyle(
                color: Colors.grey[300],
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        // Column headers:
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: const [
            Text(
              "Unit",
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
            Text(
              "Status",
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
            Text(
              "time on call",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey,
              ),
            )
          ],
        ),
        // Show list of unit tiles:
        ListView.builder(
          shrinkWrap: true,
          physics: const ClampingScrollPhysics(),
          itemCount: units.length,
          itemBuilder: (context, index) {
            return UnitSummaryTile(
                unitSummary: units[index], striped: index % 2 == 0);
          },
        ),
        Text(units.isEmpty ? "None" : "",
            style: const TextStyle(
              color: Colors.grey,
            ))
      ],
    ));
  }
}

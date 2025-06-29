import 'package:flutter/material.dart';
import 'package:mobile_cad/screens/unit_status/unit_status_widgets/status_ring_chart.dart';
import 'package:mobile_cad/screens/unit_status/unit_status_widgets/unit_status_data_table.dart';
import 'package:mobile_cad/shared/shared_widgets/surface.dart';

import '../../../models/unit.dart';

/* UnitStatusDashboard displays a doughnut graph and a table with a count
   of units grouped by their status.
 */

class UnitStatusDashboard extends StatelessWidget {
  UnitStatusDashboard({required List<Unit> activeUnits, Key? key})
      : super(key: key) {
    setActiveUnitCounts(activeUnits);
  }

  // _statusCountMap shows the count for each unit status other than
  // "Unavailable":
  late final Map<String, int> _statusCountMap;

  // function for initializing the _statusCountMap field. The function
  // iterates one time through the unit list and counts the number of units
  // per status:
  setActiveUnitCounts(activeUnits) {
    // initialize each possible status count to 0:
    int availableCount = 0;
    int assignedCount = 0;
    int enRouteCount = 0;
    int onSceneCount = 0;

    // for each unit's status, increment the corresponding status count:
    for (var unit in activeUnits) {
      switch (unit.status) {
        case "Available":
          availableCount++;
          break;
        case "Assigned":
          assignedCount++;
          break;
        case "En Route":
          enRouteCount++;
          break;
        case "On Scene":
          onSceneCount++;
          break;
        default:
          break;
      }
    }
    // Assign values to the _statusCountMap:
    _statusCountMap = {
      "Available": availableCount,
      "Assigned": assignedCount,
      "EnRoute": enRouteCount,
      "OnScene": onSceneCount
    };
  }

  @override
  Widget build(BuildContext context) {
    return Surface(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Pie Chart
          ConstrainedBox(
            constraints: const BoxConstraints(
              maxHeight: 120,
            ),
            // Show a ring chart representing the status count. Note that
            // the Map's values must be converted to double for the
            // pie_chart dart package:
            child: StatusRingChart(
                statusCountMap: _statusCountMap
                    .map((key, value) => MapEntry(key, value.toDouble()))),
          ),
          // Show to unit status table next to the graph:
          UnitStatusDataTable(
            statusMap: _statusCountMap,
          ),
        ],
      ),
    );
  }
}

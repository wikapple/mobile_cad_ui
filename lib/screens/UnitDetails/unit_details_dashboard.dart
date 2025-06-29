import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mobile_cad/models/unit.dart';
import 'package:mobile_cad/shared/app_constants.dart';
import 'package:provider/provider.dart';

import '../../shared/shared_widgets/loading.dart';

class UnitDetailsDashboard extends StatefulWidget {
  const UnitDetailsDashboard({Key? key}) : super(key: key);

  @override
  State<UnitDetailsDashboard> createState() => _UnitDetailsDashboardState();
}

class _UnitDetailsDashboardState extends State<UnitDetailsDashboard> {
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

  @override
  Widget build(BuildContext context) {
    final unit = Provider.of<Unit>(context);

    return Container(
      margin: const EdgeInsets.all(6),
      child: unit.id == null
          ? const Loading(size: 50)
          : Column(
              children: [
                // Display header with Unit number:
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.local_police,
                        color: Colors.lightBlue, size: 30),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      unit.unitNumber.toString(),
                      style: TextStyle(
                        color: Colors.grey[300],
                        fontSize: 30,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                // Display unit's name:
                Text(
                  "Name: ${unit.name}",
                  style: TextStyle(
                    color: Colors.grey[300],
                    fontSize: 24,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                // Display unit's status:
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Status: ",
                      style: TextStyle(
                        color: Colors.grey[300],
                        fontSize: 24,
                      ),
                    ),
                    Text(
                      unit.status.toString(),
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
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                // Display time since unit was last updated/ status changed:
                Text(
                  "Last status change: ",
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 20,
                  ),
                ),
                Text(
                  "${unit.lastUpdatedDurationToString(getSeconds: true)!} ago",
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 18,
                  ),
                ),
              ],
            ),
    );
  }
}

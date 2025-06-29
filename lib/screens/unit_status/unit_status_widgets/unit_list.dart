import 'package:flutter/material.dart';
import 'package:mobile_cad/screens/unit_status/unit_status_widgets/unit_status_dashboard.dart';
import 'package:mobile_cad/screens/unit_status/unit_status_widgets/unit_tile.dart';

import 'package:provider/provider.dart';

import '../../../../models/unit.dart';

class UnitList extends StatefulWidget {
  const UnitList({Key? key}) : super(key: key);

  @override
  State<UnitList> createState() => _UnitListState();
}

// A Listview containing two nested Listviews, one for active units and one
// for inactive units.

class _UnitListState extends State<UnitList> {
  @override
  Widget build(BuildContext context) {
    // Use Provider to keep track of Unit list from Firebase:
    final units = Provider.of<List<Unit>>(context);

    // Filter to get all active units:
    final activeUnits =
        units.where((unit) => unit.status != "Unavailable").toList();
    // Filter to get all inactive units:
    final inactiveUnits =
        units.where((unit) => unit.status == "Unavailable").toList();

    // Top ListView:
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 6),
      child: ListView(
        children: [
          UnitStatusDashboard(activeUnits: activeUnits),
          SizedBox(
            height: 10,
          ),
          const Center(
            child: Text(
              "Active Units: ",
              style: TextStyle(
                color: Colors.teal,
                fontSize: 24,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          // Active units listview:
          ListView.separated(
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            itemCount: activeUnits.length,
            itemBuilder: (context, index) {
              return UnitTile(unit: activeUnits[index]);
            },
            separatorBuilder: (context, index) {
              return Divider(thickness: 1.5, color: Colors.grey[700]);
            },
          ),
          Center(
            child: Text(
              "Inactive Units: ",
              style: TextStyle(
                color: Colors.grey[400],
                fontSize: 24,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          // Inactive Units listview:
          ListView.separated(
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            itemCount: inactiveUnits.length,
            itemBuilder: (context, index) {
              return UnitTile(unit: inactiveUnits[index]);
            },
            separatorBuilder: (context, index) {
              return Divider(thickness: 1.5, color: Colors.grey[700]);
            },
          ),
        ],
      ),
    );
  }
}

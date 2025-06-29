import 'package:flutter/material.dart';
import 'package:mobile_cad/models/unit.dart';
import 'package:mobile_cad/screens/UnitDetails/unit_details_dashboard.dart';
import 'package:mobile_cad/services/unit_details_service.dart';
import 'package:provider/provider.dart';

import '../../models/call_summary.dart';
import '../../services/call_summary_service.dart';
import '../../shared/app_constants.dart';
import 'call_summary_dashboard.dart';

class UnitDetailsScreen extends StatelessWidget {
  const UnitDetailsScreen({required this.uid, Key? key}) : super(key: key);

  final String uid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          backgroundColor: Colors.blueGrey.withOpacity(.1),
          leading: TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Icon(Icons.close_rounded,
                size: 50, color: Colors.lightBlue),
          ),
          title: Text(
            "Unit Details",
            style: TextStyle(color: Colors.grey[300], fontFamily: "Oswald"),
          ),
        ),
        body: ListView(children: [
          // Unit details:
          StreamProvider<Unit>.value(
            value: UnitDetailsService(uid: uid).unit,
            initialData: Unit(),
            child: UnitDetailsDashboard(),
          ),
          SizedBox(
            height: 20,
          ),
          StreamProvider<CallSummary>.value(
            value: CallSummaryService(uid: uid).callSummary,
            initialData: CallSummary(),
            child: CallSummaryDashboard(),
          )
          // Call Details if exists
        ]));
  }
}

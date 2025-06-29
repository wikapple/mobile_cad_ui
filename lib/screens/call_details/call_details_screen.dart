import 'package:flutter/material.dart';
import 'package:mobile_cad/services/call_comment_service.dart';
import 'package:mobile_cad/services/call_details_service.dart';
import 'package:mobile_cad/services/unit_summary_service.dart';
import 'package:provider/provider.dart';
import '../../models/call_comment.dart';
import '../../models/call_for_service.dart';
import '../../models/unit_summary.dart';
import '../../shared/app_constants.dart';
import 'attached_units_list.dart';
import 'call_comment_list.dart';
import 'call_details_dashboard.dart';

/* Screen displays details for a given call
 */

class CallDetailsScreen extends StatelessWidget {
  const CallDetailsScreen({required this.uid, Key? key}) : super(key: key);

  // The call's Document Id in Firebase:
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
          "Call Details",
          style: TextStyle(color: Colors.grey[300], fontFamily: "Oswald"),
        ),
      ),
      body: ListView(
        children: [
          // Show details for this call:
          StreamProvider<CallForService>.value(
            value: CallDetailsService(uid: uid).callForService,
            initialData: CallForService(),
            child: const CallDetailsDashboard(),
          ),
          const SizedBox(
            height: 20,
          ),
          // Show the units assigned to call and their status:
          StreamProvider<List<UnitSummary>>.value(
            value: UnitSummaryService(uid: uid).unitSummaryList,
            initialData: const <UnitSummary>[],
            child: const AttachedUnitsList(),
          ),
          const SizedBox(
            height: 20,
          ),
          // Show the call comments for this call:
          StreamProvider<List<CallComment>>.value(
            value: CallCommentService(uid: uid).callCommentList,
            initialData: const <CallComment>[],
            child: const CallCommentList(),
          )
          // Unit Summary List
          // Call Comment List
        ],
      ),
    );
  }
  /*
  @override
  Widget build(BuildContext context) {
    return StreamProvider<CallForService>.value(
        value: CallDetailsService(uid: id).callForService,
        initialData: CallForService(),
        child: CallDetailsScaffold());
  }
  */
}

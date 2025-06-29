import 'package:flutter/material.dart';
import 'package:mobile_cad/models/call_for_service.dart';
import 'package:provider/provider.dart';
import '../../../../shared/app_constants.dart';
import 'call_tile.dart';

/* CallList widget displays a Listview of all the active calls for service:
 */

class CallList extends StatefulWidget {
  const CallList(this.uid, {Key? key}) : super(key: key);
  final String uid;
  @override
  State<CallList> createState() => _CallListState();
}

class _CallListState extends State<CallList> {
  @override
  Widget build(BuildContext context) {
    final calls = Provider.of<List<CallForService>>(context);
    return Container(
      color: backgroundColor,
      child: Column(
        children: [
          Center(
            child: Text(
              "Active Calls:",
              style: TextStyle(
                color: Colors.grey[300],
                fontSize: 20,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          ListView.separated(
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            itemCount: calls.length,
            itemBuilder: (context, index) {
              return CallTile(call: calls[index]);
            },
            separatorBuilder: (context, index) {
              return Divider(thickness: 1.5, color: Colors.grey[700]);
            },
          ),
          Text(
            calls.isEmpty ? "None" : "",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey[300],
            ),
          ),
        ],
      ),
    );
  }
}

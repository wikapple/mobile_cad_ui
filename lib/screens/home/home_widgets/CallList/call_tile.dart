import 'package:flutter/material.dart';
import 'package:mobile_cad/models/call_for_service.dart';

/* CallTile displays information on a single call from a list of calls.
   Clicking the tile will display the call details screen.
 */

class CallTile extends StatelessWidget {
  const CallTile({required this.call, Key? key}) : super(key: key);

  // This call:
  final CallForService call;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      isThreeLine: true,
      onTap: () {
        Navigator.pushNamed(context, 'CallsForService/${call.id}');
      },
      leading: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            Icons.phone,
            color: Colors.grey[400],
          ),
          Text(
            call.callNumber.toString(),
            style: TextStyle(color: Colors.grey[300]),
          ),
        ],
      ),
      title: ConstrainedBox(
        constraints: const BoxConstraints(maxHeight: 25),
        child: FittedBox(
          child: Text(call.callType.toString(),
              maxLines: 1,
              style: TextStyle(
                  color: Colors.orange[700],
                  fontWeight: FontWeight.w500,
                  fontSize: 16)),
        ),
      ),
      subtitle: Column(
        children: [
          Text(
            call.address.toString(),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            softWrap: false,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[300],
            ),
          ),
          Text(
            call.status.toString(),
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: call.status == "Closed"
                  ? Colors.red
                  : call.status == "Created"
                      ? Colors.teal
                      : call.status == "Assigned"
                          ? Colors.purple[300]
                          : call.status == "En Route"
                              ? Colors.yellow[800]
                              : Colors.orange[700],
            ),
          ),
        ],
      ),
      trailing: Column(
        children: [
          Text(
            "Units Assigned:",
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[300],
            ),
          ),
          Text(
            call.numberOfUnitsAssigned.toString(),
            style: TextStyle(
              fontSize: 20,
              color: Colors.grey[300],
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

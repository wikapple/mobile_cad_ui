import 'package:flutter/material.dart';
import 'package:mobile_cad/shared/app_constants.dart';
import 'package:provider/provider.dart';

import '../../models/call_for_service.dart';
import '../../shared/shared_widgets/loading.dart';

/* Widget displays information about a given call.

 */

class CallDetailsDashboard extends StatefulWidget {
  const CallDetailsDashboard({Key? key}) : super(key: key);

  @override
  State<CallDetailsDashboard> createState() => _CallDetailsDashboardState();
}

class _CallDetailsDashboardState extends State<CallDetailsDashboard>
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
    // Use Provider.of to track changes to this call-for-service from
    // stream created on the CallDetailsScreen:
    final callForService = Provider.of<CallForService>(context);

    return Container(
      margin: const EdgeInsets.all(6),
      child: callForService.id == null
          // Show loading circle if call's attributes are showing null:
          ? const Loading(size: 50)
          : Container(
              margin: const EdgeInsets.symmetric(
                vertical: 6,
                horizontal: 6,
              ),
              child: Column(
                children: [
                  // Show when call was created:
                  Text(
                    "Created: ${callForService.getFormattedTimeCreated()!}",
                    style: const TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 5),
                  // Show call number:
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Call No: ${callForService.callNumber}",
                        style: TextStyle(
                          fontSize: 30,
                          color: Colors.grey[300],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  // Show call type:
                  Text(
                    "${callForService.callType}",
                    style: TextStyle(
                        color: Colors.orange[700],
                        fontSize: 30,
                        fontWeight: FontWeight.w400),
                    maxLines: 1,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  // Show the address to the call:
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
                          callForService.address.toString(),
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.grey[300],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  // Show call status:
                  Text(
                    "${callForService.status}",
                    style: TextStyle(
                        color: callForService.status == "Closed"
                            ? Colors.red
                            : callForService.status == "Created"
                                ? Colors.teal
                                : callForService.status == "Assigned"
                                    ? Colors.purple[300]
                                    : callForService.status == "En Route"
                                        ? Colors.yellow[800]
                                        : Colors.orange[700],
                        fontSize: 28,
                        fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  // Show call description:
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.description,
                        color: Colors.grey[300],
                        size: 20,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Description:",
                        style: TextStyle(
                          color: Colors.grey[300],
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    child: Text(
                      callForService.description.toString(),
                      style: TextStyle(
                        color: Colors.grey[300],
                      ),
                    ),
                  ),

                  const SizedBox(
                    height: 15,
                  ),
                  // Show the caller's information:
                  Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                    Icon(
                      Icons.contact_emergency,
                      color: Colors.grey[300],
                      size: 20,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Caller Information:",
                      style: TextStyle(
                        color: Colors.grey[300],
                      ),
                    ),
                  ]),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    child: Text(
                      "${callForService.caller}",
                      style: TextStyle(
                        color: Colors.grey[300],
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobile_cad/models/call_for_service.dart';

/* Obtains List of all calls for service from Firebase and converts them
   into a List using the CallForService model. Listens for database changes.
*/

class CallService {
  // Collection Reference:
  final CollectionReference callCollection =
      FirebaseFirestore.instance.collection('CallForService');

  // Get call list from snapshot
  List<CallForService> _callListFromSnapshot(QuerySnapshot snapshot) {
    var callList = snapshot.docs
        .map((doc) => CallForService.fromSnapshot(
            doc as DocumentSnapshot<Map<String, dynamic>>))
        .toList();

    // Sort the call list by their call number:
    // (this is a little tricky due to the call numbers being prefixed with the
    // year)
    callList.sort((a, b) {
      int callNumberA = int.parse(a.callNumber!.split('-')[1]);
      int callNumberB = int.parse(b.callNumber!.split('-')[1]);
      return callNumberA.compareTo(callNumberB);
    });

    return callList;
  }

  // Get CallForService stream
  Stream<List<CallForService>> get callList {
    return callCollection.snapshots().map(_callListFromSnapshot);
  }
}

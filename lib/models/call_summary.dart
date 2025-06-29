import 'package:cloud_firestore/cloud_firestore.dart';

/* CallSummary model
 */

class CallSummary {
  final String? id;
  final String? callNumber;
  final String? callType;
  final String? address;
  final DateTime? timeCreated;
  final DateTime? timeLastUpdated;

  CallSummary(
      {this.id,
      this.callNumber,
      this.callType,
      this.address,
      this.timeCreated,
      this.timeLastUpdated});

  // Factory creates a CallSummary from a Firebase DocumentSnapshot:
  factory CallSummary.fromSnapshot(
    DocumentSnapshot<Map<String, dynamic>> document,
  ) {
    final data = document.data()!;
    return CallSummary(
        id: document.id,
        callNumber: data['CallNumber'],
        callType: data['CallType'],
        address: data['Address'],
        timeCreated: data['TimeCreated'].toDate(),
        timeLastUpdated: data['LastUpdated'].toDate());
  }

  // Returns the time since the call summary was created in a UI friendly
  // format:
  String? timeSinceCreatedToString() {
    if (timeCreated == null) {
      return null;
    }

    final duration = DateTime.now().difference(timeCreated!);
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    return "${twoDigits(duration.inHours)} hours, $twoDigitMinutes minutes";
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';

class UnitSummary {
  final String? id;
  final String? status;
  final String? unitNumber;
  final DateTime? timeCreated;

  UnitSummary({this.id, this.status, this.unitNumber, this.timeCreated});

  // Factory creates a UnitSummary from a Firebase DocumentSnapshot:
  factory UnitSummary.fromSnapshot(
    DocumentSnapshot<Map<String, dynamic>> document,
  ) {
    final data = document.data()!;
    return UnitSummary(
      id: document.id,
      status: data['Status'],
      unitNumber: data['UnitNumber'],
      timeCreated: data['TimeCreated'].toDate(),
    );
  }

  // Get the time that the unit has been on the call. Since the UnitSummary
  // is a sub-collection of Call, the time the UnitSummary was created is also
  // the time the unit was assigned to the call.
  String? timeOnCallDurationToString() {
    // Null check first:
    if (timeCreated == null) {
      return null;
    }

    // Calculate duration unit has been on call:
    final duration = DateTime.now().difference(timeCreated!);
    // Format and return response:
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }
}

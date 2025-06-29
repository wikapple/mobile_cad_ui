import 'package:cloud_firestore/cloud_firestore.dart';

/* Unit model:
 */

class Unit {
  final String? id;
  final String? unitNumber;
  final String? name;
  final String? status;
  final DateTime? timeLastUpdated;

  Unit(
      {this.id, this.unitNumber, this.name, this.status, this.timeLastUpdated});

  // Factory creates a Unit from a Firebase DocumentSnapshot:
  factory Unit.fromSnapshot(
    DocumentSnapshot<Map<String, dynamic>> document,
  ) {
    final data = document.data()!;
    return Unit(
        id: document.id,
        unitNumber: data['UnitNumber'],
        name: data['Name'],
        status: data['Status'],
        timeLastUpdated: data['LastUpdated'].toDate());
  }
  // Get the duration since the Unit was last updated in the form
  // of a string. Only returns hours and minutes (unrounded) by default:
  String? lastUpdatedDurationToString({bool getSeconds = false}) {
    // Null check first:
    if (timeLastUpdated == null) {
      return null;
    }

    // Calculate duration:
    final duration = DateTime.now().difference(timeLastUpdated!);

    // Format String and return it:
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));

    // Only calculate seconds if getSeconds argument is set to true:
    if (getSeconds) {
      String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
      return "${twoDigits(duration.inHours)} hours, $twoDigitMinutes minutes, $twoDigitSeconds seconds";
    } else {
      return "${twoDigits(duration.inHours)} hours, $twoDigitMinutes minutes";
    }
  }
}

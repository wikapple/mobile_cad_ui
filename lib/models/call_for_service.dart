import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

/* CallForService model
 */
class CallForService {
  final String? id;
  final String? callNumber;
  final String? callType;
  final String? address;
  final String? status;
  final String? description;
  final String? caller;
  final int? numberOfUnitsAssigned;
  final DateTime? timeCreated;
  final DateTime? timeLastUpdated;

  CallForService(
      {this.id,
      this.callNumber,
      this.callType,
      this.address,
      this.status,
      this.description,
      this.caller,
      this.numberOfUnitsAssigned,
      this.timeCreated,
      this.timeLastUpdated});

  // Factory creates a CallForService from a Firebase DocumentSnapshot:
  factory CallForService.fromSnapshot(
    DocumentSnapshot<Map<String, dynamic>> document,
  ) {
    final data = document.data()!;
    return CallForService(
        id: document.id,
        callNumber: data['CallNumber'],
        callType: data['CallType'],
        address: data['Address'],
        status: data['Status'],
        description: data['Description'],
        caller: data['Caller_info'] ?? 'none',
        numberOfUnitsAssigned: data['NumberOfUnitsAssigned'],
        timeCreated: data['TimeCreated'].toDate(),
        timeLastUpdated: data['LastUpdated'].toDate());
  }

  // Calculates the total time a call has exists and returns the
  // result in String with a UI friendly format.
  String? callDurationToString() {
    // Null check first:
    if (timeCreated == null) {
      return null;
    }
    // Calculate the duration since the call was created:
    final duration = DateTime.now().difference(timeCreated!);

    // Format a string and return it:
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }

  // Calculates the total time since a call was last updated and returns
  // the result in a formatted string in a UI friendly format:
  String? lastUpdatedDurationToString() {
    // Null check first:
    if (timeLastUpdated == null) {
      return null;
    }

    // Calculate duration since the call was last updated:
    final duration = DateTime.now().difference(timeLastUpdated!);

    // Format and return String:
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }

  // Converts the time the call was created into a String with a UI
  // friendly date format:
  String? getFormattedTimeCreated() {
    if (timeCreated == null) {
      return null;
    }

    return DateFormat.yMd().add_jm().format(timeCreated!);
  }
}

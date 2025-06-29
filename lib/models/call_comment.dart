import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

/* CallComment model stores data from a CallComment in Firebase.
 */

class CallComment {
  final String? id;
  final String? comment;
  final DateTime? timeCreated;

  CallComment({this.id, this.comment, this.timeCreated});

  // Get a call comment from a Firebase document snapshot:
  factory CallComment.fromSnapshot(
    DocumentSnapshot<Map<String, dynamic>> document,
  ) {
    final data = document.data()!;

    return CallComment(
        id: document.id,
        comment: data['Comment'],
        timeCreated: data['TimeCreated'].toDate());
  }

  // Returns the time the comment was created in a UI friendly format:
  String? getFormattedTimeCreated() {
    if (timeCreated == null) {
      return null;
    }

    return DateFormat.yMd().add_jm().format(timeCreated!);
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/call_summary.dart';

// Retrieves Firebase data from a CallSummary collection, which is a sub
// collection of a given Unit document ID. Even though it is a collection,
// the CallSummary collection should only contain one CallSummary:

class CallSummaryService {
  CallSummaryService({required String uid}) {
    _uid = uid;
    _summaryCollectionReference = FirebaseFirestore.instance
        .collection('Unit')
        .doc(uid)
        .collection('CallSummary');
  }

  // A Unit's unique ID in Firebase:
  late final String _uid;
  // The full reference path to a collection of CallSummary's for a given
  // unit:
  late final CollectionReference _summaryCollectionReference;

  // Convert a snapshot to a CallSummary:
  CallSummary _summaryFromSnapshot(QuerySnapshot snapshot) {
    if (snapshot.docs.length == 0) {
      return CallSummary();
    }
    return CallSummary.fromSnapshot(
        snapshot.docs.first as DocumentSnapshot<Map<String, dynamic>>);
  }

  // Return a CallSummary stream by mapping Firebase snapshots into
  // CallSummaries:
  Stream<CallSummary> get callSummary {
    return _summaryCollectionReference.snapshots().map(_summaryFromSnapshot);
  }
}

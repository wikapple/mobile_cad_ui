import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobile_cad/models/unit_summary.dart';

/* Obtains List of all unit summaries from a sub-collection attached to a
   CallForService document. Listen for changes and update the list.
*/

class UnitSummaryService {
  UnitSummaryService({required String uid}) {
    _uid = uid;
    _summaryCollectionReference = FirebaseFirestore.instance
        .collection('CallForService')
        .doc(uid)
        .collection('UnitSummary');
  }
  // The unique document ID for a call for service, since we need all
  // Unit summaries in the sub-collection of this given call:
  late final String _uid;

  // A reference to the sub-collection we want data from:
  late final CollectionReference _summaryCollectionReference;

  // Convert a QuerySnapshot from firebase into a list of unit summaries:
  List<UnitSummary> _summaryListFromSnapshot(QuerySnapshot snapshot) {
    var summaryList = snapshot.docs
        .map((doc) => UnitSummary.fromSnapshot(
            doc as DocumentSnapshot<Map<String, dynamic>>))
        .toList();

    // Sort unit summaries by their status:
    summaryList.sort((a, b) => a.status!.compareTo(b.status!));
    return summaryList;
  }

  // Get updates on the UnitSummary list:
  Stream<List<UnitSummary>> get unitSummaryList {
    return _summaryCollectionReference
        .snapshots()
        .map(_summaryListFromSnapshot);
  }
}

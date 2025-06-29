import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/call_for_service.dart';

/* Obtains/converts a Call document into Call Details.
 */

class CallDetailsService {
  // documents Unique identifier:
  late final String _uid;

  // Document reference to the given Call document:
  late final DocumentReference _callDocument;

  CallDetailsService({required String uid}) {
    _uid = uid;
    _callDocument =
        FirebaseFirestore.instance.collection('CallForService').doc(uid);
  }

  // Map a DocumentSnapshot into a CallForService object:
  CallForService _callFromSnapshot(DocumentSnapshot snapshot) {
    return CallForService.fromSnapshot(
        snapshot as DocumentSnapshot<Map<String, dynamic>>);
  }

  // Get stream of the given callForService:
  Stream<CallForService> get callForService {
    return _callDocument.snapshots().map(_callFromSnapshot);
  }
}

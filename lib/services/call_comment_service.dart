import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobile_cad/models/call_comment.dart';

/* The CallCommentService connects to Firebase and holds a reference to a
   CallComment sub-collection of a specific Call. It provides a Stream that
   returns the list of CallComments:
 */

class CallCommentService {
  // Call document's unique identifier needed to access it's sub-collection
  // of call comments:
  late final String _uid;
  // Reference created to the call comments:
  late final CollectionReference _commentCollectionReference;

  CallCommentService({required String uid}) {
    _uid = uid;

    _commentCollectionReference = FirebaseFirestore.instance
        .collection('CallForService')
        .doc(uid)
        .collection('CallComment');
  }

  // Map a QuerySnapshot into a list of call comments using the CallComment
  // classe's fromSnapshot factory:
  List<CallComment> _commentListFromSnapshot(QuerySnapshot snapshot) {
    // Map QuerySnapshot to CallComment list:
    var commentList = snapshot.docs
        .map((doc) => CallComment.fromSnapshot(
            doc as DocumentSnapshot<Map<String, dynamic>>))
        .toList();

    // Sort calls by the time they were created:
    commentList.sort((a, b) => a.timeCreated!.compareTo(b.timeCreated!));

    return commentList;
  }

  // Create Stream of the call comment list:
  Stream<List<CallComment>> get callCommentList {
    return _commentCollectionReference
        .snapshots()
        .map(_commentListFromSnapshot);
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/unit.dart';

/* Obtains data for the Unit with the given unique ID number from Firebase
   and converts the database snapshot into the Unit model. Listens for database
   changes.
*/

class UnitDetailsService {
  UnitDetailsService({required String uid}) {
    _uid = uid;
    _unitDocument = FirebaseFirestore.instance.collection('Unit').doc(uid);
  }

  // The unique ID number for this Unit document in Firebase:
  late final String _uid;
  // The document reference to obtain data on the given Unit:
  late final DocumentReference _unitDocument;

  // Converts a firebase DocumentSnapshot into a Unit from the models folder
  Unit _unitFromSnapshot(DocumentSnapshot snapshot) {
    print(snapshot.reference);
    return Unit.fromSnapshot(
        snapshot as DocumentSnapshot<Map<String, dynamic>>);
  }

  // Listen for changes to the given unit and, when changes occur, map them
  // to the Unit model:
  Stream<Unit> get unit {
    return _unitDocument.snapshots().map(_unitFromSnapshot);
  }
}

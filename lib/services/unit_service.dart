import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobile_cad/models/unit.dart';

/* Obtains List of all units from Firebase and converts them
   into a List using the Unit model. Listen for database changes.
*/

class UnitService {
  // Collection Reference:
  final CollectionReference unitCollection =
      FirebaseFirestore.instance.collection('Unit');

  // Get unit list from snapshot:
  List<Unit> _unitListFromSnapshot(QuerySnapshot snapshot) {
    var unitList = snapshot.docs
        .map((doc) =>
            Unit.fromSnapshot(doc as DocumentSnapshot<Map<String, dynamic>>))
        .toList();

    // Sort the units by their Unit number (sort by the numeric suffix portion
    // and not by the 'PD-' prefix:
    unitList.sort((a, b) {
      int unitNumberA = int.parse(a.unitNumber!.split('-')[1]);
      int unitNumberB = int.parse(b.unitNumber!.split('-')[1]);
      return unitNumberA.compareTo(unitNumberB);
    });
    return unitList;
  }

  // Get Unit stream
  Stream<List<Unit>> get unitList {
    return unitCollection.snapshots().map(_unitListFromSnapshot);
  }
}

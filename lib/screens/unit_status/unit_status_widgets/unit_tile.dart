import 'package:flutter/material.dart';
import '../../../../models/unit.dart';

/* The UnitTile widget displays information on a single unit from a list
   of users. It can be clicked to display more unit details.
 */

class UnitTile extends StatelessWidget {
  const UnitTile({required this.unit, Key? key}) : super(key: key);

  // This unit:
  final Unit unit;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.pushNamed(context, 'Units/${unit.id}');
      },
      leading: ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: 100,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(
              Icons.local_police,
              color: Colors.lightBlue,
              size: 24,
            ),
            const SizedBox(
              width: 5,
            ),
            Text(
              unit.unitNumber.toString(),
              style: TextStyle(
                  color: Colors.grey[300],
                  fontSize: 22,
                  fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
      isThreeLine: true,
      title: Padding(
        padding: const EdgeInsets.only(
          bottom: 6,
        ),
        child: Align(
          alignment: Alignment.center,
          child: Text(
            unit.status.toString(),
            maxLines: 1,
            style: TextStyle(
                color: unit.status == 'Unavailable' || unit.status == 'Busy'
                    ? Colors.grey[400]
                    : unit.status == 'Available'
                        ? Colors.teal
                        : unit.status == "Assigned"
                            ? Colors.purple[300]
                            : unit.status == "En Route"
                                ? Colors.yellow[800]
                                : Colors.orange[800],
                fontSize: 20,
                fontWeight: FontWeight.w600),
          ),
        ),
      ),
      subtitle: Column(
        children: [
          Text(
            "Last Status Change: ",
            style: TextStyle(color: Colors.grey[400], fontSize: 14),
          ),
          Text(
            "${unit.lastUpdatedDurationToString()} ago",
            style: TextStyle(color: Colors.grey[300], fontSize: 14),
          ),
        ],
      ),
    );
  }
}

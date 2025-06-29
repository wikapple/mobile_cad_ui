import 'package:flutter/material.dart';
import 'package:mobile_cad/models/unit_summary.dart';

class UnitSummaryTile extends StatelessWidget {
  const UnitSummaryTile(
      {required this.unitSummary, required this.striped, Key? key})
      : super(key: key);
  final UnitSummary unitSummary;
  final bool striped;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 0,
        horizontal: 40,
      ),
      child: InkWell(
        onTap: () {
          if (unitSummary.id != null) {
            Navigator.pop(context);
            Navigator.pushNamed(context, 'Units/${unitSummary.id}');
          }
        },
        child: Container(
          padding: EdgeInsets.all(8),
          color: striped
              ? Colors.blueGrey.withOpacity(.1)
              : Colors.blueGrey.withOpacity(.05),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                unitSummary.unitNumber.toString(),
                style: TextStyle(
                  color: Colors.grey[300],
                ),
              ),
              Text(
                unitSummary.status.toString(),
                style: TextStyle(
                  color: Colors.grey[300],
                ),
              ),
              Text(
                unitSummary.timeOnCallDurationToString()!,
                style: TextStyle(
                  color: Colors.grey[300],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

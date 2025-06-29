import 'package:flutter/material.dart';

/* The UnitStatusDataTable takes a map of the count of units grouped by
   unit status and outputs the values to a table using the DataTable widget.
* */

class UnitStatusDataTable extends StatelessWidget {
  UnitStatusDataTable({
    super.key,
    required this.statusMap,
  }) {
    // Get the sum of all units in the Map:
    _totalCount = statusMap.values
        .reduce((sum, thisStatusCount) => sum += thisStatusCount);
  }

  final Map<String, int> statusMap;
  late final int _totalCount;

  @override
  Widget build(BuildContext context) {
    return DataTable(
      headingRowHeight: 5,
      dataRowHeight: 30,
      columnSpacing: 10,
      columns: const [
        DataColumn(label: Text('')),
        DataColumn(
          label: Text(
            '',
          ),
        ),
        DataColumn(label: Text(''))
      ],
      rows: [
        DataRow(cells: [
          DataCell(
            Container(
              width: 5,
              decoration: const BoxDecoration(
                color: Colors.teal,
                shape: BoxShape.circle,
              ),
            ),
          ),
          const DataCell(
            Text(
              'Available',
              style: TextStyle(
                color: Colors.teal,
                fontSize: 22,
              ),
            ),
          ),
          DataCell(
            Text(
              statusMap["Available"].toString(),
              style: const TextStyle(
                color: Colors.teal,
                fontSize: 22,
              ),
            ),
          ),
        ]),
        DataRow(
          cells: [
            DataCell(
              Container(
                width: 5,
                decoration: BoxDecoration(
                  color: Colors.purple[400],
                  shape: BoxShape.circle,
                ),
              ),
            ),
            DataCell(
              Text(
                'Assigned',
                style: TextStyle(
                  color: Colors.purple[400],
                  fontSize: 22,
                ),
              ),
            ),
            DataCell(
              Text(
                statusMap["Assigned"].toString(),
                style: TextStyle(
                  color: Colors.purple[400],
                  fontSize: 22,
                ),
              ),
            ),
          ],
        ),
        DataRow(
          cells: [
            DataCell(
              Container(
                width: 5,
                decoration: BoxDecoration(
                  color: Colors.yellow[800],
                  shape: BoxShape.circle,
                ),
              ),
            ),
            DataCell(Text(
              'EnRoute',
              style: TextStyle(
                color: Colors.yellow[800],
                fontSize: 22,
              ),
            )),
            DataCell(
              Text(
                statusMap["EnRoute"].toString(),
                style: TextStyle(
                  color: Colors.yellow[800],
                  fontSize: 22,
                ),
              ),
            ),
          ],
        ),
        DataRow(cells: [
          DataCell(
            Container(
              width: 5,
              decoration: BoxDecoration(
                color: Colors.orange[700],
                shape: BoxShape.circle,
              ),
            ),
          ),
          DataCell(Text(
            'OnScene',
            style: TextStyle(
              color: Colors.orange[700],
              fontSize: 22,
            ),
          )),
          DataCell(Text(
            statusMap["OnScene"].toString(),
            style: TextStyle(
              color: Colors.orange[300],
              fontSize: 22,
            ),
          )),
        ]),
        DataRow(
          cells: [
            DataCell(
              Container(
                width: 5,
                decoration: BoxDecoration(
                  color: Colors.grey[400],
                  shape: BoxShape.circle,
                ),
              ),
            ),
            DataCell(
              Text(
                'Total',
                style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              ),
            ),
            DataCell(
              Text(
                _totalCount.toString(),
                style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

import '../../../shared/app_constants.dart';

/* StatusRingChart takes a Map of the number of units grouped by unit status,
    and outputs a ring chart using the pie_chart package.
 */

class StatusRingChart extends StatelessWidget {
  const StatusRingChart({
    super.key,
    required Map<String, double> statusCountMap,
  }) : _statusCountMap = statusCountMap;

  // Map of values used to create ring graph:
  final Map<String, double> _statusCountMap;

  @override
  Widget build(BuildContext context) {
    // Use pie_chart package:
    return PieChart(
      chartType: ChartType.ring,
      animationDuration: const Duration(milliseconds: 1000),
      colorList: [
        Colors.teal,
        Colors.purple[600]!,
        Colors.yellow[700]!,
        Colors.orange[800]!
      ],
      chartValuesOptions: ChartValuesOptions(
        decimalPlaces: 0,
        chartValueBackgroundColor: backgroundColor,
        chartValueStyle: TextStyle(
            color: Colors.grey[300],
            fontSize: 18,
            fontFamily: "Oswald",
            fontWeight: FontWeight.bold),
      ),
      legendOptions: const LegendOptions(showLegends: false),
      dataMap: _statusCountMap,
    );
  }
}

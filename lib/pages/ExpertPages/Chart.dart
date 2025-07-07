import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class WeeklyOverviewChart extends StatelessWidget {
  const WeeklyOverviewChart({super.key});

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        alignment: BarChartAlignment.spaceAround,
        maxY: 100,
        barTouchData: BarTouchData(
          enabled: false,
        ),
        titlesData: FlTitlesData(
          show: true,
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (double value, TitleMeta meta) {
                switch (value.toInt()) {
                  case 0:
                    return const Text('Mon');
                  case 1:
                    return const Text('Tue');
                  case 2:
                    return const Text('Wed');
                  case 3:
                    return const Text('Thu');
                  case 4:
                    return const Text('Fri');
                  case 5:
                    return const Text('Sat');
                  case 6:
                    return const Text('Sun');
                  default:
                    return const Text('');
                }
              },
            ),
          ),
          leftTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: true),
          ),
        ),
        borderData: FlBorderData(
          show: false,
        ),
        barGroups: [
          BarChartGroupData(
              x: 0, barRods: [BarChartRodData(toY: 5, color: Colors.blue)]),
          BarChartGroupData(
              x: 1, barRods: [BarChartRodData(toY: 25, color: Colors.blue)]),
          BarChartGroupData(
              x: 2, barRods: [BarChartRodData(toY: 100, color: Colors.blue)]),
          BarChartGroupData(
              x: 3, barRods: [BarChartRodData(toY: 75, color: Colors.blue)]),
          BarChartGroupData(
              x: 4, barRods: [BarChartRodData(toY: 55, color: Colors.blue)]),
          BarChartGroupData(
              x: 5, barRods: [BarChartRodData(toY: 30, color: Colors.blue)]),
          BarChartGroupData(
              x: 6, barRods: [BarChartRodData(toY: 10, color: Colors.blue)]),
        ],
      ),
    );
  }
}

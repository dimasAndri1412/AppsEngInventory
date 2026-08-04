import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ChatCard extends StatefulWidget {
  const ChatCard({super.key});

  @override
  State<ChatCard> createState() => _ChatCardState();
}

class _ChatCardState extends State<ChatCard> {
  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        borderData: FlBorderData(show: false),
        gridData: const FlGridData(show: false),
        titlesData: const FlTitlesData(show: true),
        lineBarsData: [
          LineChartBarData(
            spots: [
              const FlSpot(0, 2),
              const FlSpot(1, 5),
              const FlSpot(2, 3),
              const FlSpot(3, 6),
            ],
          ),
        ],
      ),
    );
  }
}

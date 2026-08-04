import 'package:flutter/material.dart';

class SummaryCard extends StatelessWidget {
  final String title;
  final String value;
  final String unit;
  final IconData icon;
  final Color color;

  const SummaryCard({
    super.key,
    required this.title,
    required this.value,
    required this.unit,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return  Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(.1),
            blurRadius: 10,
          )
        ],
      ),
      child: Row(
        children: [

          Expanded(
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [

                Text(title),

                const SizedBox(height:8),

                Text(
                  value,
                  style: const TextStyle(
                    fontSize:28,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                Text(unit),
              ],
            ),
          ),

          CircleAvatar(
            backgroundColor: color,
            child: Icon(icon,color: Colors.white),
          )
        ],
      ),
    );
  }
}

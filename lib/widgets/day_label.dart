import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DayLabel extends StatelessWidget {
  final int dayIndex;
  final DateTime date;
  final bool isSelected;

  const DayLabel({
    Key? key,
    required this.dayIndex,
    required this.date,
    this.isSelected = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateFormat formatter = DateFormat('MMM dd, yyyy');
    return InkWell(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: isSelected ? const Color(0xFF3B50F5) : const Color(0xfff2f3f8),
        ),
        child: Center(
          child: RichText(
            text: TextSpan(
              children: <TextSpan>[
                TextSpan(
                  text: 'Day $dayIndex',
                ),
                const TextSpan(
                  text: '\n',
                ),
                TextSpan(
                  text: formatter.format(date),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

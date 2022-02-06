import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class DayLabel extends StatelessWidget {
  final int dayIndex;
  final DateTime date;
  final bool isSelected;
  final Function()? onPressed;

  const DayLabel({
    Key? key,
    required this.dayIndex,
    required this.date,
    this.isSelected = false,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateFormat formatter = DateFormat('MMM dd, yyyy');
    return InkWell(
      onTap: onPressed,
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
                  style: GoogleFonts.montserrat(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: isSelected ? Colors.white : Colors.black,
                  ),
                ),
                const TextSpan(
                  text: '\n',
                ),
                TextSpan(
                  text: formatter.format(date),
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: isSelected ? Colors.white : Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

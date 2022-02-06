import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final Function()? onPressed;

  const LoginButton({
    Key? key,
    required this.icon,
    required this.text,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 4.0, bottom: 4.0),
      child: TextButton(
        onPressed: onPressed,
        style: ButtonStyle(
          shape: MaterialStateProperty.resolveWith<OutlinedBorder>(
            (states) => RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                12.0,
              ),
            ),
          ),
          // backgroundColor: MaterialStateProperty.resolveWith<Color>(
          //     (states) => Colors.black),
          padding: MaterialStateProperty.resolveWith<EdgeInsetsGeometry>(
            (states) =>
                const EdgeInsets.only(left: 22, top: 20, right: 22, bottom: 20),
          ),
          backgroundColor: MaterialStateProperty.resolveWith<Color>(
            (states) => states.contains(MaterialState.disabled)
                ? Colors.grey
                : const Color(0xFF1E1E1E),
          ),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Icon(
                icon,
                color: Colors.white,
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                text,
                style: GoogleFonts.nunito(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 18.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

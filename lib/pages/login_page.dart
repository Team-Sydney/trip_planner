import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:trip_planner/backend/controllers/auth_controller.dart';
import 'package:trip_planner/widgets/login_button.dart';

class LoginPage extends StatefulWidget {
  static const routeName = '/login';
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final AuthController authController = AuthController();
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.only(left: 24.0, right: 24.0),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Align(
                alignment: Alignment.center,
                child: Text(
                  'Viato',
                  style: GoogleFonts.pacifico(
                    fontSize: 72.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // RichText(
                    //   text: TextSpan(
                    //     text: 'Sign into',
                    //     style: GoogleFonts.montserrat(
                    //       fontSize: 20.0,
                    //       fontWeight: FontWeight.w400,
                    //       color: Colors.black,
                    //     ),
                    //     children: [
                    //       TextSpan(
                    //         text: ' Viator ',
                    //         style: GoogleFonts.pacifico(
                    //           fontSize: 20.0,
                    //           fontWeight: FontWeight.w400,
                    //           color: Colors.black,
                    //         ),
                    //       ),
                    //       const TextSpan(text: 'with'),
                    //     ],
                    //   ),
                    // ),
                    LoginButton(
                      onPressed: () =>
                          authController.authenticate(LoginProvider.apple),
                      icon: Ionicons.logo_apple,
                      text: 'Apple',
                    ),
                    LoginButton(
                      onPressed: () =>
                          authController.authenticate(LoginProvider.google),
                      icon: Ionicons.logo_google,
                      text: 'Google',
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

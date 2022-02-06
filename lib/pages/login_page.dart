import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:ionicons/ionicons.dart';
import 'package:viato/backend/controllers/auth_controller.dart';
import 'package:viato/backend/models/user.dart';
import 'package:viato/backend/utils/static_queries.dart';
import 'package:viato/pages/home_page.dart';
import 'package:viato/widgets/login_button.dart';

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
                    // LoginButton(
                    //   onPressed: () =>
                    //       authController.authenticate(LoginProvider.apple),
                    //   icon: Ionicons.logo_apple,
                    //   text: 'Apple',
                    // ),
                    Mutation(
                      options: MutationOptions(
                        document: gql(StaticQueries.login),
                        update: (GraphQLDataProxy cache, QueryResult? result) {
                          return cache;
                        },
                        onCompleted: (dynamic resultData) {
                          if (resultData != null) {
                            Navigator.of(context).pushReplacementNamed(
                                HomePage.routeName,
                                arguments: HomePageArguments(User.fromJson(
                                    resultData!['login']['user'])));
                          }
                        },
                      ),
                      builder: (
                        RunMutation runMutation,
                        QueryResult? result,
                      ) {
                        return LoginButton(
                          onPressed: () async {
                            Map<String, dynamic> details =
                                await authController.signInWithGoogle();

                            List<String> names =
                                (details['name'] as String).split(' ');
                            String fName = names.removeAt(0);
                            runMutation({
                              'email': details['email'],
                              'firstName': fName,
                              'lastName': names.join(' '),
                            });
                          },
                          icon: Ionicons.logo_google,
                          text: 'Google',
                        );
                      },
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

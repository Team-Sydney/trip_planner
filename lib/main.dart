import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:viato/pages/home_page.dart';
import 'package:viato/pages/login_page.dart';
import 'package:viato/pages/timeline_page.dart';

void main() {
  runApp(const TripPlanner());
}

class TripPlanner extends StatelessWidget {
  const TripPlanner({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Trip Planner',
      theme: ThemeData(
        canvasColor: Colors.white,
        primarySwatch: Colors.purple,
        appBarTheme: AppBarTheme(
          color: Colors.white,
          iconTheme: const IconThemeData(
            color: Colors.black,
          ),
          titleTextStyle: GoogleFonts.montserrat(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        textTheme: TextTheme(
          headline1: GoogleFonts.montserrat(
            fontSize: 32,
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
          headline2: GoogleFonts.montserrat(
            fontSize: 24,
            color: Colors.black,
            fontWeight: FontWeight.w700,
          ),
          headline3: GoogleFonts.montserrat(
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
          headline4: GoogleFonts.montserrat(
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
          headline5: GoogleFonts.montserrat(
            fontSize: 12,
            fontWeight: FontWeight.w700,
          ),
          headline6: GoogleFonts.montserrat(
            fontSize: 10,
            fontWeight: FontWeight.w700,
          ),
          bodyText1: GoogleFonts.montserrat(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
          bodyText2: GoogleFonts.montserrat(
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
          button: GoogleFonts.montserrat(
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
          caption: GoogleFonts.montserrat(
            fontSize: 12,
            fontWeight: FontWeight.w700,
          ),
          overline: GoogleFonts.montserrat(
            fontSize: 10,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      initialRoute: '/',
      routes: {
        RootPage.routeName: (context) => const RootPage(),
        HomePage.routeName: (context) => const HomePage(),
        LoginPage.routeName: (context) => const LoginPage(),
        TimelinePage.routeName: (context) => const TimelinePage(),
      },
    );
  }
}

class RootPage extends StatefulWidget {
  static const routeName = '/';
  const RootPage({Key? key}) : super(key: key);

  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(builder: ((context, snapshot) {
      if (snapshot.hasData) {
        return const HomePage();
      } else {
        return const LoginPage();
      }
    }));
  }
}

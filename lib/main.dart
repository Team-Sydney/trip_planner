import 'package:flutter/material.dart';
import 'package:trip_planner/pages/home_page.dart';
import 'package:trip_planner/pages/login_page.dart';
import 'package:trip_planner/pages/timeline_page.dart';

void main() {
  runApp(const TripPlanner());
}

class TripPlanner extends StatelessWidget {
  const TripPlanner({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(builder: ((context, snapshot) {
      String initalRoute =
          snapshot.hasData ? HomePage.routeName : LoginPage.routeName;
      return MaterialApp(
        title: 'Trip Planner',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: initalRoute,
        routes: {
          RootPage.routeName: (context) => const RootPage(),
          HomePage.routeName: (context) => const HomePage(),
          LoginPage.routeName: (context) => const LoginPage(),
          TimelinePage.routeName: (context) => const TimelinePage(),
        },
      );
    }));
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
    return const Scaffold(
      body: Center(
        child: Text('Something went wrong'),
      ),
    );
  }
}

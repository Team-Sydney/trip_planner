import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:viato/backend/models/user.dart';
import 'package:viato/pages/create_trip.dart';
import 'package:viato/pages/timeline_page.dart';

class HomePageArguments {
  final User user;
  HomePageArguments(this.user);
}

class HomePage extends StatefulWidget {
  static const routeName = '/home';
  const HomePage({Key? key, this.user}) : super(key: key);

  final User? user;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late User user;

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as HomePageArguments;

    if (widget.user == null) {
      user = args.user;
    }

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            title: Text(
              'Viato',
              style: GoogleFonts.pacifico(
                fontSize: 26.0,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.all(16),
              child: Text("Your trips",
                  style: Theme.of(context).textTheme.headline2),
            ),
          ),
          SliverToBoxAdapter(
            child: InkWell(
              onTap: () =>
                  Navigator.pushNamed(context, CreateTripPage.routeName),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                height: 64,
                decoration: BoxDecoration(
                  color: const Color(0xFF3B50F5),
                  borderRadius: BorderRadius.circular(4),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      offset: const Offset(0.0, 0.0),
                      blurRadius: 12.0,
                      spreadRadius: 0.0,
                    ), //BoxShadow
                  ],
                ),
                child: const Center(
                  child: Icon(Ionicons.add, color: Colors.white),
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              return InkWell(
                onTap: () {
                  Navigator.pushNamed(context, TimelinePage.routeName,
                      arguments: TimelinePageArugments(user.trips[index]));
                },
                child: Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        offset: const Offset(0.0, 0.0),
                        blurRadius: 12.0,
                        spreadRadius: 0.0,
                      ), //BoxShadow
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: Image.network(
                          user.trips[index].photoUrl,
                          height: 96,
                          width: 96,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Text(
                        user.trips[index].title,
                        style: Theme.of(context).textTheme.headline3,
                      ),
                      Text(
                          (user.trips[index].endDate
                                          .difference(
                                              user.trips[index].startDate)
                                          .inDays +
                                      1)
                                  .toString() +
                              "\ndays",
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.headline4),
                    ],
                  ),
                ),
              );
            }, childCount: user.trips.length),
          ),
        ],
      ),
    );
  }
}

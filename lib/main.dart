import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gql_dio_link/gql_dio_link.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:viato/backend/models/user.dart';
import 'package:viato/backend/utils/static_queries.dart';
import 'package:viato/pages/create_trip.dart';
import 'package:viato/pages/home_page.dart';
import 'package:viato/pages/login_page.dart';
import 'package:viato/pages/timeline_page.dart';
import "package:dio/dio.dart";

void main() async {
  await initHiveForFlutter();
  runApp(const TripPlanner());
}

class TripPlanner extends StatelessWidget {
  const TripPlanner({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final dio = Dio();
    final cookieJar = CookieJar();
    dio.interceptors.add(CookieManager(cookieJar));

    final Link _dioLink = DioLink(
      'https://tripplanner-backend-s3urw.ondigitalocean.app/graphql',
      client: dio,
    );

    ValueNotifier<GraphQLClient> client = ValueNotifier(
      GraphQLClient(
        link: _dioLink,
        cache: GraphQLCache(store: HiveStore()),
      ),
    );

    return GraphQLProvider(
      client: client,
      child: MaterialApp(
        title: 'Trip Planner',
        theme: ThemeData(
          canvasColor: Colors.white,
          primarySwatch: Colors.purple,
          dialogTheme: DialogTheme(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            titleTextStyle: GoogleFonts.montserrat(
              fontSize: 24,
              color: Colors.black,
              fontWeight: FontWeight.w700,
            ),
            contentTextStyle: GoogleFonts.montserrat(
              fontSize: 16,
              color: Colors.black.withOpacity(0.85),
              fontWeight: FontWeight.w700,
            ),
          ),
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
              color: Colors.black.withOpacity(0.85),
              fontWeight: FontWeight.w700,
            ),
            headline4: GoogleFonts.montserrat(
              fontSize: 14,
              color: const Color(0xFF3B50F5),
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
          CreateTripPage.routeName: (context) => const CreateTripPage(),
        },
      ),
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
    return Query(
      options: QueryOptions(
        document: gql(StaticQueries.login),
      ),
      builder: (QueryResult result,
          {Future<QueryResult> Function(FetchMoreOptions)? fetchMore,
          Future<QueryResult?> Function()? refetch}) {
        if (result.hasException) {
          return const LoginPage();
        }

        if (result.isLoading) {
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
                  ],
                ),
              ),
            ),
          );
        }

        // print(result.data!['login']['user']);
        User user = User.fromJson(result.data!['login']['user']);
        return const HomePage();
      },
    );
  }
}

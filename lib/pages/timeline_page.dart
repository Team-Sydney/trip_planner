import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';
import 'package:viato/backend/models/attraction.dart';
import 'package:viato/backend/models/hotel.dart';
import 'package:viato/backend/models/item.dart';
import 'package:viato/backend/models/trip.dart';
import 'package:viato/widgets/day_label.dart';
import 'package:viato/widgets/info_card.dart';
import 'package:timelines/timelines.dart';

class TimelinePageArugments {
  final Trip trip;

  TimelinePageArugments(this.trip);
}

class TimelinePage extends StatefulWidget {
  static const routeName = '/timeline';
  const TimelinePage({Key? key}) : super(key: key);

  @override
  _TimelinePageState createState() => _TimelinePageState();
}

class _TimelinePageState extends State<TimelinePage> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as TimelinePageArugments;
    // final TestTrip = Trip.fromJson({
    //   'id': '0',
    //   'destination': "Ottawa",
    //   'title': "Trip to Ottawa 2022",
    //   'startDate': DateTime(2022, 2, 4).toIso8601String(),
    //   'endDate': DateTime(2022, 2, 8).toIso8601String(),
    //   'users': []
    // });

    DateFormat formatter = DateFormat('jm');

    final List<Item> events = [];
    events.addAll(args.trip.hotels);
    events.addAll(args.trip.attractions);
    events.sort((a, b) => a.startTime.compareTo(b.startTime));

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            title: Text(args.trip.title.toUpperCase()),
            leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Ionicons.chevron_back),
            ),
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Ionicons.ellipsis_horizontal),
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 192,
              child: Stack(
                alignment: Alignment.center,
                fit: StackFit.expand,
                children: [
                  Image.network(
                    args.trip.photoUrl,
                    fit: BoxFit.cover,
                  ),
                  Container(
                    height: 350.0,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      gradient: LinearGradient(
                        begin: FractionalOffset.topCenter,
                        end: FractionalOffset.bottomCenter,
                        colors: [
                          Colors.grey.withOpacity(0.0),
                          Colors.black,
                        ],
                        stops: const [0.0, 1.0],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Container(
                      margin: const EdgeInsets.all(16.0),
                      child: Text(args.trip.destination.toUpperCase(),
                          style: Theme.of(context).textTheme.headline1),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: InfoCard(
              onPressed: () {},
              title: 'Manage members',
              info: Container(
                padding: const EdgeInsets.only(left: 6),
                height: 32,
                child: ListView.builder(
                  itemBuilder: ((context, index) {
                    return Align(
                      widthFactor: 0.5,
                      child: CircleAvatar(
                        backgroundColor: Colors.grey,
                        foregroundImage: NetworkImage(
                            'https://picsum.photos/id/100${index.toString()}/200'),
                      ),
                    );
                  }),
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: args.trip.tripUsers.length,
                ),
              ),
            ),
          ),
          const SliverToBoxAdapter(child: Divider()),
          SliverToBoxAdapter(
            child: InfoCard(
              onPressed: () {},
              title: 'Manage itinerary',
              info: Text('3 items need your attention',
                  style: Theme.of(context).textTheme.headline5),
            ),
          ),
          const SliverToBoxAdapter(child: Divider()),
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.all(16),
              child: Text("Timeline",
                  style: Theme.of(context).textTheme.headline2),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 64,
              child: ListView.separated(
                separatorBuilder: (context, index) => const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.0),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                scrollDirection: Axis.horizontal,
                itemBuilder: ((context, index) {
                  return DayLabel(
                    dayIndex: index + 1,
                    date: args.trip.startDate.add(Duration(days: index)),
                    isSelected: index == selectedIndex,
                    onPressed: () {
                      setState(() {
                        selectedIndex = index;
                      });
                    },
                  );
                }),
                itemCount:
                    args.trip.endDate.difference(args.trip.startDate).inDays +
                        1,
              ),
            ),
          ),
          const SliverPadding(padding: EdgeInsets.all(8)),
          SliverFillRemaining(
            child: Timeline.tileBuilder(
              theme: TimelineThemeData(
                color: const Color(0xFF3B50F5),
                nodePosition: 0.05,
              ),
              builder: TimelineTileBuilder.fromStyle(
                  contentsAlign: ContentsAlign.basic,
                  contentsBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Text(
                            '${events[index].name} - ${formatter.format(events[index].startTime)}'),
                      ),
                  itemCount: events
                      .where((e) =>
                          e.startTime.day ==
                          args.trip.startDate
                              .add(Duration(days: selectedIndex))
                              .day)
                      .length),
            ),
          ),
        ],
      ),
    );
  }
}

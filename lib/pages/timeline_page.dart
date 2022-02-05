import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class TimelinePage extends StatefulWidget {
  static const routeName = '/timeline';
  const TimelinePage({Key? key}) : super(key: key);

  @override
  _TimelinePageState createState() => _TimelinePageState();
}

class _TimelinePageState extends State<TimelinePage> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          title: const Text("Trip Details Plan"),
          leading: IconButton(
            onPressed: () {},
            icon: const Icon(Ionicons.arrow_back),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Ionicons.ellipsis_horizontal),
            ),
          ],
        ),
      ],
    );
  }
}

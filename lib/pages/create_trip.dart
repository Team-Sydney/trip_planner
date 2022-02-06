import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:ionicons/ionicons.dart';
import 'package:viato/backend/models/trip.dart';
import 'package:viato/backend/models/user.dart';
import 'package:viato/backend/utils/static_queries.dart';

class CreateTripPageArguments {
  final User user;

  CreateTripPageArguments(this.user);
}

class CreateTripPage extends StatefulWidget {
  static const String routeName = '/create-trip';
  const CreateTripPage({Key? key}) : super(key: key);

  @override
  _CreateTripPageState createState() => _CreateTripPageState();
}

class _CreateTripPageState extends State<CreateTripPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _destinationController = TextEditingController();

  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final CreateTripPageArguments args =
        ModalRoute.of(context)?.settings.arguments as CreateTripPageArguments;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            pinned: true,
            title: Text(
              'Create Trip',
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: _titleController,
                    decoration: const InputDecoration(
                      labelText: 'Title',
                    ),
                  ),
                  TextField(
                    controller: _destinationController,
                    decoration: const InputDecoration(
                      labelText: 'Destination',
                    ),
                  ),
                  TextButton.icon(
                    onPressed: () async {
                      final DateTimeRange? picked = await showDateRangePicker(
                        context: context,
                        firstDate: DateTime.now(),
                        lastDate:
                            DateTime.now().add(const Duration(days: 365 * 5)),
                        initialEntryMode: DatePickerEntryMode.inputOnly,
                      );
                      if (picked != null) {
                        startDate = picked.start;
                        endDate = picked.end;
                      }
                    },
                    icon: const Icon(
                      Ionicons.calendar,
                    ),
                    label: const Text('Select Dates'),
                  ),
                  Mutation(
                    options: MutationOptions(
                      document: gql(StaticQueries.createTrip),
                      update: (GraphQLDataProxy cache, QueryResult? result) {
                        if (result?.data != null) {
                          Trip trip =
                              Trip.fromJson(result!.data!['createTrip']);
                          setState(() {
                            args.user.trips.add(trip);
                          });
                        }
                        return cache;
                      },
                      onCompleted: (dynamic resultData) {
                        Navigator.pop(context);
                      },
                    ),
                    builder: (
                      RunMutation runMutation,
                      QueryResult? result,
                    ) {
                      return InkWell(
                        onTap: () => runMutation({
                          'title': _titleController.text,
                          'destination': _destinationController.text,
                          'startDate': startDate.toIso8601String(),
                          'endDate': endDate.toIso8601String(),
                        }),
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
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

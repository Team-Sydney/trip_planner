import 'package:trip_planner/backend/models/trip.dart';

class User {
  final int id;
  String firstName;
  String lastName;
  String email;
  List<Trip> trips;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    this.trips = const [],
  });

  String get name => "$firstName $lastName";
}

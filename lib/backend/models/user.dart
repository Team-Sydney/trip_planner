import 'package:trip_planner/backend/models/trip.dart';

class User {
  final int id;
  String _firstName;
  String _lastName;
  String _email;
  List<Trip> _trips;

  User.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        _firstName = json['first_name'],
        _lastName = json['last_name'],
        _email = json['email'],
        _trips =
            (json['trips'] as List).map((trip) => Trip.fromJson(trip)).toList();

  Map<String, dynamic> toJson() => {
        'id': id,
        'first_name': _firstName,
        'last_name': _lastName,
        'email': _email,
        'trips': _trips,
      };

  String get name => '$firstName $lastName';

  set firstName(String firstName) {
    _firstName = firstName;
  }

  String get firstName => _firstName;

  set lastName(String lastName) {
    _lastName = lastName;
  }

  String get lastName => _lastName;

  set email(String email) {
    _email = email;
  }

  String get email => _email;

  set trips(List<Trip> trips) {
    _trips = trips;
  }

  List<Trip> get trips => _trips;
}

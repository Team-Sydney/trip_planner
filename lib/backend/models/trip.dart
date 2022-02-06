import 'package:trip_planner/backend/models/User.dart';

class Trip {
  final int id;
  String _title;
  final String destination;
  DateTime _startDate;
  DateTime _endDate;
  List<User> _users;

  Trip.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        destination = json['destination'],
        _title = json['title'],
        _startDate = DateTime.parse(json['startDate']),
        _endDate = DateTime.parse(json['endDate']),
        _users =
            (json['users'] as List).map((user) => User.fromJson(user)).toList();

  Map<String, dynamic> toJson() => {
        'id': id,
        'destination': destination,
        'title': _title,
        'startDate': _startDate.toIso8601String(),
        'endDate': _endDate.toIso8601String(),
        'users': _users,
      };

  set title(String title) {
    _title = title;
  }

  String get title => _title;

  set startDate(DateTime startDate) {
    _startDate = startDate;
  }

  DateTime get startDate => _startDate;

  set endDate(DateTime endDate) {
    _endDate = endDate;
  }

  DateTime get endDate => _endDate;

  set users(List<User> users) {
    _users = users;
  }

  List<User> get users => _users;
}

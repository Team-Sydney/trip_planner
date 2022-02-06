import 'package:viato/backend/models/attraction.dart';
import 'package:viato/backend/models/hotel.dart';
import 'package:viato/backend/models/user.dart';

class Trip {
  final int id;
  String _title;
  final String destination;
  DateTime _startDate;
  DateTime _endDate;
  List<User> _users;
  List<dynamic> tripUsers;
  String _photoUrl;
  List<Hotel> hotels;
  List<Attraction> attractions;

  Trip.fromJson(Map<String, dynamic> json)
      : id = int.parse(json['id']),
        destination = json['destination'],
        _title = json['title'],
        _startDate = DateTime.parse(json['startDate']),
        _endDate = DateTime.parse(json['endDate']),
        _users = ((json['users'] as List?) ?? [])
            .map((user) => User.fromJson(user))
            .toList(),
        tripUsers = ((json['tripUsers'] as List?) ?? []),
        _photoUrl = 'https://picsum.photos/id/${json['id'].toString()}/600',
        hotels = ((json['hotels'] as List?) ?? [])
            .map((hotel) => Hotel.fromJson(hotel))
            .toList(),
        attractions = ((json['attractions'] as List?) ?? [])
            .map((attraction) => Attraction.fromJson(attraction))
            .toList();

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

  set photoUrl(String photoUrl) {
    _photoUrl = photoUrl;
  }

  String get photoUrl => _photoUrl;
}

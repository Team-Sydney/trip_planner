import 'package:trip_planner/backend/models/item.dart';

class Transportation extends Item {
  Transportation({
    required int id,
    required String name,
    required String address,
    required String url,
    required DateTime startTime,
    required DateTime endTime,
  }) : super(
          id: id,
          name: name,
          address: address,
          url: url,
          startTime: startTime,
          endTime: endTime,
        );
}

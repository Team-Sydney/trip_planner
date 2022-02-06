import 'package:viato/backend/models/item.dart';

class Hotel extends Item {
  Hotel({
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

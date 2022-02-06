class Item {
  final int id;
  String name;
  String? address;
  String url;
  DateTime startTime;
  DateTime endTime;

  Item.fromJson(Map<String, dynamic> json)
      : id = int.parse(json['id']),
        name = json['name'],
        address = json['address'],
        url = json['url'] ?? '',
        startTime = DateTime.parse(json['startDate']),
        endTime = DateTime.parse(json['endDate']);
}

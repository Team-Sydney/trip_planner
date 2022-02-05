class Item {
  final int id;
  String name;
  String? address;
  String url;
  DateTime startTime;
  DateTime endTime;

  Item({
    required this.id,
    required this.name,
    required this.address,
    required this.url,
    required this.startTime,
    required this.endTime,
  });
}

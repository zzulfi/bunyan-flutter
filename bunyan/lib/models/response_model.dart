class ExampleData {
  final String id;
  final String name;
  // final String description;

  ExampleData({required this.id, required this.name});

  factory ExampleData.fromJson(Map<String, dynamic> json) {
    return ExampleData(
      id: json['id'],
      name: json['name'],
      // description: json['description'],
    );
  }
}

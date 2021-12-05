class Picture {
  final int? id;
  final String name;

  Picture({this.id, required this.name});

  factory Picture.fromMap(Map<String, dynamic> json) => Picture(
    id: json['id'],
    name: json['name'],
  );

  Map<String, dynamic> toMap() {
    return {
      'id' : id,
      'name' : name,
    };
  }
}
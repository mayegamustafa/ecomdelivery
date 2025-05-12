class Pages {
  final List<Data> data;
  Pages({
    required this.data,
  });

  Map<String, dynamic> toMap() {
    return {
      'data': data.map((x) => x.toMap()).toList(),
    };
  }

  factory Pages.fromMap(Map<String, dynamic> map) {
    return Pages(
      data: List<Data>.from(map['data']?.map((x) => Data.fromMap(x))),
    );
  }
}

class Data {
  final String uid;
  final String name;
  final String description;
  Data({
    required this.uid,
    required this.name,
    required this.description,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'description': description,
    };
  }

  factory Data.fromMap(Map<String, dynamic> map) {
    return Data(
      uid: map['uid'] ?? '',
      name: map['name'] ?? '',
      description: map['description'] ?? '',
    );
  }
}

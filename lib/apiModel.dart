class ApiModel {
  final int count;
  final List<Entry> entries;

  ApiModel({required this.count, required this.entries});

  factory ApiModel.fromJson(Map<String, dynamic> json) {
    return ApiModel(
      count: json['count'],
      entries: List<Entry>.from(
          json['entries'].map((entry) => Entry.fromJson(entry))),
    );
  }
}

class Entry {
  final String api;
  final String description;
  final String auth;
  final bool https;
  final String cors;
  final String link;
  final String category;

  Entry({
    required this.api,
    required this.description,
    required this.auth,
    required this.https,
    required this.cors,
    required this.link,
    required this.category,
  });

  factory Entry.fromJson(Map<String, dynamic> json) {
    return Entry(
      api: json['API'],
      description: json['Description'],
      auth: json['Auth'],
      https: json['HTTPS'],
      cors: json['Cors'],
      link: json['Link'],
      category: json['Category'],
    );
  }
}

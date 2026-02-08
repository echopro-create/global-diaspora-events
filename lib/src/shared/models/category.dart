class Category {
  final String id;
  final String name;
  final String? iconUrl;

  Category({required this.id, required this.name, this.iconUrl});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'].toString(),
      name: json['name'],
      iconUrl: json['icon_url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, if (iconUrl != null) 'icon_url': iconUrl};
  }
}

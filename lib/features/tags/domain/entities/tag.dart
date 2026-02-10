/// Модель тега события.
class Tag {
  final String id;
  final String name;
  final String slug;
  final DateTime createdAt;

  const Tag({
    required this.id,
    required this.name,
    required this.slug,
    required this.createdAt,
  });

  factory Tag.fromJson(Map<String, dynamic> json) {
    return Tag(
      id: json['id'] as String,
      name: json['name'] as String,
      slug: json['slug'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'slug': slug};
  }
}

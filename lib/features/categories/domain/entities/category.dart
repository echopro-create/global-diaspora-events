/// Модель категории события.
class Category {
  final String id;
  final String name;
  final String slug;
  final String? icon;
  final int sortOrder;

  const Category({
    required this.id,
    required this.name,
    required this.slug,
    this.icon,
    this.sortOrder = 0,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'] as String,
      name: json['name'] as String,
      slug: json['slug'] as String,
      icon: json['icon'] as String?,
      sortOrder: json['sort_order'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'slug': slug,
      if (icon != null) 'icon': icon,
      'sort_order': sortOrder,
    };
  }
}

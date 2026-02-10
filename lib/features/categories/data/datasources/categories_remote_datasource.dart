import 'package:supabase_flutter/supabase_flutter.dart';

import '../../domain/entities/category.dart';

/// Remote data source для категорий (Supabase).
class CategoriesRemoteDataSource {
  final SupabaseClient _client;

  CategoriesRemoteDataSource(this._client);

  /// Получить все категории.
  Future<List<Category>> getCategories() async {
    final response = await _client
        .from('categories')
        .select()
        .order('sort_order');

    return (response as List)
        .map((json) => Category.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  /// Получить категорию по ID.
  Future<Category> getCategoryById(String id) async {
    final response = await _client
        .from('categories')
        .select()
        .eq('id', id)
        .single();

    return Category.fromJson(response);
  }
}

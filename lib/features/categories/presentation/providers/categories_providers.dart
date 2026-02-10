import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/providers/core_providers.dart';
import '../../data/datasources/categories_remote_datasource.dart';
import '../../data/repositories/categories_repository_impl.dart';
import '../../domain/entities/category.dart';

/// Provider для CategoriesRemoteDataSource.
final categoriesRemoteDataSourceProvider = Provider<CategoriesRemoteDataSource>(
  (ref) {
    return CategoriesRemoteDataSource(ref.watch(supabaseClientProvider));
  },
);

/// Provider для CategoriesRepository.
final categoriesRepositoryProvider = Provider<CategoriesRepository>((ref) {
  return CategoriesRepository(ref.watch(categoriesRemoteDataSourceProvider));
});

/// Provider для списка категорий.
final categoriesProvider = FutureProvider<List<Category>>((ref) async {
  final repo = ref.watch(categoriesRepositoryProvider);
  return repo.getCategories();
});

/// Provider для одной категории по ID.
final categoryByIdProvider = FutureProvider.family<Category, String>((
  ref,
  id,
) async {
  final repo = ref.watch(categoriesRepositoryProvider);
  return repo.getCategoryById(id);
});

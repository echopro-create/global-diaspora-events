import '../../domain/entities/category.dart';
import '../datasources/categories_remote_datasource.dart';

/// Репозиторий категорий.
class CategoriesRepository {
  final CategoriesRemoteDataSource _remoteDataSource;

  CategoriesRepository(this._remoteDataSource);

  Future<List<Category>> getCategories() {
    return _remoteDataSource.getCategories();
  }

  Future<Category> getCategoryById(String id) {
    return _remoteDataSource.getCategoryById(id);
  }
}

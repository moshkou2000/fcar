import 'package:objectbox/objectbox.dart';

/// Use it globaly
/// save, remove & load from database from [ICollection]
/// modify [ICollection] based on your need.
abstract class ICollection<T> {
  QueryBuilder<T> query([Condition<T>? qc]);

  /// Get latest of the property,
  /// ex. latest name in the records of the given box
  ///   property: ItemDto_.name
  Future<T?> loadLatest(QueryProperty<T, dynamic> property);
  Future<T?> loadOne({required QueryBuilder<T> queryBuilder});
  Future<List<T>> loadMany({required QueryBuilder<T> queryBuilder});
  Future<List<T>> loadAll({required QueryBuilder<T> queryBuilder});

  Future<bool> remove({required QueryBuilder<T> queryBuilder});
  Future<int> removeMany({required QueryBuilder<T> queryBuilder});
  Future<int> removeAll({required QueryBuilder<T> queryBuilder});

  Future<int> saveOne(T data);
  Future<List<int>> saveMany(List<T> data);
}

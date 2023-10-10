import 'package:objectbox/objectbox.dart';

import '../collection.dart';

class Objectbox<T> implements ICollection<T> {
  late final Box<T> _box;

  Objectbox({required Store store}) {
    _box = Box<T>(store);

    /// use it when you need the store
    /// late final Store _store; // define class access
    /// _store = s;
  }

  @override
  QueryBuilder<T> query([Condition<T>? qc]) => _box.query(qc);
  // 'DatabaseBox.query'
  // ('QueryBuilder<T> Function([Condition<T>?])') isn't a valid override of 'IDatabase.query'
  // ('QueryBuilder<T> Function([Condition<T>?])').

  @override
  Future<List<T>> loadAll({required QueryBuilder<T> queryBuilder}) =>
      _box.getAllAsync();

  @override
  Future<T?> loadLatest(QueryProperty<T, dynamic> property) async {
    final query =
        (_box.query()..order(property, flags: Order.descending)).build();
    final result = await query.findAsync();
    query.close();
    return result.isNotEmpty ? result.first : null;
  }

  @override
  Future<List<T>> loadMany({required QueryBuilder<T> queryBuilder}) {
    // TODO: implement loadMany
    throw UnimplementedError();
  }

  @override
  Future<T?> loadOne({required QueryBuilder<T> queryBuilder}) {
    // TODO: implement loadOne
    throw UnimplementedError();
  }

  @override
  Future<bool> remove({required QueryBuilder<T> queryBuilder}) async {
    final query = queryBuilder.build();
    query.close();
    return query.remove() > 0;
  }

  @override
  Future<int> removeMany({required QueryBuilder<T> queryBuilder}) async {
    final query = queryBuilder.build();
    query.close();
    return query.remove();
  }

  @override
  Future<int> removeAll({required QueryBuilder<T> queryBuilder}) async {
    return _box.removeAll();
  }

  @override
  Future<List<int>> saveMany(List<T> data) {
    // TODO: implement saveMany
    throw UnimplementedError();
  }

  @override
  Future<int> saveOne(T data) {
    // TODO: implement saveOne
    throw UnimplementedError();
  }

  /// run the query to retrive list data.
  /// example of
  /// queryBuilder: box.query(T_.id.equals(11).and(T_.name.equals("name")))
  /// condition: T_.id.equals(11))
  /// orderBy: T_.id
  List<T> queryMany(
    QueryBuilder<T> queryBuilder, {
    dynamic orderBy,
    bool descending = false,
  }) {
    if (orderBy != null) queryBuilder.order(orderBy, flags: descending ? 1 : 0);
    final query = queryBuilder.build();
    final result = query.find();
    query.close();
    return result;
  }

  /// run the query to retrive an object.
  /// example of
  /// queryBuilder: box.query(T_.id.equals(11).and(T_.name.equals("name")))
  /// condition: T_.id.equals(11))
  T? queryOne(QueryBuilder<T> queryBuilder) {
    final query = queryBuilder.build();
    final result = query.find();
    query.close();
    return result.isNotEmpty ? result.first : null;
  }

  T? get(int id) => _box.get(id);
  T? getLatest(QueryProperty<T, dynamic> property) {
    final query =
        (_box.query()..order(property, flags: Order.descending)).build();
    final result = query.find();
    query.close();
    return result.isNotEmpty ? result.first : null;
  }

  bool isEmpty() => _box.isEmpty();
  int count({int limit = 0}) => _box.count(limit: limit);
  bool contains(int id) => _box.contains(id);
  bool containsMany(List<int> ids) => _box.containsMany(ids);

  List<T?> getMany(List<int> ids, {bool growableResult = false}) =>
      _box.getMany(ids, growableResult: growableResult);

  int put(T object, {PutMode mode = PutMode.put}) =>
      _box.put(object, mode: mode);
  Future<int> putAsync(T object, {PutMode mode = PutMode.put}) =>
      _box.putAsync(object, mode: mode);
  List<int> putMany(List<T> objects, {PutMode mode = PutMode.put}) =>
      _box.putMany(objects, mode: mode);
  int putQueued(T object, {PutMode mode = PutMode.put}) =>
      _box.putQueued(object, mode: mode);

  Future<List<T>> getAllAsync() => _box.getAllAsync();
  Future<T?> getAsync(int id) => _box.getAsync(id);
  Future<List<T?>> getManyAsync(List<int> ids, {bool growableResult = false}) =>
      _box.getManyAsync(ids, growableResult: growableResult);

  Future<T> putAndGetAsync(T object, {PutMode mode = PutMode.put}) =>
      _box.putAndGetAsync(object, mode: mode);
  Future<List<T>> putAndGetManyAsync(List<T> objects,
          {PutMode mode = PutMode.put}) =>
      _box.putAndGetManyAsync(objects, mode: mode);
  Future<List<int>> putManyAsync(List<T> objects,
          {PutMode mode = PutMode.put}) =>
      _box.putManyAsync(objects, mode: mode);
  Future<int> putQueuedAwaitResult(T object, {PutMode mode = PutMode.put}) =>
      _box.putAsync(object, mode: mode);

  Future<int> removeAllAsync() => _box.removeAllAsync();
  Future<bool> removeAsync(int id) => _box.removeAsync(id);
  Future<int> removeManyAsync(List<int> ids) => _box.removeManyAsync(ids);
}

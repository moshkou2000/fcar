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
  bool isEmpty() => _box.isEmpty();

  @override
  int count({int limit = 0}) => _box.count(limit: limit);

  @override
  bool contains(int id) => _box.contains(id);

  @override
  bool containsMany(List<int> ids) => _box.containsMany(ids);

  /// loadLatest(QueryProperty<T, dynamic>)
  @override
  Future<T?> loadLatest(dynamic property) async {
    final p = property is QueryProperty<T, dynamic> ? property : null;
    final queryBuilder = _box.query();
    if (p != null) queryBuilder.order(p, flags: Order.descending);
    final query = queryBuilder.build();
    final result = await query.findAsync();
    query.close();
    return result.isNotEmpty ? result.first : null;
  }

  /// run the query to retrive list<T>.
  /// example of
  /// loadMany(qc: Condition<T>)
  /// condition: T_.id.equals(11).and(T_.name.equals("name"))
  /// condition: T_.id.equals(11))
  /// orderBy: T_.id
  @override
  Future<List<T>> loadMany({
    required dynamic condition,
    dynamic orderBy,
    bool descending = false,
    int? limit,
    int? offset,
  }) async {
    final c = condition is Condition<T> ? condition : null;
    final queryBuilder = _box.query(c);
    if (orderBy != null) queryBuilder.order(orderBy, flags: descending ? 1 : 0);
    final query = queryBuilder.build();
    if (limit != null) query.limit = limit;
    if (offset != null) query.offset = offset;
    final result = await query.findAsync();
    query.close();
    return result;
  }

  /// run the query to retrive T.
  /// example of
  /// loadOne(qc: Condition<T>)
  /// condition: T_.id.equals(11).and(T_.name.equals("name"))
  /// condition: T_.id.equals(11))
  @override
  Future<T?> loadOne({required dynamic condition}) async {
    final c = condition is Condition<T> ? condition : null;
    final queryBuilder = _box.query(c);
    final query = queryBuilder.build();
    final result = await query.findAsync();
    query.close();
    return result.isNotEmpty ? result.first : null;
  }

  @override
  Future<List<T>> loadManyByIds(
    List<int> ids, {
    bool growableResult = false,
  }) async {
    final result = await _box.getManyAsync(ids, growableResult: growableResult);
    return result.where((e) => e != null).cast<T>().toList();
  }

  @override
  Future<T?> loadOneById(int id) async {
    return await _box.getAsync(id);
  }

  @override
  Future<List<T>> loadAll() async => await _box.getAllAsync();

  @override
  Future<bool> remove({required dynamic condition}) {
    final c = condition is Condition<T> ? condition : null;
    final queryBuilder = _box.query(c);
    final query = queryBuilder.build();
    final result = query.remove() > 0;
    query.close();
    return Future.value(result);
  }

  @override
  Future<int> removeMany({required dynamic condition}) async {
    final c = condition is Condition<T> ? condition : null;
    final queryBuilder = _box.query(c);
    final query = queryBuilder.build();
    final result = query.remove();
    query.close();
    return Future.value(result);
  }

  @override
  Future<bool> removeById(int id) async {
    return await _box.removeAsync(id);
  }

  @override
  Future<int> removeManyByIds(List<int> ids) async {
    return await _box.removeManyAsync(ids);
  }

  @override
  Future<int> removeAll() async {
    return _box.removeAllAsync();
  }

  @override
  Future<List<T>> saveMany(List<T> data) async {
    return await _box.putAndGetManyAsync(data, mode: PutMode.put);
  }

  @override
  Future<T> saveOne(T data) async {
    return await _box.putAndGetAsync(data, mode: PutMode.put);
  }

  @override
  Future<List<int>> updateMany(List<T> data) async {
    return await _box.putManyAsync(data, mode: PutMode.update);
  }

  @override
  Future<bool> updateOne(T data) async {
    return await _box.putAsync(data, mode: PutMode.update) > 0;
  }
}

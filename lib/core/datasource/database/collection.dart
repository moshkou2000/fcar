/// Use it globaly
/// save, remove & load from database from [ICollection]
/// modify [ICollection] based on your need.
abstract class ICollection<T> {
  bool isEmpty();
  int count({int limit = 0});
  bool contains(int id);
  bool containsMany(List<int> ids);

  /// Returns a an Object of type T
  /// Get latest of the property,
  /// ex. latest name in the records of the given box
  ///   property: ItemDto_.name
  Future<T?> loadLatest(dynamic property);

  /// Returns a an Object of type T
  Future<T?> loadOne({required dynamic condition});

  /// Returns a an Object of type T
  Future<T?> loadOneById(int id);

  /// Returns a list of Objects of type T
  Future<List<T>> loadMany({
    required dynamic condition,
    dynamic orderBy,
    bool descending = false,
    int? limit,
    int? offset,
  });

  /// Returns a list of Objects of type T
  /// each located at the corresponding position of its ID in [ids].
  Future<List<T>> loadManyByIds(
    List<int> ids, {
    bool growableResult = false,
  });

  /// Returns a list of Objects of type T
  Future<List<T>> loadAll();

  /// Removes (deletes) objects with the given [id] if they exist.
  /// Returns true if the object did exist and was removed, otherwise false.
  Future<bool> removeById(int id);

  /// Removes (deletes) objects with the given [queryBuilder] if they exist.
  /// Returns true if the object did exist and was removed, otherwise false.
  Future<bool> remove({required dynamic condition});

  /// Removes (deletes) objects with the given [ids] if they exist.
  /// Returns the number of removed objects.
  Future<int> removeManyByIds(List<int> ids);

  /// Removes (deletes) objects with the given [queryBuilder] if they exist.
  /// Returns the number of removed objects.
  Future<int> removeMany({required dynamic condition});

  /// Removes (deletes) all objects.
  /// Returns the number of removed objects.
  Future<int> removeAll();

  /// Save the given [data] and returns its (new) ID.
  Future<T> saveOne(T data);

  /// Save the given [data] and returns their (new) IDs.
  Future<List<T>> saveMany(List<T> data);

  /// Update the given [data].
  Future<bool> updateOne(T data);

  /// Update the given [data] and returns their IDs.
  Future<List<int>> updateMany(List<T> data);
}

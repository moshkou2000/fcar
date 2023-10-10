import 'package:objectbox/objectbox.dart';

abstract class IDatabaseRepository {
  void clear<T>({required QueryBuilder<T> query});
  void remove<T>({required QueryBuilder<T> query});
  T? load<T>({required QueryBuilder<T> query});
  List<int>? save<T>(List<T> data);
  int? update<T>({required QueryBuilder<T> query, required T data});
}

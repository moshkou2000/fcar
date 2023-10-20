import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';

import '../../../database/collection.dart';
import '../../../database/database.enum.dart';
import '../../../database.provider.dart';
import 'dio_cache.model.dart.dart';

/// The database must exist
/// Use it in the Dio Interceptor
///
/// databaseType: DatabaseType.objectbox
/// databaseName: DatabaseName.networkCache
class DioCache extends CacheStore {
  late final ICollection<CacheResponseModel> _cache;

  DioCache() {
    _cache = DatabaseProvider.getCollection<CacheResponseModel>(
        databaseType: DatabaseType.objectbox,
        databaseName: DatabaseName.networkCache)!;
    clean(staleOnly: true);
  }

  @override
  Future<void> clean({
    CachePriority priorityOrBelow = CachePriority.high,
    bool staleOnly = false,
  }) async {
    // await _cache.removeMany(condition: CacheResponseModel_.priority.lessOrEqual(priorityOrBelow.index));
  }

  @override
  Future<void> close() async {
    DatabaseProvider.closeDatabase(
        databaseType: DatabaseType.objectbox,
        databaseName: DatabaseName.networkCache);
  }

  @override
  Future<void> delete(String key, {bool staleOnly = false}) async {
    // await _cache.removeMany(condition: CacheResponseModel_.key.equals(key));
  }

  @override
  Future<void> deleteFromPath(
    RegExp pathPattern, {
    Map<String, String?>? queryParams,
  }) async {
    _getFromPath(
      pathPattern,
      queryParams: queryParams,
      onResponseMatch: (r) => _cache.removeById(r.id),
    );
  }

  @override
  Future<bool> exists(String key) async {
    return false;
    // return await _cache.loadOne(condition: CacheResponseModel_.key.equals(key)) != null;
  }

  @override
  Future<CacheResponse?> get(String key) async {
    //CacheResponseModel
    return null;
    // return await _cache.loadOne(condition: CacheResponseModel_.key.equals(key));
  }

  //CacheResponseModel
  @override
  Future<List<CacheResponse>> getFromPath(
    RegExp pathPattern, {
    Map<String, String?>? queryParams,
  }) async {
    final responses = <CacheResponse>[];

    await _getFromPath(
      pathPattern,
      queryParams: queryParams,
      onResponseMatch: (r) => responses.add(r.toObject()),
    );

    return responses;
  }

  @override
  Future<void> set(CacheResponse response) async {
    await delete(response.key);
    _cache.saveOne(CacheResponseModel.fromObject(response));
  }

  Future<void> _getFromPath(
    RegExp pathPattern, {
    Map<String, String?>? queryParams,
    required void Function(CacheResponseModel) onResponseMatch,
  }) async {
    var results = <CacheResponseModel>[];
    const limit = 10;
    var offset = 0;

    do {
      results =
          await _cache.loadMany(condition: null, limit: limit, offset: offset);

      for (final result in results) {
        if (pathExists(result.url, pathPattern, queryParams: queryParams)) {
          onResponseMatch.call(result);
        }
      }

      offset += limit;
    } while (results.isNotEmpty);
  }
}

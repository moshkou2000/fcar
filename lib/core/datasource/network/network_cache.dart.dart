import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';

import '../../../shared/domain/model/item.model.dart';
import '../database/database.provider.dart';

class NetworkCache extends CacheStore {
  final DatabaseService d = DatabaseService<ItemModel>();

  /// ObjectBox store file path
  final String storePath;

  /// ObjectBox store
  Store? _store;

  /// ObjectBox box instance for [CacheResponseBox]
  Box<CacheResponseBox>? _box;

  NetworkCache({required this.storePath}) {
    clean(staleOnly: true);
  }

  Box<CacheResponseBox> _openBox() {
    if (_box == null) {
      _store = Store(getObjectBoxModel(), directory: '$storePath/cache-api');
      _box = _store!.box<CacheResponseBox>();
    }
    return _box!;
  }

  @override
  Future<void> clean({
    CachePriority priorityOrBelow = CachePriority.high,
    bool staleOnly = false,
  }) async {
    final box = _openBox();

    final query = box
        .query(CacheResponseBox_.priority.lessOrEqual(priorityOrBelow.index))
        .build();
    final results = query.find();
    query.close();

    for (final result in results) {
      if ((staleOnly && result.toObject().isStaled()) || !staleOnly) {
        box.remove(result.id!);
      }
    }
  }

  @override
  Future<void> close() async {
    return _store?.close();
  }

  @override
  Future<void> delete(String key, {bool staleOnly = false}) async {
    final box = _openBox();
    final query = box.query(CacheResponseBox_.key.equals(key)).build();
    final resp = query.findFirst();
    query.close();

    if (resp == null) return Future.value();

    if (staleOnly && !resp.toObject().isStaled()) {
      return Future.value();
    }

    box.remove(resp.id!);
  }

  @override
  Future<void> deleteFromPath(
    RegExp pathPattern, {
    Map<String, String?>? queryParams,
  }) async {
    final box = _openBox();

    _getFromPath(
      pathPattern,
      queryParams: queryParams,
      onResponseMatch: (r) => box.remove(r.id!),
    );
  }

  @override
  Future<bool> exists(String key) async {
    final box = _openBox();

    final query = box.query(CacheResponseBox_.key.equals(key)).build();
    final result = query.findFirst() != null;
    query.close();

    return result;
  }

  @override
  Future<CacheResponse?> get(String key) async {
    final box = _openBox();

    final query = box.query(CacheResponseBox_.key.equals(key)).build();
    final resp = query.findFirst();
    query.close();

    return resp?.toObject();
  }

  @override
  Future<List<CacheResponse>> getFromPath(
    RegExp pathPattern, {
    Map<String, String?>? queryParams,
  }) async {
    final responses = <CacheResponse>[];

    _getFromPath(
      pathPattern,
      queryParams: queryParams,
      onResponseMatch: (r) => responses.add(r.toObject()),
    );

    return responses;
  }

  @override
  Future<void> set(CacheResponse response) async {
    final box = _openBox();
    await delete(response.key);
    box.put(CacheResponseBox.fromObject(response));
  }

  void _getFromPath(
    RegExp pathPattern, {
    Map<String, String?>? queryParams,
    required void Function(CacheResponseBox) onResponseMatch,
  }) {
    var results = <CacheResponseBox>[];
    const limit = 10;
    var offset = 0;

    final box = _openBox();

    do {
      final query = box.query().build()
        ..limit = limit
        ..offset = offset;

      results = query.find();
      query.close();

      for (final result in results) {
        if (pathExists(result.url, pathPattern, queryParams: queryParams)) {
          onResponseMatch.call(result);
        }
      }

      offset += limit;
    } while (results.isNotEmpty);
  }
}

@Entity()
class CacheResponseBox {
  CacheResponseBox({
    required this.key,
    this.content,
    this.date,
    this.eTag,
    this.expires,
    this.headers,
    this.lastModified,
    this.maxStale,
    this.requestDate,
    required this.priority,
    required this.responseDate,
    required this.url,
  });

  @Id()
  int? id;
  String key;

  @Property(type: PropertyType.byteVector)
  List<int>? content;

  @Property(type: PropertyType.date)
  DateTime? date;

  String? eTag;

  @Property(type: PropertyType.date)
  DateTime? expires;

  @Property(type: PropertyType.byteVector)
  List<int>? headers;

  String? lastModified;

  @Property(type: PropertyType.date)
  DateTime? maxStale;

  @Property(type: PropertyType.date)
  DateTime responseDate;

  @Property(type: PropertyType.date)
  DateTime? requestDate;

  String url;

  int priority;

  final cacheControl = ToOne<CacheControlBox>();

  CachePriority get cachePriority {
    switch (priority) {
      case 0:
        return CachePriority.low;
      case 1:
        return CachePriority.normal;
      case 2:
        return CachePriority.high;
      default:
        return CachePriority.low;
    }
  }

  CacheResponse toObject() {
    return CacheResponse(
      cacheControl: cacheControl.target?.toObject() ?? CacheControl(),
      content: content,
      date: date,
      eTag: eTag,
      expires: expires,
      headers: headers,
      key: key,
      lastModified: lastModified,
      maxStale: maxStale,
      priority: cachePriority,
      responseDate: responseDate,
      url: url,
      requestDate: requestDate ??
          responseDate.subtract(
            const Duration(milliseconds: 150),
          ),
    );
  }

  static CacheResponseBox fromObject(CacheResponse response) {
    final result = CacheResponseBox(
      key: response.key,
      content: response.content,
      date: response.date,
      eTag: response.eTag,
      expires: response.expires,
      headers: response.headers,
      lastModified: response.lastModified,
      maxStale: response.maxStale,
      responseDate: response.responseDate,
      url: response.url,
      requestDate: response.requestDate,
      priority: response.priority.index,
    );

    result.cacheControl.target = CacheControlBox(
      maxAge: response.cacheControl.maxAge,
      privacy: response.cacheControl.privacy,
      noCache: response.cacheControl.noCache,
      noStore: response.cacheControl.noStore,
      other: response.cacheControl.other,
    );

    return result;
  }
}

@Entity()
class CacheControlBox {
  CacheControlBox({
    this.id,
    this.maxAge,
    this.privacy,
    this.noCache,
    this.noStore,
    this.other,
  });

  @Id()
  int? id;
  int? maxAge;
  String? privacy;
  bool? noCache;
  bool? noStore;
  List<String>? other;
  int? maxStale;
  int? minFresh;
  bool? mustRevalidate;

  CacheControl toObject() {
    return CacheControl(
      maxAge: maxAge ?? -1,
      privacy: privacy,
      noCache: noCache ?? false,
      noStore: noStore ?? false,
      other: other ?? [],
      maxStale: maxStale ?? -1,
      minFresh: minFresh ?? -1,
      mustRevalidate: mustRevalidate ?? false,
    );
  }
}

import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class CacheResponseModel {
  @Id()
  late int id = 0;
  String key = '';
  String url = '';
  String? eTag;
  String? lastModified;
  int _priority = 0;

  @Property(type: PropertyType.byteVector)
  List<int>? headers;

  @Property(type: PropertyType.byteVector)
  List<int>? data; // content

  @Property(type: PropertyType.date)
  DateTime? date;

  @Property(type: PropertyType.date)
  DateTime? expires;

  @Property(type: PropertyType.date)
  DateTime? maxStale;

  @Property(type: PropertyType.date)
  DateTime? _responseDate;

  @Property(type: PropertyType.date)
  DateTime? _requestDate;

  final ToOne<CacheControlModel> _cacheControl = ToOne<CacheControlModel>();

  CachePriority get priority => CachePriority.values[_priority];
  List<int>? get content => data;
  DateTime get responseDate => _responseDate ?? DateTime.now();
  DateTime get requestDate =>
      _requestDate ??
      DateTime.now().subtract(const Duration(milliseconds: 150));
  CacheControl get cacheControl =>
      _cacheControl.target?.toObject() ?? CacheControl();

  Headers get responseHeaders {
    final checkedHeaders = headers;
    final h = Headers();

    if (checkedHeaders != null) {
      final map = jsonDecode(utf8.decode(checkedHeaders));
      map.forEach((key, value) => h.set(key, value));
    }

    return h;
  }

  set priority(CachePriority value) => _priority = value.index;
  set content(List<int>? value) => data = value;
  set responseDate(DateTime value) => _responseDate = value;
  set requestDate(DateTime value) => _requestDate = value;
  set cacheControl(CacheControl value) =>
      _cacheControl.target = CacheControlModel.fromObject(value);

  static CacheResponseModel fromObject(CacheResponse cacheResponse) {
    var c = CacheResponseModel();
    c.cacheControl = cacheResponse.cacheControl;
    c.content = cacheResponse.content;
    c.date = cacheResponse.date;
    c.eTag = cacheResponse.eTag;
    c.expires = cacheResponse.expires;
    c.headers = cacheResponse.headers;
    c.key = cacheResponse.key;
    c.lastModified = cacheResponse.lastModified;
    c.maxStale = cacheResponse.maxStale;
    c.priority = cacheResponse.priority;
    c.responseDate = cacheResponse.responseDate;
    c.url = cacheResponse.url;
    c.requestDate = cacheResponse.requestDate;
    return c;
  }

  CacheResponse toObject() => CacheResponse(
      cacheControl: cacheControl,
      content: content,
      date: date,
      eTag: eTag,
      expires: expires,
      headers: headers,
      key: key,
      lastModified: lastModified,
      maxStale: maxStale,
      priority: priority,
      responseDate: responseDate,
      url: url,
      requestDate: requestDate);

  Response toResponse(RequestOptions options, {bool fromNetwork = false}) {
    return Response(
      data: _deserializeContent(options.responseType, content),
      extra: {
        CacheResponse.cacheKey: key,
        CacheResponse.fromNetwork: fromNetwork
      },
      headers: responseHeaders,
      statusCode: HttpStatus.notModified,
      requestOptions: options,
    );
  }

  dynamic _deserializeContent(ResponseType type, List<int>? content) {
    switch (type) {
      case ResponseType.bytes:
        return content;
      case ResponseType.plain:
        return (content != null) ? utf8.decode(content) : null;
      case ResponseType.json:
        return (content != null) ? jsonDecode(utf8.decode(content)) : null;
      default:
        throw UnsupportedError('Response type not supported : $type.');
    }
  }
}

@Entity()
class CacheControlModel {
  @Id()
  late int id = 0;
  int? maxAge;
  String? privacy;
  bool? noCache;
  bool? noStore;
  List<String>? other;
  int? maxStale;
  int? minFresh;
  bool? mustRevalidate;

  static CacheControlModel fromObject(CacheControl cacheControl) {
    var c = CacheControlModel();
    c.maxAge = cacheControl.maxAge;
    c.privacy = cacheControl.privacy;
    c.noCache = cacheControl.noCache;
    c.noStore = cacheControl.noStore;
    c.other = cacheControl.other;
    c.maxStale = cacheControl.maxStale;
    c.minFresh = cacheControl.minFresh;
    c.maxStale = cacheControl.maxStale;
    c.mustRevalidate = cacheControl.mustRevalidate;
    return c;
  }

  CacheControl toObject() {
    return CacheControl(
      maxAge: maxAge ?? -1,
      privacy: privacy,
      noCache: noCache ?? false,
      noStore: noStore ?? false,
      other: other ?? const [],
      maxStale: maxStale ?? -1,
      minFresh: minFresh ?? -1,
      mustRevalidate: mustRevalidate ?? false,
    );
  }
}

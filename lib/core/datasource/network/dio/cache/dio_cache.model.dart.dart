import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class CacheResponseModel extends CacheResponse {
  @Id()
  late int id = 0;
  String cachekey = '';
  String cacheUrl = '';
  String? cacheETag;
  String? cacheLastModified;
  int cachePriority = 0;

  @Property(type: PropertyType.byteVector)
  List<int>? cacheHeaders;

  @Property(type: PropertyType.byteVector)
  List<int>? data; // content

  @Property(type: PropertyType.date)
  DateTime? cacheDate;

  @Property(type: PropertyType.date)
  DateTime? cacheExpires;

  @Property(type: PropertyType.date)
  DateTime? cacheMaxStale;

  @Property(type: PropertyType.date)
  DateTime? cacheResponseDate;

  @Property(type: PropertyType.date)
  DateTime? cacheRequestDate;

  final ToOne<CacheControlModel> _cacheControl = ToOne<CacheControlModel>();

  @override
  String get key => cachekey;

  @override
  String get url => cacheUrl;

  @override
  String? get eTag => cacheETag;

  @override
  String? get lastModified => cacheLastModified;

  @override
  CachePriority get priority => CachePriority.values[cachePriority];

  @override
  List<int>? get headers => cacheHeaders;

  @override
  List<int>? get content => data;

  @override
  DateTime? get date => cacheDate;

  @override
  DateTime? get expires => cacheExpires;

  @override
  DateTime? get maxStale => cacheMaxStale;

  @override
  DateTime get responseDate => cacheResponseDate ?? DateTime.now();

  @override
  DateTime get requestDate =>
      cacheRequestDate ??
      DateTime.now().subtract(const Duration(milliseconds: 150));

  @override
  CacheControl get cacheControl =>
      _cacheControl.target?.toObject() ?? CacheControl();

  set key(String value) => cachekey = value;

  set url(String value) => cacheUrl = value;

  set eTag(String? value) => cacheETag = value;

  set lastModified(String? value) => cacheLastModified = value;

  set priority(CachePriority value) => cachePriority = value.index;

  @override
  set headers(List<int>? value) => cacheHeaders = value;

  @override
  set content(List<int>? value) => data = value;

  set date(DateTime? value) => cacheDate = value;

  set expires(DateTime? value) => cacheExpires = value;

  set maxStale(DateTime? value) => cacheMaxStale = value;

  set responseDate(DateTime value) => cacheResponseDate = value;

  set requestDate(DateTime value) => cacheRequestDate = value;

  set cacheControl(CacheControl value) =>
      _cacheControl.target = CacheControlModel.fromObject(value);

  CacheResponseModel({
    required super.cacheControl,
    required super.content,
    required super.date,
    required super.eTag,
    required super.expires,
    required super.headers,
    required super.key,
    required super.lastModified,
    required super.maxStale,
    required super.priority,
    required super.requestDate,
    required super.responseDate,
    required super.url,
  });

  static CacheResponseModel fromObject(CacheResponse cacheResponse) {
    var c = CacheResponseModel(
      cacheControl: cacheResponse.cacheControl,
      content: cacheResponse.content,
      date: cacheResponse.date,
      eTag: cacheResponse.eTag,
      expires: cacheResponse.expires,
      headers: cacheResponse.headers,
      key: cacheResponse.key,
      lastModified: cacheResponse.lastModified,
      maxStale: cacheResponse.maxStale,
      priority: cacheResponse.priority,
      responseDate: cacheResponse.responseDate,
      url: cacheResponse.url,
      requestDate: cacheResponse.requestDate,
    );
    // c.cacheControl = cacheResponse.cacheControl;
    // c.content = cacheResponse.content;
    // c.date = cacheResponse.date;
    // c.eTag = cacheResponse.eTag;
    // c.expires = cacheResponse.expires;
    // c.headers = cacheResponse.headers;
    // c.key = cacheResponse.key;
    // c.lastModified = cacheResponse.lastModified;
    // c.maxStale = cacheResponse.maxStale;
    // c.priority = cacheResponse.priority;
    // c.responseDate = cacheResponse.responseDate;
    // c.url = cacheResponse.url;
    // c.requestDate = cacheResponse.requestDate;
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

  @override
  Response toResponse(RequestOptions options, {bool fromNetwork = false}) {
    return Response(
      data: _deserializeContent(options.responseType, content),
      extra: {
        CacheResponse.cacheKey: key,
        CacheResponse.fromNetwork: fromNetwork
      },
      headers: getHeaders(),
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
class CacheControlModel extends CacheControl {
  @Id()
  late int id = 0;
  int? cacheMaxAge;
  String? cachePrivacy;
  bool? cacheNoCache;
  bool? cacheNoStore;
  List<String>? cacheOther;
  int? cacheMaxStale;
  int? cacheMinFresh;
  bool? cacheMustRevalidate;

  @override
  int get maxAge => cacheMaxAge ?? 0;

  @override
  String? get privacy => cachePrivacy;

  @override
  bool get noCache => cacheNoCache ?? true;

  @override
  bool get noStore => cacheNoStore ?? true;

  @override
  List<String> get other => cacheOther ?? [];

  @override
  int get maxStale => cacheMaxStale ?? 0;

  @override
  int get minFresh => cacheMinFresh ?? 0;

  @override
  bool get mustRevalidate => cacheMustRevalidate ?? false;

  set maxAge(int? value) => cacheMaxAge = value;

  set privacy(String? value) => cachePrivacy = value;

  set noCache(bool? value) => cacheNoCache = value;

  set noStore(bool? value) => cacheNoStore = value;

  set other(List<String>? value) => cacheOther = value;

  set maxStale(int? value) => cacheMaxStale = value;

  set minFresh(int? value) => cacheMinFresh = value;

  set mustRevalidate(bool? value) => cacheMustRevalidate = value;

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
      maxAge: maxAge,
      privacy: privacy,
      noCache: noCache,
      noStore: noStore,
      other: other,
      maxStale: maxStale,
      minFresh: minFresh,
      mustRevalidate: mustRevalidate,
    );
  }
}

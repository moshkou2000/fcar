/// Annotation
///
/// Examples:
///
/// @ui
/// bool isExpanded = false;
///
/// this explains that [isExpanded] is a parameter to manage UI at runtime
/// no need repository
///
/// @usecase
/// static final String carLib = Usecase.getCarLib ? ConstantUrl.carLibV2 : ConstantUrl.carLibV1;
///
/// @usecase
/// Future<ABCDto?> getABC(Map<String, String> queryParam) async {
///   final String url = Usecase.getABC ? ConstantUrl.abc2 : ConstantUrl.abc1;
///   final dynamic json = await get(
///     url,
///     queryParam: queryParam,
///     cancelToken: NetworkCancelToken.getABC,
///   );
///   return NetworkResponse<ABCDto>(json, fromMap: ABCDto.fromJson).item;
/// }
///
///
/// this explains that [carLib] variable and [getABC] method are usecase [business logic]
///
const String api = 'api';
const String db = 'db';
const String ui = 'ui';
const String usecase = 'usecase';
const String onGoing = 'onGoing';
const String template = 'template';

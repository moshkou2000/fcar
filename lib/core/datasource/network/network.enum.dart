enum NetworkContentType {
  applicationJson('application/json'),
  applicationOctetStream('application/octet-stream'),
  multiPartFormData('multipart/form-data');

  final String name;

  const NetworkContentType(this.name);

  static NetworkContentType fromString(String name) {
    return values.firstWhere(
      (v) => v.name.toLowerCase() == name.toLowerCase(),
      orElse: () => NetworkContentType.applicationJson,
    );
  }
}

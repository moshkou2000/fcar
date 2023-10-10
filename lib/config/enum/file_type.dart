enum FileType {
  photo,
  video;

  static FileType fromString(String name) {
    return values.firstWhere(
      (FileType v) => v.name.toLowerCase() == name.toLowerCase(),
      orElse: () => FileType.photo,
    );
  }
}

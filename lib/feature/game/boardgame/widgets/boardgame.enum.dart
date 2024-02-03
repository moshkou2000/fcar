enum BoardgameType {
  text,
  photo,
  audio,
  video;

  static BoardgameType fromString(String name) {
    return values.firstWhere(
      (BoardgameType v) => v.name.toLowerCase() == name.toLowerCase(),
      orElse: () => BoardgameType.text,
    );
  }
}

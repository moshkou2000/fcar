enum LandingItemType {
  about,
  home,
  record,
  setting;

  static LandingItemType fromString(String name) {
    return values.firstWhere(
      (LandingItemType v) => v.name.toLowerCase() == name.toLowerCase(),
      orElse: () => LandingItemType.home,
    );
  }
}

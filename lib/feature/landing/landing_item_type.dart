enum LandingItemType {
  home,
  about,
  record,
  setting;

  static LandingItemType fromString(String name) {
    return values.firstWhere(
      (LandingItemType v) => v.name.toLowerCase() == name.toLowerCase(),
      orElse: () => LandingItemType.home,
    );
  }
}

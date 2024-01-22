enum LandingItemType {
  action,
  home,
  league,
  record,
  shop;

  static LandingItemType fromString(String name) {
    return values.firstWhere(
      (LandingItemType v) => v.name.toLowerCase() == name.toLowerCase(),
      orElse: () => LandingItemType.home,
    );
  }
}

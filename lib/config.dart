class AppConfig {
  //# CONFIG
  static String yourName = "RiskiWR";
  static String phoneNumber = "085647840743";
  //# ---------------------------------------
  //# ---------------------------------------

  static String get baseUrl {
    var storage = yourName.replaceAll(" ", "-").toLowerCase();
    storage = "$storage-$phoneNumber";
    return "http://capekngoding.com:8080/$storage/api";
  }
}

class AppLink {

  static const String server = "https://syriansociety.org/api";

// ================================= Auth ========================== //

  static const String login = "$server/login";
  static const String signup = "$server/register";
  static const String resendCode = "$server/resend-code";
  static const String verifyPhone = "$server/verify-phone";
  static const String logout = "$server/logout";
// ================================= Search ========================== //

  static const String searchHistory = "$server/history-search";
  static const String search = "$server/search";
}

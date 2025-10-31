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
  // Update user address
  static const String updateAddress = "$server/update_address";
  // Update profile (first_name, last_name)
  static const String updateProfile = "$server/updateProfile";
  // Main interface / home endpoint (used to fetch ads, nearby restaurants, discounts, etc.)
  // Assumption: endpoint path is `/home`. Change if your backend uses a different path.
  static const String home = "$server/home";
  //==============================restaurants ========================= //
  static const String Restaurants = "$server/all-restaurants";
}

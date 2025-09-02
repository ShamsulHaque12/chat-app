class ApiConfig {
  static String baseUrl ="http://172.252.13.71:5400/api/v1";
  static String register = ("$baseUrl/users/register");
  static String login = ("$baseUrl/auth/login");
  static String verify = ("$baseUrl/users/verify-otp");

  static String group = ("$baseUrl/groups");
}
class Endpoints {
  Endpoints._();

  static const String baseUrl = 'http://192.168.1.70:5000/api';
  static const String login = "/auth/login";
  static const String register = "/auth/register";
  static const String getEvents = "/job/getAllJobs";
  static const String applyEvent = "/job/applyForJob";
  static const String addEvent = "/job/addJob";
  static const String getRecommendation = "/company/getRecommendation";
}

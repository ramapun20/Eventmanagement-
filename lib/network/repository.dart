import 'package:dio/dio.dart';
import 'package:event_buddy/models/all_events_response.dart';
import 'package:event_buddy/models/recommendation_response.dart';
import 'package:event_buddy/models/user_response_model.dart';
import 'package:event_buddy/network/dio_client.dart';
import 'package:event_buddy/utils/constants/endpoints.dart';

class Repository {
  final DioClient _network;
  Repository(this._network);

  Future<UserResponse> login(String username, password) async {
    final resp = await _network.post(
      Endpoints.login,
      {"username": username, "password": password},
    );
    return UserResponse.fromJson(resp.data);
  }

  Future<UserResponse> register(Map<String, dynamic> data) async {
    final resp = await _network.post(Endpoints.register, data);
    return UserResponse.fromJson(resp.data);
  }

  Future<AllEventsResponse> getEvents() async {
    final resp = await _network.get(Endpoints.getEvents);
    return AllEventsResponse.fromJson(resp.data);
  }

  Future<RecommendationResponse> getRecommendation() async {
    final resp = await _network.get(Endpoints.getRecommendation);
    return RecommendationResponse.fromJson(resp.data);
  }

  Future<Response> applyEvent(Map<String, dynamic> data) async {
    final resp = await _network.post(Endpoints.applyEvent, data);
    return resp;
  }

  Future<Response> addEvent(Map<String, dynamic> data) async {
    final resp = await _network.post(Endpoints.addEvent, data);
    return resp;
  }
}

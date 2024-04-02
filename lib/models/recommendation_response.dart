import 'package:event_buddy/models/all_events_response.dart';

class RecommendationResponse {
  bool? success;
  List<Datum>? data;

  RecommendationResponse({
    this.success,
    this.data,
  });

  factory RecommendationResponse.fromJson(Map<String, dynamic> json) =>
      RecommendationResponse(
        success: json["success"],
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  EventModel? job;
  double? similarity;

  Datum({
    this.job,
    this.similarity,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        job: json["job"] == null ? null : EventModel.fromJson(json["job"]),
        similarity: json["similarity"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "job": job?.toJson(),
        "similarity": similarity,
      };
}

import 'dart:convert';

AllEventsResponse allEventsResponseFromJson(String str) =>
    AllEventsResponse.fromJson(json.decode(str));

String allEventsResponseToJson(AllEventsResponse data) =>
    json.encode(data.toJson());

class AllEventsResponse {
  bool? success;
  List<EventModel>? data;

  AllEventsResponse({
    this.success,
    this.data,
  });

  factory AllEventsResponse.fromJson(Map<String, dynamic> json) =>
      AllEventsResponse(
        success: json["success"],
        data: json["data"] == null
            ? []
            : List<EventModel>.from(
                json["data"]!.map((x) => EventModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class EventModel {
  String? id;
  String? title;
  String? about;
  List<String>? skills;
  int? sallary;
  String? description;
  List<String>? responsibilities;
  List<String>? requirements;
  Company? company;
  DateTime? closeDate;
  bool? isActive;
  DateTime? openDate;
  List<dynamic>? applicants;
  int? v;

  EventModel({
    this.id,
    this.title,
    this.about,
    this.skills,
    this.sallary,
    this.description,
    this.responsibilities,
    this.requirements,
    this.company,
    this.closeDate,
    this.isActive,
    this.openDate,
    this.applicants,
    this.v,
  });

  factory EventModel.fromJson(Map<String, dynamic> json) => EventModel(
        id: json["_id"],
        title: json["title"],
        about: json["about"],
        skills: json["skills"] == null
            ? []
            : List<String>.from(json["skills"]!.map((x) => x)),
        sallary: json["sallary"],
        description: json["description"],
        responsibilities: json["responsibilities"] == null
            ? []
            : List<String>.from(json["responsibilities"]!.map((x) => x)),
        requirements: json["requirements"] == null
            ? []
            : List<String>.from(json["requirements"]!.map((x) => x)),
        // company:
        //     json["company"] == null ? null : Company.fromJson(json["company"]),
        closeDate: json["closeDate"] == null
            ? null
            : DateTime.parse(json["closeDate"]),
        isActive: json["isActive"],
        openDate:
            json["openDate"] == null ? null : DateTime.parse(json["openDate"]),
        // applicants: json["applicants"] == null
        //     ? []
        //     : List<dynamic>.from(json["applicants"]!.map((x) => x)),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "about": about,
        "skills":
            skills == null ? [] : List<dynamic>.from(skills!.map((x) => x)),
        "sallary": sallary,
        "description": description,
        "responsibilities": responsibilities == null
            ? []
            : List<dynamic>.from(responsibilities!.map((x) => x)),
        "requirements": requirements == null
            ? []
            : List<dynamic>.from(requirements!.map((x) => x)),
        "company": company?.toJson(),
        "closeDate": closeDate?.toIso8601String(),
        "isActive": isActive,
        "openDate": openDate?.toIso8601String(),
        "applicants": applicants == null
            ? []
            : List<dynamic>.from(applicants!.map((x) => x)),
        "__v": v,
      };
}

class Company {
  String? id;
  String? name;
  bool? isAvatarImageSet;
  String? avatarImage;
  bool? isVerified;
  List<String>? jobs;
  int? v;

  Company({
    this.id,
    this.name,
    this.isAvatarImageSet,
    this.avatarImage,
    this.isVerified,
    this.jobs,
    this.v,
  });

  factory Company.fromJson(Map<String, dynamic> json) => Company(
        id: json["_id"],
        name: json["name"],
        isAvatarImageSet: json["isAvatarImageSet"],
        avatarImage: json["avatarImage"],
        isVerified: json["isVerified"],
        jobs: json["jobs"] == null
            ? []
            : List<String>.from(json["jobs"]!.map((x) => x)),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "isAvatarImageSet": isAvatarImageSet,
        "avatarImage": avatarImage,
        "isVerified": isVerified,
        "jobs": jobs == null ? [] : List<dynamic>.from(jobs!.map((x) => x)),
        "__v": v,
      };
}

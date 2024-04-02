// To parse this JSON data, do
//
//     final userResponse = userResponseFromJson(jsonString);

import 'dart:convert';

UserResponse userResponseFromJson(String str) =>
    UserResponse.fromJson(json.decode(str));

String userResponseToJson(UserResponse data) => json.encode(data.toJson());

class UserResponse {
  bool? status;
  User? user;
  Company? company;
  String? token;

  UserResponse({
    this.status,
    this.user,
    this.company,
    this.token,
  });

  factory UserResponse.fromJson(Map<String, dynamic> json) => UserResponse(
        status: json["status"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        company:
            json["company"] == null ? null : Company.fromJson(json["company"]),
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "user": user?.toJson(),
        "company": company?.toJson(),
        "token": token,
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

class User {
  Professional? professional;
  String? id;
  String? username;
  String? type;
  String? email;
  String? password;
  bool? isAvatarImageSet;
  String? avatarImage;
  bool? isVerified;
  List<Additional>? additional;
  List<AppliedJob>? appliedJobs;
  List<dynamic>? savedJobs;
  List<dynamic>? events;
  List<dynamic>? todos;
  int? v;
  String? company;

  User({
    this.professional,
    this.id,
    this.username,
    this.type,
    this.email,
    this.password,
    this.isAvatarImageSet,
    this.avatarImage,
    this.isVerified,
    this.additional,
    this.appliedJobs,
    this.savedJobs,
    this.events,
    this.todos,
    this.v,
    this.company,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        professional: json["professional"] == null
            ? null
            : Professional.fromJson(json["professional"]),
        id: json["_id"],
        username: json["username"],
        type: json["type"],
        email: json["email"],
        password: json["password"],
        isAvatarImageSet: json["isAvatarImageSet"],
        avatarImage: json["avatarImage"],
        isVerified: json["isVerified"],
        additional: json["additional"] == null
            ? []
            : List<Additional>.from(
                json["additional"]!.map((x) => Additional.fromJson(x))),
        appliedJobs: json["appliedJobs"] == null
            ? []
            : List<AppliedJob>.from(
                json["appliedJobs"]!.map((x) => AppliedJob.fromJson(x))),
        savedJobs: json["savedJobs"] == null
            ? []
            : List<dynamic>.from(json["savedJobs"]!.map((x) => x)),
        events: json["events"] == null
            ? []
            : List<dynamic>.from(json["events"]!.map((x) => x)),
        todos: json["todos"] == null
            ? []
            : List<dynamic>.from(json["todos"]!.map((x) => x)),
        v: json["__v"],
        company: json["company"],
      );

  Map<String, dynamic> toJson() => {
        "professional": professional?.toJson(),
        "_id": id,
        "username": username,
        "type": type,
        "email": email,
        "password": password,
        "isAvatarImageSet": isAvatarImageSet,
        "avatarImage": avatarImage,
        "isVerified": isVerified,
        "additional": additional == null
            ? []
            : List<dynamic>.from(additional!.map((x) => x.toJson())),
        "appliedJobs": appliedJobs == null
            ? []
            : List<dynamic>.from(appliedJobs!.map((x) => x.toJson())),
        "savedJobs": savedJobs == null
            ? []
            : List<dynamic>.from(savedJobs!.map((x) => x)),
        "events":
            events == null ? [] : List<dynamic>.from(events!.map((x) => x)),
        "todos": todos == null ? [] : List<dynamic>.from(todos!.map((x) => x)),
        "__v": v,
        "company": company,
      };
}

class Additional {
  dynamic education;
  dynamic experience;
  String? id;

  Additional({
    this.education,
    this.experience,
    this.id,
  });

  factory Additional.fromJson(Map<String, dynamic> json) => Additional(
        education: json["education"],
        experience: json["experience"],
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "education": education,
        "experience": experience,
        "_id": id,
      };
}

class AppliedJob {
  String? job;
  DateTime? appliedDate;
  String? status;
  String? id;

  AppliedJob({
    this.job,
    this.appliedDate,
    this.status,
    this.id,
  });

  factory AppliedJob.fromJson(Map<String, dynamic> json) => AppliedJob(
        job: json["job"],
        appliedDate: json["appliedDate"] == null
            ? null
            : DateTime.parse(json["appliedDate"]),
        status: json["status"],
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "job": job,
        "appliedDate": appliedDate?.toIso8601String(),
        "status": status,
        "_id": id,
      };
}

class Professional {
  List<dynamic>? skills;

  Professional({
    this.skills,
  });

  factory Professional.fromJson(Map<String, dynamic> json) => Professional(
        skills: json["skills"] == null
            ? []
            : List<dynamic>.from(json["skills"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "skills":
            skills == null ? [] : List<dynamic>.from(skills!.map((x) => x)),
      };
}

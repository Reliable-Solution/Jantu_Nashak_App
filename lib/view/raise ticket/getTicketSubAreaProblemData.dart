// To parse this JSON data, do
//
//     final getTicketSubAreaProblemModel = getTicketSubAreaProblemModelFromJson(jsonString);

import 'dart:convert';

GetTicketSubAreaProblemModel getTicketSubAreaProblemModelFromJson(String str) => GetTicketSubAreaProblemModel.fromJson(json.decode(str));

String getTicketSubAreaProblemModelToJson(GetTicketSubAreaProblemModel data) => json.encode(data.toJson());

class GetTicketSubAreaProblemModel {
  List<GetTicketSubAreaProblemData>? data;
  bool? isSuccess;
  String? message;

  GetTicketSubAreaProblemModel({
    this.data,
    this.isSuccess,
    this.message,
  });

  factory GetTicketSubAreaProblemModel.fromJson(Map<String, dynamic> json) => GetTicketSubAreaProblemModel(
    data: json["Data"] == null ? [] : List<GetTicketSubAreaProblemData>.from(json["Data"]!.map((x) => GetTicketSubAreaProblemData.fromJson(x))),
    isSuccess: json["IsSuccess"],
    message: json["Message"],
  );

  Map<String, dynamic> toJson() => {
    "Data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "IsSuccess": isSuccess,
    "Message": message,
  };
}

class GetTicketSubAreaProblemData {
  String? subproblemId;
  String? problemId;
  String? subproblemName;
  String? subproblemDelete;
  String? subproblemStatus;
  DateTime? subproblemCdt;

  GetTicketSubAreaProblemData({
    this.subproblemId,
    this.problemId,
    this.subproblemName,
    this.subproblemDelete,
    this.subproblemStatus,
    this.subproblemCdt,
  });

  factory GetTicketSubAreaProblemData.fromJson(Map<String, dynamic> json) => GetTicketSubAreaProblemData(
    subproblemId: json["SubproblemId"],
    problemId: json["ProblemId"],
    subproblemName: json["SubproblemName"],
    subproblemDelete: json["SubproblemDelete"],
    subproblemStatus: json["SubproblemStatus"],
    subproblemCdt: json["SubproblemCDT"] == null ? null : DateTime.parse(json["SubproblemCDT"]),
  );

  Map<String, dynamic> toJson() => {
    "SubproblemId": subproblemId,
    "ProblemId": problemId,
    "SubproblemName": subproblemName,
    "SubproblemDelete": subproblemDelete,
    "SubproblemStatus": subproblemStatus,
    "SubproblemCDT": subproblemCdt?.toIso8601String(),
  };
}

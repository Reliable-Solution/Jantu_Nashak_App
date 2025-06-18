// To parse this JSON data, do
//
//     final getTicketAreaProblemModel = getTicketAreaProblemModelFromJson(jsonString);

import 'dart:convert';

GetTicketAreaProblemModel getTicketAreaProblemModelFromJson(String str) => GetTicketAreaProblemModel.fromJson(json.decode(str));

String getTicketAreaProblemModelToJson(GetTicketAreaProblemModel data) => json.encode(data.toJson());

class GetTicketAreaProblemModel {
  List<GetTicketAreaProblemData>? data;
  bool? isSuccess;
  String? message;

  GetTicketAreaProblemModel({
    this.data,
    this.isSuccess,
    this.message,
  });

  factory GetTicketAreaProblemModel.fromJson(Map<String, dynamic> json) => GetTicketAreaProblemModel(
    data: json["Data"] == null ? [] : List<GetTicketAreaProblemData>.from(json["Data"]!.map((x) => GetTicketAreaProblemData.fromJson(x))),
    isSuccess: json["IsSuccess"],
    message: json["Message"],
  );

  Map<String, dynamic> toJson() => {
    "Data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "IsSuccess": isSuccess,
    "Message": message,
  };
}

class GetTicketAreaProblemData {
  String? problemId;
  String? problemName;
  String? problemStatus;
  DateTime? problemCdt;

  GetTicketAreaProblemData({
    this.problemId,
    this.problemName,
    this.problemStatus,
    this.problemCdt,
  });

  factory GetTicketAreaProblemData.fromJson(Map<String, dynamic> json) => GetTicketAreaProblemData(
    problemId: json["ProblemId"],
    problemName: json["ProblemName"],
    problemStatus: json["ProblemStatus"],
    problemCdt: json["ProblemCDT"] == null ? null : DateTime.parse(json["ProblemCDT"]),
  );

  Map<String, dynamic> toJson() => {
    "ProblemId": problemId,
    "ProblemName": problemName,
    "ProblemStatus": problemStatus,
    "ProblemCDT": problemCdt?.toIso8601String(),
  };
}

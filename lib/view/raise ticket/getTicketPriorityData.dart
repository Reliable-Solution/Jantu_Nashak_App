// To parse this JSON data, do
//
//     final getTicketPriorityModel = getTicketPriorityModelFromJson(jsonString);

import 'dart:convert';

GetTicketPriorityModel getTicketPriorityModelFromJson(String str) => GetTicketPriorityModel.fromJson(json.decode(str));

String getTicketPriorityModelToJson(GetTicketPriorityModel data) => json.encode(data.toJson());

class GetTicketPriorityModel {
  List<GetTicketPriorityData>? data;
  bool? isSuccess;
  String? message;

  GetTicketPriorityModel({
    this.data,
    this.isSuccess,
    this.message,
  });

  factory GetTicketPriorityModel.fromJson(Map<String, dynamic> json) => GetTicketPriorityModel(
    data: json["Data"] == null ? [] : List<GetTicketPriorityData>.from(json["Data"]!.map((x) => GetTicketPriorityData.fromJson(x))),
    isSuccess: json["IsSuccess"],
    message: json["Message"],
  );

  Map<String, dynamic> toJson() => {
    "Data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "IsSuccess": isSuccess,
    "Message": message,
  };
}

class GetTicketPriorityData {
  String? priorityId;
  String? priorityName;
  String? priorityDelete;
  String? priorityStatus;
  DateTime? priorityCdt;

  GetTicketPriorityData({
    this.priorityId,
    this.priorityName,
    this.priorityDelete,
    this.priorityStatus,
    this.priorityCdt,
  });

  factory GetTicketPriorityData.fromJson(Map<String, dynamic> json) => GetTicketPriorityData(
    priorityId: json["PriorityId"],
    priorityName: json["PriorityName"],
    priorityDelete: json["PriorityDelete"],
    priorityStatus: json["PriorityStatus"],
    priorityCdt: json["PriorityCDT"] == null ? null : DateTime.parse(json["PriorityCDT"]),
  );

  Map<String, dynamic> toJson() => {
    "PriorityId": priorityId,
    "PriorityName": priorityName,
    "PriorityDelete": priorityDelete,
    "PriorityStatus": priorityStatus,
    "PriorityCDT": priorityCdt?.toIso8601String(),
  };
}

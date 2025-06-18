// // To parse this JSON data, do
// //
// //     final addTicketModel = addTicketModelFromJson(jsonString);
//
// import 'dart:convert';
//
// AddTicketModel addTicketModelFromJson(String str) => AddTicketModel.fromJson(json.decode(str));
//
// String addTicketModelToJson(AddTicketModel data) => json.encode(data.toJson());
//
// class AddTicketModel {
//   List<AddTicketData>? data;
//   bool? isSuccess;
//   String? message;
//
//   AddTicketModel({
//     this.data,
//     this.isSuccess,
//     this.message,
//   });
//
//   factory AddTicketModel.fromJson(Map<String, dynamic> json) => AddTicketModel(
//     data: json["Data"] == null ? [] : List<AddTicketData>.from(json["Data"]!.map((x) => AddTicketData.fromJson(x))),
//     isSuccess: json["IsSuccess"],
//     message: json["Message"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "Data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
//     "IsSuccess": isSuccess,
//     "Message": message,
//   };
// }
//
// class AddTicketData {
//   String? ticketsId;
//   String? usersId;
//   String? problemId;
//   String? subproblemId;
//   String? priorityId;
//   String? ticketstageId;
//   String? ticketsUserName;
//   String? ticketsDescription;
//   String? ticketsFacingSince;
//   String? ticketsImage;
//   String? ticketsStatus;
//   DateTime? ticketsCdt;
//
//   AddTicketData({
//     this.ticketsId,
//     this.usersId,
//     this.problemId,
//     this.subproblemId,
//     this.priorityId,
//     this.ticketstageId,
//     this.ticketsUserName,
//     this.ticketsDescription,
//     this.ticketsFacingSince,
//     this.ticketsImage,
//     this.ticketsStatus,
//     this.ticketsCdt,
//   });
//
//   factory AddTicketData.fromJson(Map<String, dynamic> json) => AddTicketData(
//     ticketsId: json["TicketsId"],
//     usersId: json["UsersId"],
//     problemId: json["ProblemId"],
//     subproblemId: json["SubproblemId"],
//     priorityId: json["PriorityId"],
//     ticketstageId: json["TicketstageId"],
//     ticketsUserName: json["TicketsUserName"],
//     ticketsDescription: json["TicketsDescription"],
//     ticketsFacingSince: json["TicketsFacingSince"],
//     ticketsImage: json["TicketsImage"],
//     ticketsStatus: json["TicketsStatus"],
//     ticketsCdt: json["TicketsCDT"] == null ? null : DateTime.parse(json["TicketsCDT"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "TicketsId": ticketsId,
//     "UsersId": usersId,
//     "ProblemId": problemId,
//     "SubproblemId": subproblemId,
//     "PriorityId": priorityId,
//     "TicketstageId": ticketstageId,
//     "TicketsUserName": ticketsUserName,
//     "TicketsDescription": ticketsDescription,
//     "TicketsFacingSince": ticketsFacingSince,
//     "TicketsImage": ticketsImage,
//     "TicketsStatus": ticketsStatus,
//     "TicketsCDT": ticketsCdt?.toIso8601String(),
//   };
// }
class AddTicketModel {
  final bool? isSuccess;
  final String? message;
  final dynamic data;

  AddTicketModel({
    this.isSuccess,
    this.message,
    this.data,
  });

  factory AddTicketModel.fromJson(Map<String, dynamic> json) {
    return AddTicketModel(
      isSuccess: json['IsSuccess'] as bool?,
      message: json['Message'] as String?,
      data: json['Data'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'IsSuccess': isSuccess,
      'Message': message,
      'Data': data,
    };
  }
}

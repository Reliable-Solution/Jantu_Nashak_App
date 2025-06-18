// To parse this JSON data, do
//
//     final getTicketListModel = getTicketListModelFromJson(jsonString);

import 'dart:convert';

GetTicketListModel getTicketListModelFromJson(String str) => GetTicketListModel.fromJson(json.decode(str));

String getTicketListModelToJson(GetTicketListModel data) => json.encode(data.toJson());

class GetTicketListModel {
  List<GetTicketListData>? data;
  bool? isSuccess;
  String? message;

  GetTicketListModel({
    this.data,
    this.isSuccess,
    this.message,
  });

  factory GetTicketListModel.fromJson(Map<String, dynamic> json) => GetTicketListModel(
    data: json["Data"] == null ? [] : List<GetTicketListData>.from(json["Data"]!.map((x) => GetTicketListData.fromJson(x))),
    isSuccess: json["IsSuccess"],
    message: json["Message"],
  );

  Map<String, dynamic> toJson() => {
    "Data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "IsSuccess": isSuccess,
    "Message": message,
  };
}

class GetTicketListData {
  String? ticketsId;
  String? usersId;
  String? problemId;
  String? subproblemId;
  String? priorityId;
  String? ticketstageId;
  String? ticketsUserName;
  String? ticketsDescription;
  DateTime? ticketsFacingSince;
  String? ticketsImage;
  String? ticketsStatus;
  DateTime? ticketsCdt;
  String? groupsId;
  String? businesscategoryId;
  String? usersBusinesscategorySecond;
  String? usersEmail;
  String? usersPassword;
  String? usersVerify;
  String? usersIsmember;
  String? usersCreatedOn;
  String? usersType;
  String? usersActionBy;
  String? usersActionAt;
  String? usersDisabled;
  String? usersFirstname;
  String? usersMembershipid;
  String? usersProfileImage;
  DateTime? usersDob;
  String? usersCompanyname;
  String? usersCompanylogo;
  String? usersCompanydescription;
  String? usersCompanyCategory;
  String? usersPhoneNo;
  String? usersFcmToken;
  String? usersWhatsappNo;
  String? usersCompanyAddress;
  String? usersWebsiteUrl;
  String? usersFacebooklink;
  String? usersInstagramlink;
  String? usersLinkedinlink;
  String? usersGoogleMapLink;
  String? usersReferencename;
  String? usersPoints;
  String? usersReferByName;
  String? usersReferByMobileNo;
  DateTime? usersRenewalDate;
  String? usersInducition;
  String? usersOtpByPass;
  String? usersOnBoard;
  dynamic usersBusinessCategoryTags;
  String? usersTempBlock;
  String? usersStatus;
  DateTime? usersCdt;
  String? problemName;
  String? problemStatus;
  DateTime? problemCdt;
  String? subproblemName;
  String? subproblemDelete;
  String? subproblemStatus;
  DateTime? subproblemCdt;
  String? priorityName;
  String? priorityDelete;
  String? priorityStatus;
  DateTime? priorityCdt;
  String? ticketstageName;
  String? ticketstageDelete;
  String? ticketstageStatus;
  DateTime? ticketstageCdt;

  GetTicketListData({
    this.ticketsId,
    this.usersId,
    this.problemId,
    this.subproblemId,
    this.priorityId,
    this.ticketstageId,
    this.ticketsUserName,
    this.ticketsDescription,
    this.ticketsFacingSince,
    this.ticketsImage,
    this.ticketsStatus,
    this.ticketsCdt,
    this.groupsId,
    this.businesscategoryId,
    this.usersBusinesscategorySecond,
    this.usersEmail,
    this.usersPassword,
    this.usersVerify,
    this.usersIsmember,
    this.usersCreatedOn,
    this.usersType,
    this.usersActionBy,
    this.usersActionAt,
    this.usersDisabled,
    this.usersFirstname,
    this.usersMembershipid,
    this.usersProfileImage,
    this.usersDob,
    this.usersCompanyname,
    this.usersCompanylogo,
    this.usersCompanydescription,
    this.usersCompanyCategory,
    this.usersPhoneNo,
    this.usersFcmToken,
    this.usersWhatsappNo,
    this.usersCompanyAddress,
    this.usersWebsiteUrl,
    this.usersFacebooklink,
    this.usersInstagramlink,
    this.usersLinkedinlink,
    this.usersGoogleMapLink,
    this.usersReferencename,
    this.usersPoints,
    this.usersReferByName,
    this.usersReferByMobileNo,
    this.usersRenewalDate,
    this.usersInducition,
    this.usersOtpByPass,
    this.usersOnBoard,
    this.usersBusinessCategoryTags,
    this.usersTempBlock,
    this.usersStatus,
    this.usersCdt,
    this.problemName,
    this.problemStatus,
    this.problemCdt,
    this.subproblemName,
    this.subproblemDelete,
    this.subproblemStatus,
    this.subproblemCdt,
    this.priorityName,
    this.priorityDelete,
    this.priorityStatus,
    this.priorityCdt,
    this.ticketstageName,
    this.ticketstageDelete,
    this.ticketstageStatus,
    this.ticketstageCdt,
  });

  factory GetTicketListData.fromJson(Map<String, dynamic> json) => GetTicketListData(
    ticketsId: json["TicketsId"],
    usersId: json["UsersId"],
    problemId: json["ProblemId"],
    subproblemId: json["SubproblemId"],
    priorityId: json["PriorityId"],
    ticketstageId: json["TicketstageId"],
    ticketsUserName: json["TicketsUserName"],
    ticketsDescription: json["TicketsDescription"],
    ticketsFacingSince: json["TicketsFacingSince"] == null ? null : DateTime.parse(json["TicketsFacingSince"]),
    ticketsImage: json["TicketsImage"],
    ticketsStatus: json["TicketsStatus"],
    ticketsCdt: json["TicketsCDT"] == null ? null : DateTime.parse(json["TicketsCDT"]),
    groupsId: json["GroupsId"],
    businesscategoryId: json["BusinesscategoryId"],
    usersBusinesscategorySecond: json["UsersBusinesscategorySecond"],
    usersEmail: json["UsersEmail"],
    usersPassword: json["UsersPassword"],
    usersVerify: json["UsersVerify"],
    usersIsmember: json["UsersIsmember"],
    usersCreatedOn: json["UsersCreated_on"],
    usersType: json["UsersType"],
    usersActionBy: json["UsersAction_by"],
    usersActionAt: json["UsersAction_at"],
    usersDisabled: json["UsersDisabled"],
    usersFirstname: json["UsersFirstname"],
    usersMembershipid: json["UsersMembershipid"],
    usersProfileImage: json["UsersProfileImage"],
    usersDob: json["UsersDOB"] == null ? null : DateTime.parse(json["UsersDOB"]),
    usersCompanyname: json["UsersCompanyname"],
    usersCompanylogo: json["UsersCompanylogo"],
    usersCompanydescription: json["UsersCompanydescription"],
    usersCompanyCategory: json["UsersCompanyCategory"],
    usersPhoneNo: json["UsersPhoneNo"],
    usersFcmToken: json["UsersFCMToken"],
    usersWhatsappNo: json["UsersWhatsappNo"],
    usersCompanyAddress: json["UsersCompanyAddress"],
    usersWebsiteUrl: json["UsersWebsiteUrl"],
    usersFacebooklink: json["UsersFacebooklink"],
    usersInstagramlink: json["UsersInstagramlink"],
    usersLinkedinlink: json["UsersLinkedinlink"],
    usersGoogleMapLink: json["UsersGoogleMapLink"],
    usersReferencename: json["UsersReferencename"],
    usersPoints: json["UsersPoints"],
    usersReferByName: json["UsersReferByName"],
    usersReferByMobileNo: json["UsersReferByMobileNo"],
    usersRenewalDate: json["UsersRenewalDate"] == null ? null : DateTime.parse(json["UsersRenewalDate"]),
    usersInducition: json["UsersInducition"],
    usersOtpByPass: json["UsersOTPByPass"],
    usersOnBoard: json["UsersOnBoard"],
    usersBusinessCategoryTags: json["UsersBusinessCategoryTags"],
    usersTempBlock: json["UsersTempBlock"],
    usersStatus: json["UsersStatus"],
    usersCdt: json["UsersCDT"] == null ? null : DateTime.parse(json["UsersCDT"]),
    problemName: json["ProblemName"],
    problemStatus: json["ProblemStatus"],
    problemCdt: json["ProblemCDT"] == null ? null : DateTime.parse(json["ProblemCDT"]),
    subproblemName: json["SubproblemName"],
    subproblemDelete: json["SubproblemDelete"],
    subproblemStatus: json["SubproblemStatus"],
    subproblemCdt: json["SubproblemCDT"] == null ? null : DateTime.parse(json["SubproblemCDT"]),
    priorityName: json["PriorityName"],
    priorityDelete: json["PriorityDelete"],
    priorityStatus: json["PriorityStatus"],
    priorityCdt: json["PriorityCDT"] == null ? null : DateTime.parse(json["PriorityCDT"]),
    ticketstageName: json["TicketstageName"],
    ticketstageDelete: json["TicketstageDelete"],
    ticketstageStatus: json["TicketstageStatus"],
    ticketstageCdt: json["TicketstageCDT"] == null ? null : DateTime.parse(json["TicketstageCDT"]),
  );

  Map<String, dynamic> toJson() => {
    "TicketsId": ticketsId,
    "UsersId": usersId,
    "ProblemId": problemId,
    "SubproblemId": subproblemId,
    "PriorityId": priorityId,
    "TicketstageId": ticketstageId,
    "TicketsUserName": ticketsUserName,
    "TicketsDescription": ticketsDescription,
    "TicketsFacingSince": "${ticketsFacingSince!.year.toString().padLeft(4, '0')}-${ticketsFacingSince!.month.toString().padLeft(2, '0')}-${ticketsFacingSince!.day.toString().padLeft(2, '0')}",
    "TicketsImage": ticketsImage,
    "TicketsStatus": ticketsStatus,
    "TicketsCDT": ticketsCdt?.toIso8601String(),
    "GroupsId": groupsId,
    "BusinesscategoryId": businesscategoryId,
    "UsersBusinesscategorySecond": usersBusinesscategorySecond,
    "UsersEmail": usersEmail,
    "UsersPassword": usersPassword,
    "UsersVerify": usersVerify,
    "UsersIsmember": usersIsmember,
    "UsersCreated_on": usersCreatedOn,
    "UsersType": usersType,
    "UsersAction_by": usersActionBy,
    "UsersAction_at": usersActionAt,
    "UsersDisabled": usersDisabled,
    "UsersFirstname": usersFirstname,
    "UsersMembershipid": usersMembershipid,
    "UsersProfileImage": usersProfileImage,
    "UsersDOB": "${usersDob!.year.toString().padLeft(4, '0')}-${usersDob!.month.toString().padLeft(2, '0')}-${usersDob!.day.toString().padLeft(2, '0')}",
    "UsersCompanyname": usersCompanyname,
    "UsersCompanylogo": usersCompanylogo,
    "UsersCompanydescription": usersCompanydescription,
    "UsersCompanyCategory": usersCompanyCategory,
    "UsersPhoneNo": usersPhoneNo,
    "UsersFCMToken": usersFcmToken,
    "UsersWhatsappNo": usersWhatsappNo,
    "UsersCompanyAddress": usersCompanyAddress,
    "UsersWebsiteUrl": usersWebsiteUrl,
    "UsersFacebooklink": usersFacebooklink,
    "UsersInstagramlink": usersInstagramlink,
    "UsersLinkedinlink": usersLinkedinlink,
    "UsersGoogleMapLink": usersGoogleMapLink,
    "UsersReferencename": usersReferencename,
    "UsersPoints": usersPoints,
    "UsersReferByName": usersReferByName,
    "UsersReferByMobileNo": usersReferByMobileNo,
    "UsersRenewalDate": "${usersRenewalDate!.year.toString().padLeft(4, '0')}-${usersRenewalDate!.month.toString().padLeft(2, '0')}-${usersRenewalDate!.day.toString().padLeft(2, '0')}",
    "UsersInducition": usersInducition,
    "UsersOTPByPass": usersOtpByPass,
    "UsersOnBoard": usersOnBoard,
    "UsersBusinessCategoryTags": usersBusinessCategoryTags,
    "UsersTempBlock": usersTempBlock,
    "UsersStatus": usersStatus,
    "UsersCDT": usersCdt?.toIso8601String(),
    "ProblemName": problemName,
    "ProblemStatus": problemStatus,
    "ProblemCDT": problemCdt?.toIso8601String(),
    "SubproblemName": subproblemName,
    "SubproblemDelete": subproblemDelete,
    "SubproblemStatus": subproblemStatus,
    "SubproblemCDT": subproblemCdt?.toIso8601String(),
    "PriorityName": priorityName,
    "PriorityDelete": priorityDelete,
    "PriorityStatus": priorityStatus,
    "PriorityCDT": priorityCdt?.toIso8601String(),
    "TicketstageName": ticketstageName,
    "TicketstageDelete": ticketstageDelete,
    "TicketstageStatus": ticketstageStatus,
    "TicketstageCDT": ticketstageCdt?.toIso8601String(),
  };
}

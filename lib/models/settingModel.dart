class SettingModel {
  List<SettingInfo>? data;
  bool? isSuccess;
  String? message;

  SettingModel({this.data, this.isSuccess, this.message});

  SettingModel.fromJson(Map<String, dynamic> json) {
    if (json['Data'] != null) {
      data = <SettingInfo>[];
      json['Data'].forEach((v) {
        data!.add(new SettingInfo.fromJson(v));
      });
    }
    isSuccess = json['IsSuccess'];
    message = json['Message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['Data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['IsSuccess'] = this.isSuccess;
    data['Message'] = this.message;
    return data;
  }
}

class SettingInfo {
  String? settingId;
  String? settingBaseURL;
  String? settingPhoneNumber;
  String? settingImage;
  String? settingCallingNumber;
  String? settingWhatsAppNumber;
  String? settingWhatsAppMessage;
  String? settingTermsConditionURL;
  String? settingPrivacyPolicyURL;
  String? settingFaqURL;
  String? settingHelpAndSupportURL;
  String? settingContactUsURL;
  String? settingsLowstock;
  String? settingRedeemPoints;
  String? settingEarnPointsPercentage;
  String? settingRedeemPointsMessage;
  String? settingCartRedeemPointsPercentage;
  String? settingAndroidAppLink;
  String? settingIosAppLink;
  String? settingReferSender;
  String? settingReferReciever;
  String? settingReferMessage;
  String? settingSignupBonus;
  String? settingMaintenanceMode;
  String? instantAPIToken;
  String? instantAPIURL;
  String? settingStatus;
  String? settingCDT;

  SettingInfo(
      {this.settingId,
      this.settingBaseURL,
      this.settingPhoneNumber,
      this.settingImage,
      this.settingCallingNumber,
      this.settingWhatsAppNumber,
      this.settingWhatsAppMessage,
      this.settingTermsConditionURL,
      this.settingPrivacyPolicyURL,
      this.settingFaqURL,
      this.settingHelpAndSupportURL,
      this.settingContactUsURL,
      this.settingsLowstock,
      this.settingRedeemPoints,
      this.settingEarnPointsPercentage,
      this.settingRedeemPointsMessage,
      this.settingCartRedeemPointsPercentage,
      this.settingAndroidAppLink,
      this.settingIosAppLink,
      this.settingReferSender,
      this.settingReferReciever,
      this.settingReferMessage,
      this.settingSignupBonus,
      this.settingMaintenanceMode,
      this.instantAPIToken,
      this.instantAPIURL,
      this.settingStatus,
      this.settingCDT});

  SettingInfo.fromJson(Map<String, dynamic> json) {
    settingId = json['SettingId'];
    settingBaseURL = json['SettingBaseURL'];
    settingPhoneNumber = json['SettingPhoneNumber'];
    settingImage = json['SettingImage'];
    settingCallingNumber = json['SettingCallingNumber'];
    settingWhatsAppNumber = json['SettingWhatsAppNumber'];
    settingWhatsAppMessage = json['SettingWhatsAppMessage'];
    settingTermsConditionURL = json['SettingTermsConditionURL'];
    settingPrivacyPolicyURL = json['SettingPrivacyPolicyURL'];
    settingFaqURL = json['SettingFaqURL'];
    settingHelpAndSupportURL = json['SettingHelpAndSupportURL'];
    settingContactUsURL = json['SettingContactUsURL'];
    settingsLowstock = json['SettingsLowstock'];
    settingRedeemPoints = json['SettingRedeemPoints'];
    settingEarnPointsPercentage = json['SettingEarnPointsPercentage'];
    settingRedeemPointsMessage = json['SettingRedeemPointsMessage'];
    settingCartRedeemPointsPercentage =
        json['SettingCartRedeemPointsPercentage'];
    settingAndroidAppLink = json['SettingAndroidAppLink'];
    settingIosAppLink = json['SettingIosAppLink'];
    settingReferSender = json['SettingReferSender'];
    settingReferReciever = json['SettingReferReciever'];
    settingReferMessage = json['SettingReferMessage'];
    settingSignupBonus = json['SettingSignupBonus'];
    settingMaintenanceMode = json['SettingMaintenanceMode'];
    instantAPIToken = json['Instant_API_token'];
    instantAPIURL = json['Instant_API_URL'];
    settingStatus = json['SettingStatus'];
    settingCDT = json['SettingCDT'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['SettingId'] = this.settingId;
    data['SettingBaseURL'] = this.settingBaseURL;
    data['SettingPhoneNumber'] = this.settingPhoneNumber;
    data['SettingImage'] = this.settingImage;
    data['SettingCallingNumber'] = this.settingCallingNumber;
    data['SettingWhatsAppNumber'] = this.settingWhatsAppNumber;
    data['SettingWhatsAppMessage'] = this.settingWhatsAppMessage;
    data['SettingTermsConditionURL'] = this.settingTermsConditionURL;
    data['SettingPrivacyPolicyURL'] = this.settingPrivacyPolicyURL;
    data['SettingFaqURL'] = this.settingFaqURL;
    data['SettingHelpAndSupportURL'] = this.settingHelpAndSupportURL;
    data['SettingContactUsURL'] = this.settingContactUsURL;
    data['SettingsLowstock'] = this.settingsLowstock;
    data['SettingRedeemPoints'] = this.settingRedeemPoints;
    data['SettingEarnPointsPercentage'] = this.settingEarnPointsPercentage;
    data['SettingRedeemPointsMessage'] = this.settingRedeemPointsMessage;
    data['SettingCartRedeemPointsPercentage'] =
        this.settingCartRedeemPointsPercentage;
    data['SettingAndroidAppLink'] = this.settingAndroidAppLink;
    data['SettingIosAppLink'] = this.settingIosAppLink;
    data['SettingReferSender'] = this.settingReferSender;
    data['SettingReferReciever'] = this.settingReferReciever;
    data['SettingReferMessage'] = this.settingReferMessage;
    data['SettingSignupBonus'] = this.settingSignupBonus;
    data['SettingMaintenanceMode'] = this.settingMaintenanceMode;
    data['Instant_API_token'] = this.instantAPIToken;
    data['Instant_API_URL'] = this.instantAPIURL;
    data['SettingStatus'] = this.settingStatus;
    data['SettingCDT'] = this.settingCDT;
    return data;
  }
}

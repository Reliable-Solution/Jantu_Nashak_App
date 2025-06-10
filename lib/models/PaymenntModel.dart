import 'dart:convert';

class PaymentGateway {
  String? gatewayId;
  String? gatewayName;
  String? firmId;
  String? gatewayLogo;
  Map<String, dynamic>? gatewayCredentialsJson; // dynamic structure
  String? gatewayStatus;
  String? gatewayCDT;

  PaymentGateway({
    this.gatewayId,
    this.gatewayName,
    this.firmId,
    this.gatewayLogo,
    this.gatewayCredentialsJson,
    this.gatewayStatus,
    this.gatewayCDT,
  });

  factory PaymentGateway.fromJson(Map<String, dynamic> json) {
    final credentials = json['GatewayCredentialsJson'];

    Map<String, dynamic>? parsedCredentials;
    if (credentials is Map<String, dynamic>) {
      parsedCredentials = credentials;
    } else if (credentials is String && credentials.trim().isNotEmpty) {
      try {
        parsedCredentials = jsonDecode(credentials);
      } catch (e) {
        parsedCredentials = null;
      }
    }

    return PaymentGateway(
      gatewayId: json['GatewayId']?.toString(),
      gatewayName: json['GatewayName'],
      firmId: json['FirmId']?.toString(),
      gatewayLogo: json['GatewayLogo'],
      gatewayCredentialsJson: parsedCredentials,
      gatewayStatus: json['GatewayStatus']?.toString(),
      gatewayCDT: json['GatewayCDT'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'GatewayId': gatewayId,
      'GatewayName': gatewayName,
      'FirmId': firmId,
      'GatewayLogo': gatewayLogo,
      'GatewayCredentialsJson': gatewayCredentialsJson,
      'GatewayStatus': gatewayStatus,
      'GatewayCDT': gatewayCDT,
    };
  }
}

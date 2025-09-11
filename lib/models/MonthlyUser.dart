// // class MonthlyUser {
// //   final String customerId;
// //   final String totalAmount;
// //   final int rank;
// //
// //   MonthlyUser.fromJson(Map<String, dynamic> json)
// //       : customerId = json['CustomerId'],
// //         totalAmount = json['TotalAmount'],
// //         rank = json['Rank'];
// // }
//
//
//
// class MonthlyUser {
//   String? customerId;
//   String? totalAmount;
//   String? month;
//   String? year;
//   int? rank;
//
//   MonthlyUser(
//       {this.customerId, this.totalAmount, this.month, this.year, this.rank});
//
//   MonthlyUser.fromJson(Map<String, dynamic> json) {
//     customerId = json['CustomerId'];
//     totalAmount = json['TotalAmount'];
//     month = json['Month'];
//     year = json['Year'];
//     rank = json['Rank'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['CustomerId'] = this.customerId;
//     data['TotalAmount'] = this.totalAmount;
//     data['Month'] = this.month;
//     data['Year'] = this.year;
//     data['Rank'] = this.rank;
//     return data;
//   }
// }
class MonthlyUser {
  final String customerId;
  final String customerName;
  final String totalAmount;
  final int rank;

  MonthlyUser.fromJson(Map<String, dynamic> json)
      : customerId = json['CustomerId'].toString(),
       customerName = json['CustomerName'].toString(),
        totalAmount = json['TotalAmount'].toString(),
        rank = json['Rank'] as int;
}
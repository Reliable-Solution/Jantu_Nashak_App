class Prize {
  final String prizeId;
  final String prizeName;
  final String prizeImage;
  final int prizePosition;

  Prize.fromJson(Map<String, dynamic> json)
      : prizeId = json['PrizeId'],
        prizeName = json['PrizeName'],
        prizeImage = json['PrizeImage'],
        prizePosition = int.parse(json['PrizePosition']);
}
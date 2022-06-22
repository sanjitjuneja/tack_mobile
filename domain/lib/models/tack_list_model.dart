class TackListModel {
  final String title;
  final double price;
  final double rating;
  final String imageUrl;
  final int reviewsCount;
  final String primaryDelay;
  final String? tackerName;
  final String? chanelName;
  final String? secondaryDelay;

  TackListModel({
    required this.title,
    required this.price,
    required this.rating,
    required this.imageUrl,
    required this.reviewsCount,
    required this.primaryDelay,
    this.tackerName,
    this.chanelName,
    this.secondaryDelay,
  });

  factory TackListModel.fromMap(Map<String, dynamic> map) {
    return TackListModel(
      title: map[''] as String,
      price: double.parse(map[''].toString()),
      rating: map[''] as double,
      imageUrl: map[''] as String,
      reviewsCount: map[''] as int,
      primaryDelay: map[''] as String,
      tackerName: map[''] as String?,
      chanelName: map[''] as String?,
      secondaryDelay: map[''] as String?,
    );
  }
}

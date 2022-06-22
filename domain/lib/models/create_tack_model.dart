class CreateTackModel {
  final String time;
  final double price;
  final String status;
  final String tackTitle;
  final bool isSavedTack;
  final String description;

  CreateTackModel({
    required this.time,
    required this.price,
    required this.status,
    required this.tackTitle,
    required this.isSavedTack,
    required this.description,
  });

  factory CreateTackModel.from(Map<String, dynamic> map) {
    return CreateTackModel(
      time: map[''] as String,
      price: map[''] as double,
      status: map[''] as String,
      tackTitle: map[''] as String,
      isSavedTack: map[''] as bool,
      description: map[''] as String,
    );
  }
}

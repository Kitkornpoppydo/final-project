class BirdModel {
  late String bird_common_name;
  late String bird_th_name;
  late String bird_anatomy_detail;
  late String bird_behavior;
  late String bird_food;
  late String bird_image; // Changed to String for URL
  late int id;

  BirdModel({
    required this.bird_common_name,
    required this.bird_th_name,
    required this.bird_anatomy_detail,
    required this.bird_behavior,
    required this.bird_food,
    required this.bird_image,
    required this.id,
  });

  factory BirdModel.fromJson(dynamic json) {
    return BirdModel(
      id: json['id'] as int,
      bird_common_name: json['bird_common_name'] as String,
      bird_th_name: json['bird_th_name'] as String,
      bird_anatomy_detail: json['bird_anatomy_detail'] as String,
      bird_behavior: json['bird_behavior'] as String,
      bird_food: json['bird_food'] as String,
      bird_image: json['bird_image'] as String, // Keep as String for the URL
    );
  }
}


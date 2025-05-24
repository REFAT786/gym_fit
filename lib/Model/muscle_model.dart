class MuscleModel {
  final String id;
  final String name;
  final String image;

  MuscleModel({
    this.id = '',
    this.name = '',
    this.image = '',
  });

  factory MuscleModel.fromJson(Map<String, dynamic> json) => MuscleModel(
    id: json["id"] ?? '',
    name: json["muscleGroupName"] ?? '',
    image: json["muscleGroupImage"] ?? '',
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "image": image,
  };
}
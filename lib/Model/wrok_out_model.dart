class WorkOutModel {
  final String id;
  final bool completed;
  final DateTime createdAt;
  final Equipment equipment;
  final String exerciseId;
  final String exerciseName;
  final String exerciseImage;
  final String exerciseVideo;
  final String exerciseDescription;
  final String userName;
  final String userImage;
  final List<WorkoutType> workoutTypes;
  final List<dynamic> stations;
  final List<MuscleGroup> muscleGroups;
  late final List<dynamic> measurements;

  WorkOutModel({
    this.id = '',
    this.completed = false,
    DateTime? createdAt,
    Equipment? equipment,
    this.exerciseId = '',
    this.exerciseName = '',
    this.exerciseImage = '',
    this.exerciseVideo = '',
    this.exerciseDescription = '',
    this.userName = '',
    this.userImage = '',
    List<WorkoutType>? workoutTypes,
    List<dynamic>? stations,
    List<MuscleGroup>? muscleGroups,
    List<dynamic>? measurements,
  })  : createdAt = createdAt ?? DateTime(1970),
        equipment = equipment ?? Equipment(),
        workoutTypes = workoutTypes ?? [],
        stations = stations ?? [],
        muscleGroups = muscleGroups ?? [],
        measurements = measurements ?? [];

  factory WorkOutModel.fromJson(Map<String, dynamic> json) => WorkOutModel(
    id: json["_id"] ?? '',
    completed: json["completed"] ?? false,
    createdAt: DateTime.tryParse(json["createdAt"] ?? '') ?? DateTime(1970),
    equipment: json["equipment"] == null
        ? Equipment()
        : Equipment.fromJson(json["equipment"]),
    exerciseId: json["exerciseId"] ?? '',
    exerciseName: json["exerciseName"] ?? '',
    exerciseImage: json["exerciseImage"] ?? '',
    exerciseVideo: json["exerciseVideo"] ?? '',
    exerciseDescription: json["exerciseDescription"] ?? '',
    userName: json["userName"] ?? '',
    userImage: json["userImage"] ?? '',
    workoutTypes: json["workoutTypes"] == null
        ? []
        : List<WorkoutType>.from(
        json["workoutTypes"].map((x) => WorkoutType.fromJson(x))),
    stations: json["stations"] ?? [],
    muscleGroups: json["muscleGroups"] == null
        ? []
        : List<MuscleGroup>.from(
        json["muscleGroups"].map((x) => MuscleGroup.fromJson(x))),
    measurements: json["measurement"] ?? [],
  );

  static List<WorkOutModel> fromJsonList(List<dynamic> list) =>
      list.map((e) => WorkOutModel.fromJson(e)).toList();

  Map<String, dynamic> toJson() => {
    "_id": id,
    "completed": completed,
    "createdAt": createdAt.toIso8601String(),
    "equipment": equipment.toJson(),
    "exerciseId": exerciseId,
    "exerciseName": exerciseName,
    "exerciseImage": exerciseImage,
    "exerciseVideo": exerciseVideo,
    "exerciseDescription": exerciseDescription,
    "userName": userName,
    "userImage": userImage,
    "workoutTypes": workoutTypes.map((x) => x.toJson()).toList(),
    "stations": stations,
    "muscleGroups": muscleGroups.map((x) => x.toJson()).toList(),
    "measurement": measurements,
  };
}

class Equipment {
  final String id;
  final String name;
  final String image;
  final String description;
  final String instruction;

  Equipment({
    this.id = '',
    this.name = '',
    this.image = '',
    this.description = '',
    this.instruction = '',
  });

  factory Equipment.fromJson(Map<String, dynamic> json) => Equipment(
    id: json["id"] ?? '',
    name: json["name"] ?? '',
    image: json["image"] ?? '',
    description: json["description"] ?? '',
    instruction: json["instruction"] ?? '',
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "image": image,
    "description": description,
    "instruction": instruction,
  };
}

class WorkoutType {
  final String id;
  final String name;
  final String image;
  final String description;

  WorkoutType({
    this.id = '',
    this.name = '',
    this.image = '',
    this.description = '',
  });

  factory WorkoutType.fromJson(Map<String, dynamic> json) => WorkoutType(
    id: json["id"] ?? '',
    name: json["name"] ?? '',
    image: json["image"] ?? '',
    description: json["description"] ?? '',
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "image": image,
    "description": description,
  };
}

class MuscleGroup {
  final String id;
  final String name;
  final String image;

  MuscleGroup({
    this.id = '',
    this.name = '',
    this.image = '',
  });

  factory MuscleGroup.fromJson(Map<String, dynamic> json) => MuscleGroup(
    id: json["id"] ?? '',
    name: json["name"] ?? '',
    image: json["image"] ?? '',
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "image": image,
  };
}


class MeasurementModel {
  final String name;
  final dynamic value;
  final String unit;

  MeasurementModel({
    this.name = '',
    this.value,
    this.unit = '',
  });

  factory MeasurementModel.fromJson(Map<String, dynamic> json) =>
      MeasurementModel(
        name: json["name"] ?? '',
        value: json["value"],
        unit: json["unit"] ?? '',
      );

  Map<String, dynamic> toJson() => {
    "name": name,
    "value": value,
    "unit": unit,
  };
}

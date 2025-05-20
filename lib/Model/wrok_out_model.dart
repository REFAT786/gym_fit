// // workout_model.dart
// class WorkOutModel {
//   String status;
//   int statusCode;
//   String message;
//   WorkOutData data;
//   List<dynamic> errors;
//
//   WorkOutModel({
//     this.status = '',
//     this.statusCode = 0,
//     this.message = '',
//     required this.data,
//     this.errors = const [],
//   });
//
//   factory WorkOutModel.fromJson(Map<String, dynamic> json) => WorkOutModel(
//     status: json['status'] ?? '',
//     statusCode: json['statusCode'] ?? 0,
//     message: json['message'] ?? '',
//     data: WorkOutData.fromJson(json['data'] ?? {}),
//     errors: json['errors'] ?? [],
//   );
//
//   Map<String, dynamic> toJson() => {
//     'status': status,
//     'statusCode': statusCode,
//     'message': message,
//     'data': data.toJson(),
//     'errors': errors,
//   };
// }
//
// class WorkOutData {
//   String type;
//   List<Attribute> attributes;
//
//   WorkOutData({
//     this.type = '',
//     this.attributes = const [],
//   });
//
//   factory WorkOutData.fromJson(Map<String, dynamic> json) => WorkOutData(
//     type: json['type'] ?? '',
//     attributes: (json['attributes'] as List<dynamic>? ?? [])
//         .map((e) => Attribute.fromJson(e))
//         .toList(),
//   );
//
//   Map<String, dynamic> toJson() => {
//     'type': type,
//     'attributes': attributes.map((e) => e.toJson()).toList(),
//   };
// }
//
// class Attribute {
//   String id;
//   bool completed;
//   String createdAt;
//   Equipment equipment;
//   String exerciseId;
//   String exerciseName;
//   String exerciseImage;
//   String exerciseVideo;
//   String userName;
//   String userImage;
//   List<WorkoutType> workoutTypes;
//   List<dynamic> stations;
//   List<dynamic> muscleGroups;
//   List<dynamic> measurements;
//
//   Attribute({
//     this.id = '',
//     this.completed = false,
//     this.createdAt = '',
//     required this.equipment,
//     this.exerciseId = '',
//     this.exerciseName = '',
//     this.exerciseImage = '',
//     this.exerciseVideo = '',
//     this.userName = '',
//     this.userImage = '',
//     this.workoutTypes = const [],
//     this.stations = const [],
//     this.muscleGroups = const [],
//     this.measurements = const [],
//   });
//
//   factory Attribute.fromJson(Map<String, dynamic> json) => Attribute(
//     id: json['_id'] ?? '',
//     completed: json['completed'] ?? false,
//     createdAt: json['createdAt'] ?? '',
//     equipment: Equipment.fromJson(json['equipment'] ?? {}),
//     exerciseId: json['exerciseId'] ?? '',
//     exerciseName: json['exerciseName'] ?? '',
//     exerciseImage: json['exerciseImage'] ?? '',
//     exerciseVideo: json['exerciseVideo'] ?? '',
//     userName: json['userName'] ?? '',
//     userImage: json['userImage'] ?? '',
//     workoutTypes: (json['workoutTypes'] as List<dynamic>? ?? [])
//         .map((e) => WorkoutType.fromJson(e))
//         .toList(),
//     stations: json['stations'] ?? [],
//     muscleGroups: json['muscleGroups'] ?? [],
//     measurements: json['measurements'] ?? [],
//   );
//
//   Map<String, dynamic> toJson() => {
//     '_id': id,
//     'completed': completed,
//     'createdAt': createdAt,
//     'equipment': equipment.toJson(),
//     'exerciseId': exerciseId,
//     'exerciseName': exerciseName,
//     'exerciseImage': exerciseImage,
//     'exerciseVideo': exerciseVideo,
//     'userName': userName,
//     'userImage': userImage,
//     'workoutTypes': workoutTypes.map((e) => e.toJson()).toList(),
//     'stations': stations,
//     'muscleGroups': muscleGroups,
//     'measurements': measurements,
//   };
// }
//
// class Equipment {
//   String id;
//   String name;
//   String image;
//   String description;
//   String instruction;
//
//   Equipment({
//     this.id = '',
//     this.name = '',
//     this.image = '',
//     this.description = '',
//     this.instruction = '',
//   });
//
//   factory Equipment.fromJson(Map<String, dynamic> json) => Equipment(
//     id: json['id'] ?? '',
//     name: json['name'] ?? '',
//     image: json['image'] ?? '',
//     description: json['description'] ?? '',
//     instruction: json['instruction'] ?? '',
//   );
//
//   Map<String, dynamic> toJson() => {
//     'id': id,
//     'name': name,
//     'image': image,
//     'description': description,
//     'instruction': instruction,
//   };
// }
//
// class WorkoutType {
//   String id;
//   String name;
//   String image;
//   String description;
//
//   WorkoutType({
//     this.id = '',
//     this.name = '',
//     this.image = '',
//     this.description = '',
//   });
//
//   factory WorkoutType.fromJson(Map<String, dynamic> json) => WorkoutType(
//     id: json['id'] ?? '',
//     name: json['name'] ?? '',
//     image: json['image'] ?? '',
//     description: json['description'] ?? '',
//   );
//
//   Map<String, dynamic> toJson() => {
//     'id': id,
//     'name': name,
//     'image': image,
//     'description': description,
//   };
// }
class WorkOutModel {
  final String id;
  final bool completed;
  final DateTime createdAt;
  final Equipment equipment;
  final String exerciseId;
  final String exerciseName;
  final String exerciseImage;
  final String exerciseVideo;
  final String userName;
  final String userImage;
  final List<WorkoutType> workoutTypes;
  final List<dynamic> stations;
  final List<MuscleGroup> muscleGroups;
  final List<dynamic> measurements;

  WorkOutModel({
    this.id = '',
    this.completed = false,
    DateTime? createdAt,
    Equipment? equipment,
    this.exerciseId = '',
    this.exerciseName = '',
    this.exerciseImage = '',
    this.exerciseVideo = '',
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
    createdAt:
    DateTime.tryParse(json["createdAt"] ?? '') ?? DateTime(1970),
    equipment: json["equipment"] == null
        ? Equipment()
        : Equipment.fromJson(json["equipment"]),
    exerciseId: json["exerciseId"] ?? '',
    exerciseName: json["exerciseName"] ?? '',
    exerciseImage: json["exerciseImage"] ?? '',
    exerciseVideo: json["exerciseVideo"] ?? '',
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
    measurements: json["measurements"] ?? [],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "completed": completed,
    "createdAt": createdAt.toIso8601String(),
    "equipment": equipment.toJson(),
    "exerciseId": exerciseId,
    "exerciseName": exerciseName,
    "exerciseImage": exerciseImage,
    "exerciseVideo": exerciseVideo,
    "userName": userName,
    "userImage": userImage,
    "workoutTypes": workoutTypes.map((x) => x.toJson()).toList(),
    "stations": stations,
    "muscleGroups": muscleGroups.map((x) => x.toJson()).toList(),
    "measurements": measurements,
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

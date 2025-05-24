class HistoryModel {
  final String status;
  final int statusCode;
  final String message;
  final HistoryData data;
  final List<dynamic> errors;

  HistoryModel({
    this.status = '',
    this.statusCode = 0,
    this.message = '',
    required this.data,
    this.errors = const [],
  });

  factory HistoryModel.fromJson(Map<String, dynamic> json) => HistoryModel(
    status: json['status'] ?? '',
    statusCode: json['statusCode'] ?? 0,
    message: json['message'] ?? '',
    data: HistoryData.fromJson(json['data'] ?? {}),
    errors: json['errors'] ?? [],
  );

  Map<String, dynamic> toJson() => {
    'status': status,
    'statusCode': statusCode,
    'message': message,
    'data': data.toJson(),
    'errors': errors,
  };
}

class HistoryData {
  final String type;
  final List<HistoryAttribute> attributes;

  HistoryData({
    this.type = '',
    this.attributes = const [],
  });

  factory HistoryData.fromJson(Map<String, dynamic> json) => HistoryData(
    type: json['type'] ?? '',
    attributes: json['attributes'] != null
        ? List<HistoryAttribute>.from(
        json['attributes'].map((x) => HistoryAttribute.fromJson(x)))
        : [],
  );

  Map<String, dynamic> toJson() => {
    'type': type,
    'attributes': List<dynamic>.from(attributes.map((x) => x.toJson())),
  };
}

class HistoryAttribute {
  final Workout workout;
  final String completedAt;
  final Exercise exercise;

  HistoryAttribute({
    required this.workout,
    this.completedAt = '',
    required this.exercise,
  });

  factory HistoryAttribute.fromJson(Map<String, dynamic> json) => HistoryAttribute(
    workout: Workout.fromJson(json['workout'] ?? {}),
    completedAt: json['completedAt'] ?? '',
    exercise: Exercise.fromJson(json['exercise'] ?? {}),
  );

  Map<String, dynamic> toJson() => {
    'workout': workout.toJson(),
    'completedAt': completedAt,
    'exercise': exercise.toJson(),
  };
}

class Workout {
  final String id;
  final String user;
  final String exercise;
  final bool completed;
  final String createdAt;
  final String updatedAt;
  final int v;

  Workout({
    this.id = '',
    this.user = '',
    this.exercise = '',
    this.completed = false,
    this.createdAt = '',
    this.updatedAt = '',
    this.v = 0,
  });

  factory Workout.fromJson(Map<String, dynamic> json) => Workout(
    id: json['_id'] ?? '',
    user: json['user'] ?? '',
    exercise: json['exercise'] ?? '',
    completed: json['completed'] ?? false,
    createdAt: json['createdAt'] ?? '',
    updatedAt: json['updatedAt'] ?? '',
    v: json['__v'] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    '_id': id,
    'user': user,
    'exercise': exercise,
    'completed': completed,
    'createdAt': createdAt,
    'updatedAt': updatedAt,
    '__v': v,
  };
}

class Exercise {
  final String id;
  final String name;
  final String description;
  final String instructions;
  final String exerciseImage;
  final String exerciseVideo;
  final List<WorkoutType> workoutType;
  final List<MuscleGroup> muscleGroup;
  final List<Station> stations;

  Exercise({
    this.id = '',
    this.name = '',
    this.description = '',
    this.instructions = '',
    this.exerciseImage = '',
    this.exerciseVideo = '',
    this.workoutType = const [],
    this.muscleGroup = const [],
    this.stations = const [],
  });

  factory Exercise.fromJson(Map<String, dynamic> json) => Exercise(
    id: json['_id'] ?? '',
    name: json['name'] ?? '',
    description: json['description'] ?? '',
    instructions: json['instructions'] ?? '',
    exerciseImage: json['exerciseImage'] ?? '',
    exerciseVideo: json['exerciseVideo'] ?? '',
    workoutType: json['wrokouttype'] != null
        ? List<WorkoutType>.from(
        json['wrokouttype'].map((x) => WorkoutType.fromJson(x)))
        : [],
    muscleGroup: json['muscleGroup'] != null
        ? List<MuscleGroup>.from(
        json['muscleGroup'].map((x) => MuscleGroup.fromJson(x)))
        : [],
    stations: json['stations'] != null
        ? List<Station>.from(json['stations'].map((x) => Station.fromJson(x)))
        : [],
  );

  Map<String, dynamic> toJson() => {
    '_id': id,
    'name': name,
    'description': description,
    'instructions': instructions,
    'exerciseImage': exerciseImage,
    'exerciseVideo': exerciseVideo,
    'wrokouttype': List<dynamic>.from(workoutType.map((x) => x.toJson())),
    'muscleGroup': List<dynamic>.from(muscleGroup.map((x) => x.toJson())),
    'stations': List<dynamic>.from(stations.map((x) => x.toJson())),
  };
}

class WorkoutType {
  final String id;
  final String image;
  final String name;
  final String description;
  final String createdAt;
  final String updatedAt;
  final int v;

  WorkoutType({
    this.id = '',
    this.image = '',
    this.name = '',
    this.description = '',
    this.createdAt = '',
    this.updatedAt = '',
    this.v = 0,
  });

  factory WorkoutType.fromJson(Map<String, dynamic> json) => WorkoutType(
    id: json['_id'] ?? '',
    image: json['image'] ?? '',
    name: json['name'] ?? '',
    description: json['description'] ?? '',
    createdAt: json['createdAt'] ?? '',
    updatedAt: json['updatedAt'] ?? '',
    v: json['__v'] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    '_id': id,
    'image': image,
    'name': name,
    'description': description,
    'createdAt': createdAt,
    'updatedAt': updatedAt,
    '__v': v,
  };
}

class MuscleGroup {
  final String id;
  final String mgName;
  final String mgImage;
  final String description;
  final String createdAt;
  final String updatedAt;
  final int v;

  MuscleGroup({
    this.id = '',
    this.mgName = '',
    this.mgImage = '',
    this.description = '',
    this.createdAt = '',
    this.updatedAt = '',
    this.v = 0,
  });

  factory MuscleGroup.fromJson(Map<String, dynamic> json) => MuscleGroup(
    id: json['_id'] ?? '',
    mgName: json['mgName'] ?? '',
    mgImage: json['mgImage'] ?? '',
    description: json['description'] ?? '',
    createdAt: json['createdAt'] ?? '',
    updatedAt: json['updatedAt'] ?? '',
    v: json['__v'] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    '_id': id,
    'mgName': mgName,
    'mgImage': mgImage,
    'description': description,
    'createdAt': createdAt,
    'updatedAt': updatedAt,
    '__v': v,
  };
}

class Station {
  final String id;
  final String stationName;
  final int stationNumber;
  final String description;
  final String branch;
  final String exercise;
  final int v;

  Station({
    this.id = '',
    this.stationName = '',
    this.stationNumber = 0,
    this.description = '',
    this.branch = '',
    this.exercise = '',
    this.v = 0,
  });

  factory Station.fromJson(Map<String, dynamic> json) => Station(
    id: json['_id'] ?? '',
    stationName: json['stationName'] ?? '',
    stationNumber: json['stationNumber'] ?? 0,
    description: json['description'] ?? '',
    branch: json['branch'] ?? '',
    exercise: json['exercise'] ?? '',
    v: json['__v'] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    '_id': id,
    'stationName': stationName,
    'stationNumber': stationNumber,
    'description': description,
    'branch': branch,
    'exercise': exercise,
    '__v': v,
  };
}

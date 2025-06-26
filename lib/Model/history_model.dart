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
  final List<String> stations;
  final String exerciseName;
  final String exerciseImage;
  final List<SetModel> sets;
  final List<MuscleGroup> muscleGroups;
  final List<WorkoutType> workoutTypes;
  final String completedAt;

  HistoryAttribute({
    this.stations = const [],
    this.exerciseName = '',
    this.exerciseImage = '',
    this.sets = const [],
    this.muscleGroups = const [],
    this.workoutTypes = const [],
    this.completedAt = '',
  });

  factory HistoryAttribute.fromJson(Map<String, dynamic> json) =>
      HistoryAttribute(
        stations: List<String>.from(json['stations'] ?? []),
        exerciseName: json['exerciseName'] ?? '',
        exerciseImage: json['exerciseImage'] ?? '',
        sets: json['sets'] != null
            ? List<SetModel>.from(
            json['sets'].map((x) => SetModel.fromJson(x)))
            : [],
        muscleGroups: json['muscleGroups'] != null
            ? List<MuscleGroup>.from(
            json['muscleGroups'].map((x) => MuscleGroup.fromJson(x)))
            : [],
        workoutTypes: json['workoutTypes'] != null
            ? List<WorkoutType>.from(
            json['workoutTypes'].map((x) => WorkoutType.fromJson(x)))
            : [],
        completedAt: json['completedAt'] ?? '',
      );

  Map<String, dynamic> toJson() => {
    'stations': stations,
    'exerciseName': exerciseName,
    'exerciseImage': exerciseImage,
    'sets': sets.map((x) => x.toJson()).toList(),
    'muscleGroups': muscleGroups.map((x) => x.toJson()).toList(),
    'workoutTypes': workoutTypes.map((x) => x.toJson()).toList(),
    'completedAt': completedAt,
  };
}

class SetModel {
  final String name;
  final List<Measurement> measurements;

  SetModel({
    this.name = '',
    this.measurements = const [],
  });

  factory SetModel.fromJson(Map<String, dynamic> json) => SetModel(
    name: json['name'] ?? '',
    measurements: json['measurements'] != null
        ? List<Measurement>.from(
        json['measurements'].map((x) => Measurement.fromJson(x)))
        : [],
  );

  Map<String, dynamic> toJson() => {
    'name': name,
    'measurements': measurements.map((x) => x.toJson()).toList(),
  };
}

class Measurement {
  final String name;
  final String value;
  final String? id;

  Measurement({
    this.name = '',
    this.value = '',
    this.id,
  });

  factory Measurement.fromJson(Map<String, dynamic> json) {
    return Measurement(
      name: json['name'] ?? '',
      value: json['value']?.toString() ?? '',
      id: json['_id'],
    );
  }

  Map<String, dynamic> toJson() => {
    'name': name,
    'value': value,
    if (id != null) '_id': id,
  };
}


class WorkoutType {
  final String name;
  final String image;
  final String? id;

  WorkoutType({
    this.name = '',
    this.image = '',
    this.id,
  });

  factory WorkoutType.fromJson(Map<String, dynamic> json) => WorkoutType(
    name: json['name'] ?? '',
    image: json['image'] ?? '',
    id: json['_id'],
  );

  Map<String, dynamic> toJson() => {
    'name': name,
    'image': image,
    if (id != null) '_id': id,
  };
}

class MuscleGroup {
  final String name;
  final String image;
  final String? id;

  MuscleGroup({
    this.name = '',
    this.image = '',
    this.id,
  });

  factory MuscleGroup.fromJson(Map<String, dynamic> json) => MuscleGroup(
    name: json['name'] ?? '',
    image: json['image'] ?? '',
    id: json['_id'],
  );

  Map<String, dynamic> toJson() => {
    'name': name,
    'image': image,
    if (id != null) '_id': id,
  };
}

class SpecificWorkoutModel {
  final String id;
  final String name;
  final String exerciseImage;
  final String exerciseVideo;
  final String description;
  final String instructions;
  final Equipment equipment;
  final List<MuscleGroup> muscleGroup;
  final List<Measurement> measurement;
  final List<WorkoutType> workoutType;
  final List<Station> station;

  SpecificWorkoutModel({
    required this.id,
    required this.name,
    required this.exerciseImage,
    required this.exerciseVideo,
    required this.description,
    required this.instructions,
    required this.equipment,
    required this.muscleGroup,
    required this.measurement,
    required this.workoutType,
    required this.station,
  });

  factory SpecificWorkoutModel.fromJson(Map<String, dynamic> json) {
    return SpecificWorkoutModel(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      exerciseImage: json['exerciseImage'] ?? '',
      exerciseVideo: json['exerciseVideo'] ?? '',
      description: json['description'] ?? '',
      instructions: json['instructions'] ?? '',
      equipment: Equipment.fromJson(json['equipment'] ?? {}),
      muscleGroup: (json['muscleGroup'] as List<dynamic>?)
          ?.map((e) => MuscleGroup.fromJson(e))
          .toList() ??
          [],
      measurement: (json['measurement'] as List<dynamic>?)
          ?.map((e) => Measurement.fromJson(e))
          .toList() ??
          [],
      workoutType: (json['workoutType'] as List<dynamic>?)
          ?.map((e) => WorkoutType.fromJson(e))
          .toList() ??
          [],
      station: (json['station'] as List<dynamic>?)
          ?.map((e) => Station.fromJson(e))
          .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'exerciseImage': exerciseImage,
      'exerciseVideo': exerciseVideo,
      'description': description,
      'instructions': instructions,
      'equipment': equipment.toJson(),
      'muscleGroup': muscleGroup.map((e) => e.toJson()).toList(),
      'measurement': measurement.map((e) => e.toJson()).toList(),
      'workoutType': workoutType.map((e) => e.toJson()).toList(),
      'station': station.map((e) => e.toJson()).toList(),
    };
  }
}

class Equipment {
  final String id;
  final String equipmentName;

  Equipment({
    required this.id,
    required this.equipmentName,
  });

  factory Equipment.fromJson(Map<String, dynamic> json) {
    return Equipment(
      id: json['_id'] ?? '',
      equipmentName: json['equipmentName'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'equipmentName': equipmentName,
    };
  }
}

class MuscleGroup {
  final String id;
  final String mgName;

  MuscleGroup({
    required this.id,
    required this.mgName,
  });

  factory MuscleGroup.fromJson(Map<String, dynamic> json) {
    return MuscleGroup(
      id: json['_id'] ?? '',
      mgName: json['mgName'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'mgName': mgName,
    };
  }
}

class Measurement {
  final String id;
  final String name;
  final int unit;

  Measurement({
    required this.id,
    required this.name,
    required this.unit,
  });

  factory Measurement.fromJson(Map<String, dynamic> json) {
    return Measurement(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      unit: json['unit'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'unit': unit,
    };
  }
}

class WorkoutType {
  final String id;
  final String name;

  WorkoutType({
    required this.id,
    required this.name,
  });

  factory WorkoutType.fromJson(Map<String, dynamic> json) {
    return WorkoutType(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
    };
  }
}

class Station {
  final String id;
  final String stationName;
  final int stationNumber;

  Station({
    required this.id,
    required this.stationName,
    required this.stationNumber,
  });

  factory Station.fromJson(Map<String, dynamic> json) {
    return Station(
      id: json['_id'] ?? '',
      stationName: json['stationName'] ?? '',
      stationNumber: json['stationNumber'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'stationName': stationName,
      'stationNumber': stationNumber,
    };
  }
}
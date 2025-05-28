class WorkoutProgress {
  final String status;
  final int statusCode;
  final String message;
  final WorkoutProgressData data;
  final List<dynamic> errors;

  WorkoutProgress({
    required this.status,
    required this.statusCode,
    required this.message,
    required this.data,
    required this.errors,
  });

  factory WorkoutProgress.fromJson(Map<String, dynamic> json) {
    return WorkoutProgress(
      status: json['status']?.toString() ?? '',
      statusCode: json['statusCode'] ?? 0,
      message: json['message']?.toString() ?? '',
      data: json['data'] != null
          ? WorkoutProgressData.fromJson(json['data'] as Map<String, dynamic>)
          : throw Exception('Missing data field'),
      errors: json['errors'] ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'statusCode': statusCode,
      'message': message,
      'data': data.toJson(),
      'errors': errors,
    };
  }
}

class WorkoutProgressData {
  final String type;
  final WorkoutProgressAttributes attributes;

  WorkoutProgressData({
    required this.type,
    required this.attributes,
  });

  factory WorkoutProgressData.fromJson(Map<String, dynamic> json) {
    return WorkoutProgressData(
      type: json['type']?.toString() ?? '',
      attributes: json['attributes'] != null
          ? WorkoutProgressAttributes.fromJson(json['attributes'] as Map<String, dynamic>)
          : throw Exception('Missing attributes field'),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'attributes': attributes.toJson(),
    };
  }
}

class WorkoutProgressAttributes {
  final List<WorkoutProgressResult> result;
  final int totalWorkout;

  WorkoutProgressAttributes({
    required this.result,
    required this.totalWorkout,
  });

  factory WorkoutProgressAttributes.fromJson(Map<String, dynamic> json) {
    return WorkoutProgressAttributes(
      result: (json['result'] as List<dynamic>?)
          ?.map((e) => WorkoutProgressResult.fromJson(e as Map<String, dynamic>))
          .toList() ??
          [],
      totalWorkout: json['totalWorkout'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'result': result.map((e) => e.toJson()).toList(),
      'totalWorkout': totalWorkout,
    };
  }
}

class WorkoutProgressResult {
  final String day;
  final int count;

  WorkoutProgressResult({
    required this.day,
    required this.count,
  });

  factory WorkoutProgressResult.fromJson(Map<String, dynamic> json) {
    return WorkoutProgressResult(
      day: json['day']?.toString() ?? '',
      count: json['count'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'day': day,
      'count': count,
    };
  }
}

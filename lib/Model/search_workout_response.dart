class SearchWorkoutResponse {
  final String status;
  final int statusCode;
  final String message;
  final List<ExerciseModel> exercises;

  SearchWorkoutResponse({
    required this.status,
    required this.statusCode,
    required this.message,
    required this.exercises,
  });

  factory SearchWorkoutResponse.fromJson(Map<String, dynamic> json) {
    return SearchWorkoutResponse(
      status: json['status'] ?? '',
      statusCode: json['statusCode'] ?? 0,
      message: json['message'] ?? '',
      exercises: json['data'] != null && json['data']['exercises'] != null
          ? List<ExerciseModel>.from(
          json['data']['exercises'].map((x) => ExerciseModel.fromJson(x)))
          : [],
    );
  }
}

class ExerciseModel {
  final String id;
  final String name;
  final String exerciseImage;
  final String exerciseVideo;
  final String description;

  ExerciseModel({
    required this.id,
    required this.name,
    required this.exerciseImage,
    required this.exerciseVideo,
    required this.description,
  });

  factory ExerciseModel.fromJson(Map<String, dynamic> json) => ExerciseModel(
    id: json["_id"] ?? '',
    name: json["name"] ?? '',
    exerciseImage: json["exerciseImage"] ?? '',
    exerciseVideo: json["exerciseVideo"] ?? '',
    description: json["description"] ?? '',
  );
}

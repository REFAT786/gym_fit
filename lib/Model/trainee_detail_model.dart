class TraineeDetailModel {
  UserDetails userDetails;
  TraineeDetails traineeDetails;
  int totalWorkout;
  List<Workout> workout;

  TraineeDetailModel({
    UserDetails? userDetails,
    TraineeDetails? traineeDetails,
    int? totalWorkout,
    List<Workout>? workout,
  })  : userDetails = userDetails ?? UserDetails(),
        traineeDetails = traineeDetails ?? TraineeDetails(),
        totalWorkout = totalWorkout ?? 0,
        workout = workout ?? [];

  factory TraineeDetailModel.fromJson(Map<String, dynamic> json) {
    return TraineeDetailModel(
      userDetails: json['userDetails'] != null
          ? UserDetails.fromJson(json['userDetails'])
          : UserDetails(),
      traineeDetails: json['traineeDetails'] != null
          ? TraineeDetails.fromJson(json['traineeDetails'])
          : TraineeDetails(),
      totalWorkout: (json['totalWorkout'] is int) ? json['totalWorkout'] : 0,
      workout: (json['workout'] is List)
          ? (json['workout'] as List).map((e) => Workout.fromJson(e)).toList()
          : [],
    );
  }
}

class UserDetails {
  String id;
  String fullName;
  String userName;
  String email;
  String image;
  bool isBanned;
  String createdAt;
  String gym;
  String gymLocation;
  String gymId;
  String branchLocation;
  String branchId;
  String branchName;

  UserDetails({
    this.id = '',
    this.fullName = '',
    this.userName = '',
    this.email = '',
    this.image = '',
    this.isBanned = false,
    this.createdAt = '',
    this.gym = '',
    this.gymLocation = '',
    this.gymId = '',
    this.branchLocation = '',
    this.branchId = '',
    this.branchName = '',
  });

  factory UserDetails.fromJson(Map<String, dynamic> json) {
    return UserDetails(
      id: json['_id'] ?? '',
      fullName: json['fullName'] ?? '',
      userName: json['userName'] ?? '',
      email: json['email'] ?? '',
      image: json['image'] ?? '',
      isBanned: json['isBanned'] ?? false,
      createdAt: json['createdAt'] ?? '',
      gym: json['gym'] ?? '',
      gymLocation: json['gymLocation'] ?? '',
      gymId: json['gymId'] ?? '',
      branchLocation: json['branchLocation'] ?? '',
      branchId: json['branchId'] ?? '',
      branchName: json['branchName'] ?? '',
    );
  }
}

class TraineeDetails {
  String id;
  int workoutCompleted;
  Trainer trainer;
  String user;
  int age;
  double bmi;
  String gender;
  String height;
  String weight;

  TraineeDetails({
    this.id = '',
    this.workoutCompleted = 0,
    Trainer? trainer,
    this.user = '',
    this.age = 0,
    this.bmi = 0.0,
    this.gender = '',
    this.height = '',
    this.weight = '',
  }) : trainer = trainer ?? Trainer();

  factory TraineeDetails.fromJson(Map<String, dynamic> json) {
    return TraineeDetails(
      id: json['_id'] ?? '',
      workoutCompleted: json['workoutCompleted'] ?? 0,
      trainer: json['trainer'] != null ? Trainer.fromJson(json['trainer']) : Trainer(),
      user: json['user'] ?? '',
      age: json['age'] ?? 0,
      bmi: (json['bmi'] != null) ? (json['bmi'] as num).toDouble() : 0.0,
      gender: json['gender'] ?? '',
      height: json['height'] ?? '',
      weight: json['weight'] ?? '',
    );
  }
}

class Trainer {
  String id;
  String fullName;
  String image;

  Trainer({
    this.id = '',
    this.fullName = '',
    this.image = '',
  });

  factory Trainer.fromJson(Map<String, dynamic> json) {
    return Trainer(
      id: json['_id'] ?? '',
      fullName: json['fullName'] ?? '',
      image: json['image'] ?? '',
    );
  }
}

class Workout {
  String id;
  List<Measurement> measurement;
  String exerciseName;
  String exerciseId;
  String exerciseImage;
  String exerciseVideo;
  String stationName;
  int stationNumber;

  Workout({
    this.id = '',
    List<Measurement>? measurement,
    this.exerciseName = '',
    this.exerciseId = '',
    this.exerciseImage = '',
    this.exerciseVideo = '',
    this.stationName = '',
    this.stationNumber = 0,
  }) : measurement = measurement ?? [];

  factory Workout.fromJson(Map<String, dynamic> json) {
    return Workout(
      id: json['_id'] ?? '',
      measurement: (json['measurement'] is List)
          ? (json['measurement'] as List).map((e) => Measurement.fromJson(e)).toList()
          : [],
      exerciseName: json['exerciseName'] ?? '',
      exerciseId: json['exerciseId'] ?? '',
      exerciseImage: json['exerciseImage'] ?? '',
      exerciseVideo: json['exerciseVideo'] ?? '',
      stationName: json['stationName'] ?? '',
      stationNumber: json['stationNumber'] ?? 0,
    );
  }
}

class Measurement {
  String id;
  String name;
  String type;
  int unit;
  int defaultValue;
  bool isRequired;
  String createdAt;
  String updatedAt;

  Measurement({
    this.id = '',
    this.name = '',
    this.type = '',
    this.unit = 0,
    this.defaultValue = 0,
    this.isRequired = false,
    this.createdAt = '',
    this.updatedAt = '',
  });

  factory Measurement.fromJson(Map<String, dynamic> json) {
    return Measurement(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      type: json['type'] ?? '',
      unit: json['unit'] ?? 0,
      defaultValue: json['defaultValue'] ?? 0,
      isRequired: json['isRequired'] ?? false,
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
    );
  }
}

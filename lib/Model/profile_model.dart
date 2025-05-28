import '../Utils/app_url.dart';

class ProfileModel {
  final String id;
  final String fullName;
  final String userName;
  final String email;
  final String image;
  final String role;
  final String phoneNumber;
  final String countryCode;

  final String gender;
  final String height;
  final String weight;
  final num age ;
  final num bmi ;

  final bool isActive;
  final bool isCompleted;
  final bool isBanned;
  final String branch;
  final String createdAt;
  final String updatedAt;
  final String address;
  final String aboutme;

  ProfileModel({
    this.id = '',
    this.fullName = '',
    this.userName = '',
    this.email = '',
    this.phoneNumber = '',
    this.countryCode = '',
    this.gender = '',
    this.height = '',
    this.weight = '',
    this.age = 1,
    this.bmi = 1,
    String image = '',
    this.role = '',
    this.isActive = false,
    this.isCompleted = false,
    this.isBanned = false,
    this.branch = '',
    this.createdAt = '',
    this.updatedAt = '',
    this.address = '',
    this.aboutme = '',
  }) : image = image.startsWith('http') ? image : '${AppUrl.baseUrl}$image';

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      id: json['_id'] ?? '',
      fullName: json['fullName'] ?? '',
      userName: json['userName'] ?? '',
      email: json['email'] is String
          ? json['email']
          : (json['email']?['address'] ?? ''),
      image: json['image'] is String
          ? json['image']
          : (json['image']?['url'] ?? ''),
      role: json['role'] is String
          ? json['role']
          : (json['role']?['type'] ?? ''),
      phoneNumber: json['phoneNumber'] ?? '',
      countryCode: json['countryCode'] ?? '',
      gender: json['gender'] ?? '',
      height: json['height'] ?? '',
      weight: json['weight'] ?? '',
      age: json['age'] ?? 1,
      bmi: json['bmi'] ?? 1,
      isActive: json['isActive'] ?? false,
      isCompleted: json['isCompleted'] ?? false,
      isBanned: json['isBanned'] ?? false,
      branch: json['branch'] is String
          ? json['branch']
          : (json['branch']?['name'] ?? ''),
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
      address: json['address'] ?? '',
      aboutme: json['aboutme'] ?? '',
    );
  }
}
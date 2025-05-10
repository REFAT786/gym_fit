import '../Utils/app_url.dart';

class ProfileModel {
  final String id;
  final String fullName;
  final String userName;
  final String email;
  final String image;
  final String role;
  final bool isActive;
  final bool isCompleted;
  final bool isBanned;
  final String branch;
  final String createdAt;
  final String updatedAt;

  ProfileModel({
    this.id = '',
    this.fullName = '',
    this.userName = '',
    this.email = '',
    String image = '',
    this.role = '',
    this.isActive = false,
    this.isCompleted = false,
    this.isBanned = false,
    this.branch = '',
    this.createdAt = '',
    this.updatedAt = '',
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
      isActive: json['isActive'] ?? false,
      isCompleted: json['isCompleted'] ?? false,
      isBanned: json['isBanned'] ?? false,
      branch: json['branch'] is String
          ? json['branch']
          : (json['branch']?['name'] ?? ''),
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
    );
  }


}
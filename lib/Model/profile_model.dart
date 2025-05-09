import '../Utils/app_url.dart';

class ProfileModel {
  final String id;
  final String fullName;
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
      email: json['email'] ?? '',
      image: json['image'] ?? '',
      role: json['role'] ?? '',
      isActive: json['isActive'] ?? false,
      isCompleted: json['isCompleted'] ?? false,
      isBanned: json['isBanned'] ?? false,
      branch: json['branch'] ?? '',
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
    );
  }
}
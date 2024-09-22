class UserModel {
  String? token;
  User? user;
  String? message;

  UserModel({this.token, this.user, this.message});

  UserModel.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['token'] = token;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    data['message'] = message;
    return data;
  }
}

class User {
  int? id;
  String? name;
  String? email;
  String? number;
  String? userType;
  int? std;
  String? school;
  String? subject;
  dynamic emailVerifiedAt; // Can be either null or DateTime
  int? isVerified;
  int? isNumberVerified;
  dynamic otp; // Can be null
  String? createdAt;
  String? updatedAt;
  dynamic deletedAt; // Can be null

  User({
    this.id,
    this.name,
    this.email,
    this.number,
    this.userType,
    this.std,
    this.school,
    this.subject,
    this.emailVerifiedAt,
    this.isVerified,
    this.isNumberVerified,
    this.otp,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  // Modify the fromJson method to handle the 'user' key
  User.fromJson(Map<String, dynamic> json) {
    var userData = json['user']; // Access the nested 'user' key
    id = userData['id'];
    name = userData['name'];
    email = userData['email'];
    number = userData['number'];
    userType = userData['user_type'];
    std = userData['std'];
    school = userData['school'];
    subject = userData['subject'];
    emailVerifiedAt = userData['email_verified_at'];
    isVerified = userData['is_verified'];
    isNumberVerified = userData['is_number_verified'];
    otp = userData['otp'];
    createdAt = userData['created_at'];
    updatedAt = userData['updated_at'];
    deletedAt = userData['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['number'] = number;
    data['user_type'] = userType;
    data['std'] = std;
    data['school'] = school;
    data['subject'] = subject;
    data['email_verified_at'] = emailVerifiedAt;
    data['is_verified'] = isVerified;
    data['is_number_verified'] = isNumberVerified;
    data['otp'] = otp;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    return data;
  }
}

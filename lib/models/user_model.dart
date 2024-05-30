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
  Null emailVerifiedAt;
  int? isVerified;
  int? isNumberVerified;
  int? otp;
  String? createdAt;
  String? updatedAt;
  Null deletedAt;

  User(
      {this.id,
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
      this.deletedAt});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    number = json['number'];
    userType = json['user_type'];
    std = json['std'];
    school = json['school'];
    subject = json['subject'];
    emailVerifiedAt = json['email_verified_at'];
    isVerified = json['is_verified'];
    isNumberVerified = json['is_number_verified'];
    otp = json['otp'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
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

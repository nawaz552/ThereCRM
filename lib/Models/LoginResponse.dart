
import 'package:CRM_APP/Models/Error.dart';

class LoginResponse extends ErrorResponse{
  List<User> data;

  LoginResponse({code, message, this.data}):super(code : code ,message : message);

  LoginResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    if (json['data'] != null) {
      data = new List<User>();
      json['data'].forEach((v) {
        data.add(new User.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}


class User {
  bool isNewUser;
  String otp;
  String userName;
  String email;
  String mobile;
  int userId ;
  String profileImage ;


  User({this.isNewUser, this.otp, this.userName, this.email, this.mobile , this.userId, this.profileImage});

  User.fromJson(Map<String, dynamic> json) {
    isNewUser = json['is_new_user'];
    otp = json['otp'];
    userName = json['user_name'];
    email = json['email'];
    mobile = json['mobile'];
    userId = json['user_id'];
    profileImage = json['profile_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['is_new_user'] = this.isNewUser;
    data['otp'] = this.otp;
    data['user_name'] = this.userName;
    data['email'] = this.email;
    data['mobile'] = this.mobile;
    data['user_id'] = this.userId;
    data['profile_image'] = this.profileImage ;
    return data;
  }
}
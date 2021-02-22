
class LoginResponse {

  String access_token;
  String token_type;
  String expires_in;
  String userName;
  String ID;
  String Code;
  String issued;
  String expires;

  LoginResponse({this.access_token,this.token_type,this.expires,this.userName,this.ID,this.Code,this.issued});


  factory LoginResponse.fromJson(Map<String, String> json){
    return LoginResponse(
      access_token : json['access_token'] as String ,
      token_type: json['token_type'] as String,
      expires : json['expires'] as String ,
      userName: json['userName'] as String,
      ID : json['ID'] as String ,
      Code: json['Code'] as String,
     issued : json['issued'] as String ,
    

    );
  }

  static Map<String, String> toJson(LoginResponse loginresponse) {
    return <String , String>{
       'access_token' : loginresponse.access_token,
      'token_type' : loginresponse.token_type,
     'expires' : loginresponse.expires,
    'userName' : loginresponse.userName,
     'ID' : loginresponse.ID,
    'Code' : loginresponse.Code,
     'issued' : loginresponse.issued,
    };
  }
}





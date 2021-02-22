// import 'package:CRM_APP/Models/LoginResponse.dart';

// class UserSession{

//   static final _userDetails = UserSession._internal();
//   String accessToken = "4JjXxl2RFf6t08NnbHVDcrKYy";
//   String userEmail ;
//   String mobileNo ;
//   String userName ;
//   bool isLoggedIn ;
//   int userId ;
//   String lat ;
//   String long ;
//   String profileImage ;

  


   

//   factory UserSession(){
//     return _userDetails;
//   }

//   UserSession._internal(){
//      isLoggedIn = false ;
    
//   }


//   void intialize(User userData){
//     if(userData == null) return ;
//     try{
//       userName = userData.userName;
//       userEmail = userData.email;
//       mobileNo = userData.mobile ;
//       userId = userData.userId;
//       profileImage = userData.profileImage ;
//       isLoggedIn = true ;
//       lat = UserSession().lat ;
//       long = UserSession().long ;
//     }catch(Exception){
//       print("${Exception.toString()}");
//     }
//   }


//    Map<String, dynamic> toJson() {
//     return <String , dynamic>{
//       'accessToken' : this.accessToken,
//       'userEmail' : this.userEmail,
//       'userName' : this.userName,
//       'mobileNo' : this.mobileNo,
//       'isLoggedIn' : this.isLoggedIn,
//       "userId" : this.userId ,
//       "lat" : this.lat,
//       "long" : this.long,
//       "profileImage" : this.profileImage
//     };
//   }
// }
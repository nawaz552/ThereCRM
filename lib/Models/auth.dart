
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/cupertino.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
class Auth with ChangeNotifier {
  
  Map jsonResponce;
  Future signup(String username,String password) async {
  
   const url = 'https://mobileapi.therecrm.com/Login';
  final responseData = await  http.post(
    url,
       headers: {
      "Content-Type": "application/x-www-form-urlencoded"
    },
    body: 
      {
      "grant_type":"password",
      "Username":username,
      "Password":password
      
      },
      );
      print(responseData.statusCode);
      if(responseData.statusCode == 200) {
 var getData = responseData.body;
      jsonResponce = jsonDecode(getData);

      
      // if(data['code'] == 200) {
      //   result = data;
      // }
      return jsonResponce;
         
      }
      else {
        var jsonResponce = {
    
    "password": "InCorrect",
  
  };
  
  return jsonResponce;
      }
     
     
  }

}
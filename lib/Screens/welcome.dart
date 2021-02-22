
import 'dart:convert';

import 'package:CRM_APP/Screens/Dashboard.dart';
import 'package:CRM_APP/Screens/login.dart';
import 'package:CRM_APP/Screens/sizeconfig.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<WelcomeScreen> {
  Map<String,dynamic> decodedMap;
  @override
  void initState() {

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
      Future.delayed(Duration(seconds: 2),(){
      _redirect(context);
    });
    SizeConfig().init(context);
    return new Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            
            decoration: BoxDecoration(color: Color(0xFF737373)),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children:<Widget>[
            Expanded(
              flex: 3,
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircleAvatar(
                        backgroundImage: AssetImage("assets/images/crmlogo.png"),
                 backgroundColor: Colors.white,
                radius: 90.0,
                
                    ),
                    Padding(padding: EdgeInsets.only(top:30.0)),
                    Text(
                      "THERECRM",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold
                      ),
                      )
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircularProgressIndicator(
                    valueColor: new AlwaysStoppedAnimation<Color>(Color(0xFFffde59)),
                   ),
                  Padding(padding: EdgeInsets.only(top:20.0)),
                  Text("Sell Your Property Faster",
                  style: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.bold),)
                ],
              )
              )
            ]
          )
        ],
      ),
    );
  }
  _redirect(BuildContext context) async{
 
       SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
              String encodedMap = sharedPreferences.getString('timeData');
            if(encodedMap != null) {
                decodedMap = json.decode(encodedMap);
print(decodedMap);
            }
               Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => encodedMap == null ? LoginScreen() : ActivePage(jsondata:decodedMap)));  
      var f = DateFormat('E, d MMM yyyy HH:mm:ss');
  var date = f.format(DateTime.now().toUtc()) + " GMT";
  print(date);
            print(decodedMap['.expires']);

String expiredate =  f.format(decodedMap['.expires']);
            print(expiredate);
          if(decodedMap['.expires'].isAtSameMomentAs(date)) {
                     Navigator.push(
                      context, MaterialPageRoute(
                        builder: (context) {
                         
                          return LoginScreen();
                        }
                        ));
          }
          else {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => encodedMap == null ? LoginScreen() : ActivePage(jsondata:decodedMap)));  
          }
            // if(decodedMap['.expires'].compareTo(date) > 0)   {
            //       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => encodedMap == null ? LoginScreen() : ActivePage(jsondata:decodedMap)));  
            // }
            // else {
          
            //     }
               
       
      

  }
}
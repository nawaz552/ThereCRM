
import 'dart:convert';

import 'package:CRM_APP/Components/CustomSurffixIcon.dart';
import 'package:CRM_APP/Components/button.dart';
import 'package:CRM_APP/Components/constants.dart';
import 'package:CRM_APP/Components/customtoast.dart';
import 'package:CRM_APP/Components/error.dart';
import 'package:CRM_APP/Models/Error.dart';
import 'package:CRM_APP/Screens/Dashboard.dart';
import 'package:CRM_APP/Screens/login.dart';
import 'package:CRM_APP/Widgets/dialog.dart';
import 'package:connectivity/connectivity.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Screens/sizeconfig.dart';
import '../Models/auth.dart';
class SignForm extends StatefulWidget {
  @override
  _SignFormState createState() => _SignFormState();
}

class _SignFormState extends State<SignForm> {
  final _formKey = GlobalKey<FormState>();
  String email;
  String password;
  bool _isLoading = false;
  final _passwordnode = FocusNode();
  List results;  
  
  void dispose() {
    _passwordnode.dispose();
    super.dispose();
  }
  
  // bool remember = false;
   getData(username,password) async {
     var connectivityResult = await (Connectivity().checkConnectivity());
     if (connectivityResult != ConnectivityResult.none) {
  Auth auth = Auth();
    Map data = await auth.signup(username, password);
    print(data);
    return data;
     }
     else {
      
        print("------- No internet connection , we are offline -------------");
        Dialogs.showErrorDialog("No Internet Connection", context);
          FirebaseCrashlytics.instance.log(
              "Either Username=$username and Password=$password is Incorrect");
        
                      //  Navigator.push(
                      // context, MaterialPageRoute(
                      //   builder: (context) {
                         
                      //     return LoginScreen();
                      //   }
                      //   ));
 
     }
  
 }
  final List<String> errors = [];

  void addError({String error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error);
      });
  }

  void removeError({String error}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,

      
      child:_isLoading ? Center(
        child: CircularProgressIndicator(),
      ) :Column(
        children: [
          buildEmailFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildPasswordFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
       
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(20)),
          DefaultButton(
            text: "Login",
            press: ()  async{
              
              if (_formKey.currentState.validate()) {
                _formKey.currentState.save();
                setState(() {
                  _isLoading=true;
                });
                 Map res =  await getData(email,password);
               
               
                  if(res['password'] == "InCorrect") {
                    Toast.show("Username or Password is incorrect!", context, Toast.top);
                   Navigator.push(context, MaterialPageRoute(builder:(context) {
                    return LoginScreen();
                   } ));
                }
                 if(res['Code'] == "200") {
                   SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
              String encodedMap = json.encode(res);
              sharedPreferences.setString('timeData', encodedMap);
                    Navigator.push(
                      context, MaterialPageRoute(
                        builder: (context) {
                          print(res['Code']);
                          return ActivePage(jsondata: res);
                        }
                        ));
                 }
                 else if (res['Code'] == "201") {
                    Toast.show("Provided username or password is incorrect", context, Toast.top);
                   Navigator.push(context, MaterialPageRoute(builder:(context) {
                    return LoginScreen();
                   } ));
                 }
                 else if (res['Code'] == 202) {
                     Toast.show("Authorization has been denied for this request", context, Toast.top);
                   Navigator.push(context, MaterialPageRoute(builder:(context) {
                    return LoginScreen();
                   } ));
               
                 }
                
       }
            },
          ),
        ],
      ),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      obscureText: true,
      onSaved: (newValue) => password = newValue,
      focusNode: _passwordnode,
      onChanged: (value) {
        password = value;
        if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        }
        //  else if (value.length >= 8) {
        //   removeError(error: kShortPassError);
        // }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kPassNullError);
          return "";
        } 
        // else if (value.length < 8) {
        //   addError(error: kShortPassError);
        //   return "";
        // }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Password",
        hintText: "Password",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
      ),
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => email = newValue,
      onFieldSubmitted: (_) {
        FocusScope.of(context).requestFocus(_passwordnode);
      },
      onChanged: (value) {
        email = value;
        if (value.isNotEmpty) {
          removeError(error: kEmailNullError);
        // } else if (emailValidatorRegExp.hasMatch(value)) {
        //   removeError(error: kInvalidEmailError);
        // }
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kEmailNullError);
          return "";
        }
        //  else if (!emailValidatorRegExp.hasMatch(value)) {
        //  addError(error: kInvalidEmailError);
        //   return "";
        // }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Username",
        hintText: "Username",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
      ),
    );
  }
}
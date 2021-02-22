import 'dart:convert';
import 'dart:ui';
import 'package:CRM_APP/Screens/login.dart';
import 'package:CRM_APP/Widgets/CustomCardShapePainter.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import '../Components/customtoast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
class TenantList extends StatefulWidget {
  Map resdata;
  TenantList({Key key,this.resdata}) : super(key: key);
  @override
  _TenantListState createState() => _TenantListState();
}

class _TenantListState extends State<TenantList> {
  // int uID;
  Map resdata;
  Future data;
 
  @override
  void initState() {
    super.initState();


  }

   Future getLeadData(resdata) async {
     
      var id = resdata['ID'];
    
      // var tokentype = resdata['token_type'];
      var accesstoken = resdata['access_token'];
       var value = 'bearer ' + accesstoken;
   
      // headers: {"Authorization": "Some token"}
       var url = 'https://mobileapi.therecrm.com/api/TenantList/?uID=$id';
     

      
          http.Response response = await http.get(url, headers: {
      // 'Content-Type': 'application/json',
      // 'Accept': 'application/json',
      'Authorization': '$value',
    });
     
    
         if (response.statusCode == 200) {
                     String data = response.body;
                    
                     var resultData =jsonDecode(data)['data'];
                   
                     return resultData;


                     } else {
                         Toast.show("Something went wrong", context, Toast.top);
                        FirebaseCrashlytics.instance
          .setCustomKey('TenantList', "API Failed to Load Response_Value");
      FirebaseCrashlytics.instance
          .log("Api Calling method is failed for Tenantlist");
                       Navigator.push(
                      context, MaterialPageRoute(
                        builder: (context) {
                         
                          return LoginScreen();
                        }
                        ));
                     }
    }

  Widget build(BuildContext context) {
      resdata = Provider.of<Map>(context);
   
    data = getLeadData(resdata);
    return Scaffold(

       body:
                           FutureBuilder(
                             future: getLeadData(resdata),
                             builder: (
                               context,
                               AsyncSnapshot snapshot) {
                                 if(snapshot.hasData) {
                                
                     return createListView(snapshot.data,context);
                                  }
                             return Center(child: CircularProgressIndicator());
                            })
                         );



  }
}

Widget createListView(List data, BuildContext context) {
return Container(
child: data.isEmpty
? Center(
child: Column(children: <Widget>[
Text(
'No Active List added yet!',
style: TextStyle(fontSize: 16.0),
),
SizedBox(height: 10.0),
Container(
color: Colors.grey,
height: 200,
child: Image.asset('assets/images/waiting.png'))
]),
)
: ListView.builder(
itemCount: data.length,
itemBuilder: (context, index) {
String datenow = (data[index]['DueDate'].toString());
DateTime _datenow = DateTime.parse(datenow);
String statusDate = new DateFormat.yMMMd().format(_datenow);
var value1 = data[index]['RentAmount'].toString();
var rentamount =
double.tryParse(value1).toString().substring(0, 4);
var value2 = data[index]['PaidRentAmount'].toString();
var rentamount2 =
double.tryParse(value2).toString().substring(0, 4);
return Center(
child: Padding(
padding: const EdgeInsets.all(5.0),
child: Stack(
children: <Widget>[
Container(
height: 130,
decoration: BoxDecoration(
borderRadius: BorderRadius.circular(20.0),
gradient: LinearGradient(
colors: [Color(0xffffde59), Color(0xffffde59)],
begin: Alignment.topLeft,
end: Alignment.bottomRight),
boxShadow: [
BoxShadow(
color: Color(0xfffff),
blurRadius: 12,
offset: Offset(0, 6),
),
],
),
),
Positioned(
right: 0,
bottom: 0,
top: 0,
child: CustomPaint(
size: Size(100, 140),
painter: CustomCardShapePainter(
22.0, Color(0xff737373), Color(0xff737373)),
),
),
Positioned.fill(
child: Row(
children: <Widget>[
Expanded(
child: SvgPicture.asset(
"assets/icons/User.svg",
height: 24,
width: 24,
),
flex: 2,
),
Expanded(
flex: 4,
child: Column(
mainAxisAlignment: MainAxisAlignment.start,
mainAxisSize: MainAxisSize.min,
crossAxisAlignment: CrossAxisAlignment.start,
children: <Widget>[
SizedBox(height: 8),
Text(
"${data[index]['Name'].toString()}",
style: TextStyle(
color: Colors.black,
fontSize: 17.0,
fontFamily: 'Avenir',
fontWeight: FontWeight.w900),
),
SizedBox(height: 6),
Row(
children: <Widget>[
Icon(
Icons.apartment_outlined,
color: Colors.black,
size: 18,
),
SizedBox(
width: 8,
),
Flexible(
child: Text(
"${data[index]['PropertyName'].toString()}",
style: TextStyle(
color: Colors.black,
fontSize: 14,
fontFamily: 'Avenir',
fontWeight: FontWeight.w700,
),
),
),
],
),
Row(
mainAxisAlignment: MainAxisAlignment.start,
children: <Widget>[
IconButton(
iconSize: 18,
alignment: Alignment.centerLeft,
color: Colors.black,
tooltip: "Call",
icon: Icon(Icons.call_sharp),
onPressed: () =>
FlutterPhoneDirectCaller.callNumber(
"${data[index]['MobileNo'].toString()}"),
),
SizedBox(
width: 8,
),
Text(
"$statusDate",
textAlign: TextAlign.right,
style: TextStyle(
color: Colors.black,
fontSize: 14.0,
fontFamily: 'Avenir',
fontWeight: FontWeight.w700),
),
],
),
],
),
),
Expanded(
flex: 2,
child: Column(
mainAxisSize: MainAxisSize.min,
children: <Widget>[
Text(
data[index]['PaidRentAmount'] == null
? "0"
: "$rentamount2",
style: TextStyle(
color: Colors.white,
fontFamily: 'Avenir',
fontSize: 14,
fontWeight: FontWeight.w700),
),
//SizedBox(height: 8.0),
Text(
"-------",
style: TextStyle(
color: Colors.white,
fontFamily: 'Avenir',
fontSize: 14,
fontWeight: FontWeight.w700),
),
Text(
"$rentamount /-",
style: TextStyle(
color: Colors.white,
fontFamily: 'Avenir',
fontSize: 14,
fontWeight: FontWeight.w700),
),
],
),
),
],
),
),
],
),
),
);
},
),
);
}
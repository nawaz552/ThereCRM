
import 'package:CRM_APP/Screens/actTenantLead.dart';
import 'package:CRM_APP/Screens/login.dart';
import 'package:CRM_APP/Screens/sales.dart';
import 'package:CRM_APP/Screens/tenantlist.dart';
import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

// import 'package:App/Model/auth.dart';
class ActivePage extends StatefulWidget {
  
  Map jsondata;
  ActivePage({Key key,this.jsondata}) : super(key: key);

  @override
  _ActivePageState createState() => _ActivePageState();
}

class _ActivePageState extends State<ActivePage> {
  Map dashdata;
// int id;
// _ActivePageState(this.id);
  @override
  void initState() { 
    super.initState();
    print("second");
    dashdata = widget.jsondata;
  
   
  }

  

 

  int _currentIndex = 0;
  final List<Widget> _children = [
    SalesScreen(),
    RentScreen(),
    TenantList(),
  ];

  Future logout()  async{
     SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
              sharedPreferences.remove('timeData');
           
           Navigator.push(context,  MaterialPageRoute(
              builder: (context) {
                return LoginScreen();
              },
            ));
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
  
  Widget build(BuildContext context) {
     
    return 
         Provider<Map>(
            create: (context) => dashdata,
                    child: Scaffold(
        appBar: AppBar(
           backgroundColor: Colors.black,
             actions: <Widget>[
                IconButton(
      icon: Icon(
         Icons.power_settings_new,
        color: Colors.white,
      ),
      onPressed: () {
       logout();
      },
    )
            
            ],
            
        ),
        body: _children[_currentIndex],
    
    
  bottomNavigationBar: FancyBottomNavigation(
   
      initialSelection: 0,
      

      key: Key("Dashboard"),
      tabs: [
            TabData(
              iconData: Icons.loyalty, 
              title: "Sales",
              
            ),
              
                        
        TabData(iconData: Icons.account_balance_wallet, title: "Leasing"),
        TabData(iconData: Icons.people, title: "Tenants")
                            ],
              onTabChangedListener: (position) {
                              print(position);
                                setState(() {
                                 onTabTapped(position);
                                });
                            },
                        ),
                            

              
   
    ),
         );
  }
}



//Sales page




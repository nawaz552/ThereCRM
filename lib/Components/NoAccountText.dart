import 'package:CRM_APP/Components/constants.dart';
import 'package:CRM_APP/Screens/sizeconfig.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class NoAccountText extends StatelessWidget {
  const NoAccountText({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Don’t have an account? ",
          style: TextStyle(fontSize: getProportionateScreenWidth(16)),
        ),
        GestureDetector(
          onTap: () => _launchURL(),
          child: Text(
            "Sign Up",
            style: TextStyle(
                fontSize: getProportionateScreenWidth(16),
                color: Colors.black),
          ),
        ),
      ],
    );
  }
}
_launchURL() async {
  const url = 'https://therecrm.com/Signup';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

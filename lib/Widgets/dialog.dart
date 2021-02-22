import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


enum ActionStyle { normal, destructive, important, important_destructive }

class Dialogs {
  static Color _normal = Color(0xFF007BF9);
  static Color _destructive = Colors.red;

  /// show the OS Native dialog
  static showOSDialog(BuildContext context, String title, String message,
      String firstButtonText, Function firstCallBack,
      TextStyle contentTextStyle,
      {ActionStyle firstActionStyle = ActionStyle.normal,
      String secondButtonText,
      Function secondCallback,
      ActionStyle secondActionStyle = ActionStyle.normal}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        if (Platform.isIOS) {
          return _iosDialog(
              context, title, message, firstButtonText, firstCallBack, contentTextStyle,
              firstActionStyle: firstActionStyle,
              secondButtonText: secondButtonText,
              secondCallback: secondCallback,
              secondActionStyle: secondActionStyle);
        } else {
          return _androidDialog(
              context, title, message, firstButtonText, firstCallBack, contentTextStyle,
              firstActionStyle: firstActionStyle,
              secondButtonText: secondButtonText,
              secondCallback: secondCallback,
              secondActionStyle: secondActionStyle);
        }
      },
    );
  }

  /// show the android Native dialog
  static Widget _androidDialog(BuildContext context, String title,
      String message, String firstButtonText, Function firstCallBack,
      TextStyle contentTextStyle,
      {ActionStyle firstActionStyle = ActionStyle.normal,
      String secondButtonText,
      Function secondCallback,
      ActionStyle secondActionStyle = ActionStyle.normal}) {
    List<FlatButton> actions = [];
    actions.add(FlatButton(
      child: Text(
        firstButtonText,
        style: TextStyle(
            color: (firstActionStyle == ActionStyle.important_destructive ||
                    firstActionStyle == ActionStyle.destructive)
                ? _destructive
                : _normal,
            fontWeight:
                (firstActionStyle == ActionStyle.important_destructive ||
                        firstActionStyle == ActionStyle.important)
                    ? FontWeight.bold
                    : FontWeight.normal),
      ),
      onPressed: () {
        Navigator.of(context).pop();
        firstCallBack();
      },
    ));

    if (secondButtonText != null) {
      actions.add(FlatButton(
        child: Text(secondButtonText,
            style: TextStyle(
                color:
                    (secondActionStyle == ActionStyle.important_destructive ||
                            firstActionStyle == ActionStyle.destructive)
                        ? _destructive
                        : _normal)),
        onPressed: () {
          Navigator.of(context).pop();
          secondCallback();
        },
      ));
    }

    return AlertDialog(
        title: Text(title), content: Text(message, style: contentTextStyle), actions: actions);
  }

  /// show the iOS Native dialog
  static Widget _iosDialog(BuildContext context, String title, String message,
      String firstButtonText, Function firstCallback,
      TextStyle contentTextStyle,
      {ActionStyle firstActionStyle = ActionStyle.normal,
      String secondButtonText,
      Function secondCallback,
      ActionStyle secondActionStyle = ActionStyle.normal}) {
    List<CupertinoDialogAction> actions = [];
    actions.add(
      CupertinoDialogAction(
        isDefaultAction: true,
        onPressed: () {
          Navigator.of(context).pop();
          firstCallback();
        },
        child: Text(
          firstButtonText,
          style: TextStyle(
              color: (firstActionStyle == ActionStyle.important_destructive ||
                      firstActionStyle == ActionStyle.destructive)
                  ? _destructive
                  : _normal,
              fontWeight:
                  (firstActionStyle == ActionStyle.important_destructive ||
                          firstActionStyle == ActionStyle.important)
                      ? FontWeight.bold
                      : FontWeight.normal),
        ),
      ),
    );

    if (secondButtonText != null) {
      actions.add(
        CupertinoDialogAction(
          isDefaultAction: true,
          onPressed: () {
            Navigator.of(context).pop();
            secondCallback();
          },
          child: Text(
            secondButtonText,
            style: TextStyle(
                color:
                    (secondActionStyle == ActionStyle.important_destructive ||
                            secondActionStyle == ActionStyle.destructive)
                        ? _destructive
                        : _normal,
                fontWeight:
                    (secondActionStyle == ActionStyle.important_destructive ||
                            secondActionStyle == ActionStyle.important)
                        ? FontWeight.bold
                        : FontWeight.normal),
          ),
        ),
      );
    }

    return CupertinoAlertDialog(
      title: Text(title),
      content: Text(message, style: contentTextStyle),
      actions: actions,
    );
  }

  static showAlertDialog(String title ,String message , BuildContext context){
    Dialogs.showOSDialog(
        context,
        title,
        message,
        "Ok",
            () {},
        TextStyle(fontSize: 14),
        firstActionStyle: ActionStyle.normal,
        secondActionStyle: ActionStyle.normal,
        secondButtonText: null, secondCallback: () {

    });
  }

  static showErrorDialog(String errorMessage , BuildContext context ,{Function callback}){
    Dialogs.showOSDialog(
        context,
        "We are sorry",
        errorMessage,
        "Ok",
        callback ?? (){},
        TextStyle(fontSize: 14),
        firstActionStyle: ActionStyle.normal,
        secondActionStyle: ActionStyle.normal,
        secondButtonText: null, secondCallback: () {

    });
  }
}

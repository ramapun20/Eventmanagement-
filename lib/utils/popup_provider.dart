import 'package:flutter/material.dart';

class PopUpProvider {
  PopUpProvider._();

  static void showSnackBarMessage(BuildContext context, String message,
      {bool isError = true}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: isError ? Colors.red : Colors.green,
      dismissDirection: DismissDirection.up,
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.only(
          bottom: MediaQuery.sizeOf(context).height / 19, left: 10, right: 10),
      // action: SnackBarAction(
      //   label: "OK",
      //   textColor: Colors.white,
      //   onPressed: () {},
      // ),
      content: Text(
        message,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.white,
              fontSize: 12,
            ),
      ),
    ));
  }
}

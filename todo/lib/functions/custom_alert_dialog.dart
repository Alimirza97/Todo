import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/global/enums.dart';

import '../global/custom_thema_data_model.dart';


Future<dynamic> customAlertDialog(
  BuildContext context, {
  required AlertType type,
  Widget? title,
  Widget? content,
  Color? backgroundColor,
}) {
  Color color = type == AlertType.BASE
      ? Provider.of<CustomThemaData>(context, listen: false).getIsDark
          ? Color(0xFF0CECDD)
          : Colors.deepPurpleAccent
      : type == AlertType.ERROR
          ? Colors.red
          : type == AlertType.INFO
              ? Colors.blue
              : type == AlertType.SUCCESS
                  ? Colors.green
                  : Colors.yellow;
  String textTitle = type == AlertType.BASE
      ? ""
      : type == AlertType.ERROR
          ? "Error"
          : type == AlertType.INFO
              ? "Info"
              : type == AlertType.SUCCESS
                  ? "Successful"
                  : "Warning";
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: backgroundColor,
        scrollable: true,
        title: title ?? Center(child: Text(textTitle)),
        content: content,
        titleTextStyle: TextStyle(
          color: color,
        ),
        contentTextStyle: TextStyle(
          color: color,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(60),
          side: BorderSide(
            width: 2,
            color: color,
          ),
        ),
      );
    },
  );
}

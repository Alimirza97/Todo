import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../functions/tags_show_modal_bottom_sheet.dart';
import '../functions/tasks_show_modal_bottom_sheet.dart';
import '../global/custom_thema_data_model.dart';
import '../global/global_colors.dart';
import '../global/global_data_model.dart';

class CustomFloatingActionButton extends StatelessWidget {
  CustomFloatingActionButton({
    Key? key,
    required this.scaffoldKey,
  }) : super(key: key);

  final scaffoldKey;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      elevation: 10,
      tooltip: "Add New Task",
      backgroundColor: Theme.of(context).backgroundColor,
      foregroundColor: context.watch<CustomThemaData>().getIsDark
          ? GlobalColors.primaryDarkColor
          : GlobalColors.primaryLightColor,
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: context.watch<CustomThemaData>().getIsDark
              ? GlobalColors.primaryDarkColor
              : GlobalColors.primaryLightColor,
          width: 2,
          style: BorderStyle.solid,
        ),
        borderRadius: BorderRadius.all(Radius.circular(60.0)),
      ),
      child: Icon(Icons.add),
      onPressed: () {
        if (Provider.of<GlobalData>(context, listen: false).currentIndex == 1) {
          tasksShowModalBottomSheet(context, _formKey);
        } else if (Provider.of<GlobalData>(context, listen: false).currentIndex == 2) {
          tagsShowModalBottomSheet(context, _formKey);
        } else {
          logger.wtf(Provider.of<GlobalData>(context, listen: false)
              .currentIndex
              .toString());
        }
      },
    );
  }
}
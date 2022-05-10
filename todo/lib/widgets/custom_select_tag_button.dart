import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../global/custom_thema_data_model.dart';
import '../global/global_colors.dart';
import '../global/global_data_model.dart';
import '../model/colors_model.dart';
import '../model/task_model.dart';
import 'elevated_button_widget.dart';

class CustomSelectTagButton extends StatefulWidget {
  CustomSelectTagButton(
      {Key? key, required this.model, required this.baseSetState})
      : super(key: key);
  TaskModel model;
  List<bool> isPress = [];
  final void Function(void Function()) baseSetState;

  @override
  _CustomSelectTagButtonState createState() => _CustomSelectTagButtonState();
}

class _CustomSelectTagButtonState extends State<CustomSelectTagButton> {
  @override
  Widget build(BuildContext context) {
    if (widget.isPress.length == 0)
      for (var i = 0; i < Provider.of<GlobalData>(context).tags.length; i++) {
        widget.isPress.add(false);
      }
    return MyElevatedButton(
      margin: EdgeInsets.only(left: 10, top: 20, right: 20, bottom: 20),
      borderRadius: BorderRadius.circular(60),
      primary: Theme.of(context).backgroundColor,
      width: 60,
      height: 60,
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) {
            return StatefulBuilder(builder: (context, alertSetState) {
              return AlertDialog(
                title: Center(child: Text('Tag your task')),
                content: SingleChildScrollView(
                  child: Column(
                    children: [
                      for (var i = 0;
                          i < context.watch<GlobalData>().tags.length;
                          i++)
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            splashColor: Colors.transparent,
                            borderRadius: BorderRadius.circular(60),
                            onTap: () {
                              logger.wtf("On Top $i");
                              for (var j = 0; j < widget.isPress.length; j++)
                                widget.isPress[j] = false;
                              alertSetState(() {
                                widget.isPress[i] = true;
                              });
                              widget.baseSetState(() {});
                              widget.model.tag = Provider.of<GlobalData>(
                                      context,
                                      listen: false)
                                  .tags[i];
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: 30,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: context
                                              .watch<CustomThemaData>()
                                              .getIsDark
                                          ? GlobalColors.primaryDarkColor
                                          : GlobalColors.primaryLightColor,
                                      width: 2,
                                    ),
                                    color: widget.isPress[i]
                                        ? context
                                                .watch<CustomThemaData>()
                                                .getIsDark
                                            ? GlobalColors.primaryDarkColor
                                            : GlobalColors.primaryLightColor
                                        : Theme.of(context).cardColor,
                                    shape: BoxShape.rectangle,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: widget.isPress[i]
                                      ? Icon(Icons.check)
                                      : SizedBox(),
                                ),
                                Text(context
                                    .watch<GlobalData>()
                                    .tags[i]
                                    .name
                                    .toString()),
                                Icon(
                                  CupertinoIcons.tag,
                                  color: ColorsModel.colors[context
                                      .watch<GlobalData>()
                                      .tags[i]
                                      .color],
                                ),
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              );
            });
          },
        );
      },
      child: Icon(CupertinoIcons.tag),
    );
  }
}

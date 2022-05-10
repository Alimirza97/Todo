import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../global/custom_thema_data_model.dart';
import '../global/enums.dart';
import '../global/global_colors.dart';
import '../global/global_data_model.dart';
import '../model/date_time_model.dart';
import '../model/lottie_model.dart';
import '../model/task_model.dart';
import '../widgets/custom_lottie_widget.dart';
import '../widgets/custom_select_date_button.dart';
import '../widgets/custom_select_tag_button.dart';
import '../widgets/elevated_button_widget.dart';
import 'custom_alert_dialog.dart';
import 'todo_functions.dart';

Future<dynamic> tasksShowModalBottomSheet(
    BuildContext _context, GlobalKey<FormState> _formKey) {
  var newModel = TaskModel();
  String _dataTxt = "";
  return showModalBottomSheet(
      backgroundColor: Theme.of(_context).backgroundColor,
      context: _context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: Provider.of<CustomThemaData>(_context, listen: false).getIsDark
              ? GlobalColors.primaryDarkColor
              : GlobalColors.primaryLightColor,
          width: 2,
          style: BorderStyle.solid,
        ),
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
      ),
      builder: (context) {
        return StatefulBuilder(builder: (context, baseSetState) {
          return Form(
            key: _formKey,
            child: Padding(
              padding: EdgeInsets.only(
                  left: 0,
                  top: 2,
                  right: 0,
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding:
                        EdgeInsets.only(left: 10, top: 0, right: 10, bottom: 0),
                    child: TextFormField(
                      onTap: () {
                        logger.wtf("Top");
                      },
                      onChanged: (value) {
                        _dataTxt = value;
                      },
                      style: TextStyle(
                        color: Provider.of<CustomThemaData>(_context).getIsDark
                            ? Color(0xFF0CECDD)
                            : Colors.blue,
                      ),
                      validator: (val) {
                        if (val!.isEmpty)
                          return "Cannot Be Empty";
                        else
                          return null;
                      },
                      cursorColor:
                          Provider.of<CustomThemaData>(_context).getIsDark
                              ? Color(0xFF0CECDD)
                              : Colors.blue,
                      decoration: InputDecoration(
                        counterStyle: TextStyle(
                            color:
                                Provider.of<CustomThemaData>(_context).getIsDark
                                    ? Color(0xFF0CECDD)
                                    : Colors.blue),
                        alignLabelWithHint: true,
                        //filled: true,
                        fillColor: Colors.indigoAccent,
                        hoverColor:
                            Provider.of<CustomThemaData>(_context).getIsDark
                                ? Color(0xFF0CECDD)
                                : Colors.deepPurpleAccent,
                        suffix: IconButton(
                          icon: Icon(
                            Icons.delete,
                            color:
                                Provider.of<CustomThemaData>(_context).getIsDark
                                    ? Color(0xFF0CECDD)
                                    : Colors.blue,
                          ),
                          onPressed: () {
                            _formKey.currentState?.reset();
                          },
                        ),
                        //suffixIcon: Icon(Icons.delete),
                        hintStyle: TextStyle(
                            color:
                                Provider.of<CustomThemaData>(_context).getIsDark
                                    ? Color(0xFF0CECDD)
                                    : Colors.blue),
                        hintText: "Write Your Task",
                        labelText: "Task",
                        labelStyle: TextStyle(
                          color:
                              Provider.of<CustomThemaData>(_context).getIsDark
                                  ? Color(0xFF0CECDD)
                                  : Colors.blue,
                        ),
                        //errorText: _currentErrorMessage,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: EdgeInsets.all(20),
                        //color: Colors.blue,
                        child: Text(
                            "${context.watch<GlobalData>().selectedDate.day}/${context.watch<GlobalData>().selectedDate.month}/${context.watch<GlobalData>().selectedDate.year}"),
                      ),
                      Container(
                        padding: EdgeInsets.all(20),
                        //color: Colors.blue,
                        child: Text(newModel.tag == null
                            ? "General"
                            : newModel.tag!.name ?? ""),
                      ),
                    ],
                  ),
                  Wrap(
                    children: [
                      CustomSelectDateButton(),
                      CustomSelectTagButton(
                        model: newModel,
                        baseSetState: baseSetState,
                      ),
                      MyElevatedButton(
                        margin: EdgeInsets.only(
                            left: 20, top: 25, right: 10, bottom: 25),
                        primary: Theme.of(context).backgroundColor,
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text("Cancel"),
                      ),
                      MyElevatedButton(
                        margin: EdgeInsets.only(
                            left: 10, top: 25, right: 20, bottom: 25),
                        primary: Theme.of(context).backgroundColor,
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            if (newModel.tag != null) {
                              _formKey.currentState!.reset();
                              newModel.id = Provider.of<GlobalData>(context,
                                          listen: false)
                                      .tasks
                                      .length +
                                  1;
                              newModel.name = _dataTxt;
                              newModel.completed = false;
                              newModel.dateTime = DateTimeModel(
                                  date:
                                      "${Provider.of<GlobalData>(context, listen: false).selectedDate.day}/${Provider.of<GlobalData>(context, listen: false).selectedDate.month}/${Provider.of<GlobalData>(context, listen: false).selectedDate.year}",
                                  time:
                                      "${Provider.of<GlobalData>(context, listen: false).selectedDate.hour}:${Provider.of<GlobalData>(context, listen: false).selectedDate.minute}:${Provider.of<GlobalData>(context, listen: false).selectedDate.second}");
                              Provider.of<GlobalData>(context, listen: false)
                                  .addTasks(newModel);
                              logger.wtf(_dataTxt);
                              writeTasksJson(context);
                              customAlertDialog(
                                context,
                                type: AlertType.SUCCESS,
                                content: Center(
                                    child: CustomLottieWidget(fileName: LottieModel.confettiCheck, width: 100, height: 100)),
                                backgroundColor: Colors.transparent,
                              );
                            } else {
                              customAlertDialog(
                                context,
                                type: AlertType.WARNING,
                                content:
                                    Center(child: Text("Please Select Tag")),
                                backgroundColor: Colors.transparent,
                              );
                            }
                          } else {
                            logger.e("Hata");
                          }
                        },
                        child: Text("Save"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
      });
}

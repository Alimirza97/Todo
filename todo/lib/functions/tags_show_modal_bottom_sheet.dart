import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:provider/provider.dart';

import '../global/custom_thema_data_model.dart';
import '../global/enums.dart';
import '../global/global_colors.dart';
import '../global/global_data_model.dart';
import '../model/colors_model.dart';
import '../model/lottie_model.dart';
import '../model/tag_model.dart';
import '../widgets/custom_lottie_widget.dart';
import '../widgets/elevated_button_widget.dart';
import 'custom_alert_dialog.dart';
import 'todo_functions.dart';

Future<dynamic> tagsShowModalBottomSheet(
    BuildContext _context, GlobalKey<FormState> _formKey) {
  Color _currentColor =
      Provider.of<CustomThemaData>(_context, listen: false).getIsDark
          ? GlobalColors.primaryDarkColor
          : GlobalColors.primaryLightColor;
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
                        color: context.watch<CustomThemaData>().getIsDark
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
                        hintText: "Write Your Tag",
                        labelText: "Tag",
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
                  Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      MyElevatedButton(
                        onPressed: () {
                          customAlertDialog(
                            context,
                            type: AlertType.BASE,
                            title: Center(child: Text('Select a Color')),
                            content: SingleChildScrollView(
                              child: BlockPicker(
                                pickerColor: _currentColor,
                                onColorChanged: (color) {
                                  baseSetState(() {
                                    _currentColor = color;
                                  });
                                },
                                availableColors: [
                                  for (var i = 0;
                                      i < ColorsModel.colors.length;
                                      i++)
                                    ColorsModel.colors[i]!,
                                ],
                              ),
                            ),
                          );
                        },
                        margin: EdgeInsets.only(
                            left: 50, top: 20, right: 50, bottom: 20),
                        primary: Theme.of(context).backgroundColor,
                        borderColor: _currentColor,
                        shadowColor: _currentColor,
                        onPrimary: _currentColor,
                        child: Text("Color"),
                      ),
                      MyElevatedButton(
                        margin: EdgeInsets.only(
                            left: 20, top: 20, right: 10, bottom: 20),
                        primary: Theme.of(context).backgroundColor,
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text("Cancel"),
                      ),
                      MyElevatedButton(
                        margin: EdgeInsets.only(
                            left: 10, top: 20, right: 20, bottom: 20),
                        primary: Theme.of(context).backgroundColor,
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            logger.wtf(_dataTxt);
                            logger.wtf(_currentColor.toString());
                            int tagId =
                                Provider.of<GlobalData>(context, listen: false)
                                        .tags
                                        .length +
                                    1;
                            int currentColorindex = 99;
                            ColorsModel.colors.forEach((key, value) {
                              if (value == _currentColor)
                                currentColorindex = key;
                            });
                            logger.wtf(currentColorindex.toString());
                            if (currentColorindex == 99) {
                              customAlertDialog(
                                context,
                                type: AlertType.WARNING,
                                content:
                                    Center(child: Text("Please Select Color")),
                                backgroundColor: Colors.transparent,
                              );
                            } else {
                              TagModel newTag = TagModel(
                                color: currentColorindex,
                                id: tagId,
                                name: _dataTxt,
                              );
                              Provider.of<GlobalData>(context, listen: false)
                                  .addTags(newTag);
                              writeTagsJson(context);
                              customAlertDialog(
                                context,
                                type: AlertType.SUCCESS,
                                content: Center(
                                    child: CustomLottieWidget(fileName: LottieModel.okCheck, width: 100, height: 100)),
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

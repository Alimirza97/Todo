import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../functions/todo_functions.dart';
import '../global/custom_thema_data_model.dart';
import '../global/global_colors.dart';
import '../global/global_data_model.dart';
import '../model/colors_model.dart';
import '../model/lottie_model.dart';
import '../widgets/custom_lottie_widget.dart';

class TaskerView extends StatefulWidget {
  TaskerView({Key? key}) : super(key: key);

  @override
  _TaskerViewState createState() => _TaskerViewState();
}

class _TaskerViewState extends State<TaskerView> {
  bool splash = true;
  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      await Future.delayed(Duration(seconds: 2));
      setState(() {
        splash = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double borderRadius = 30;
    return splash
        ? SliverToBoxAdapter(
            child: CustomLottieWidget(fileName: LottieModel.page),
          )
        : SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                var model = context.watch<GlobalData>().tasks[index];
                logger.wtf("${context.watch<GlobalData>().tasks.length}"  "${context.watch<GlobalData>().isLoadTasks}");
                if (context.watch<GlobalData>().tasks.length > 0 &&
                    context.watch<GlobalData>().isLoadTasks) {
                  return Card(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: Provider.of<CustomThemaData>(context).getIsDark
                            ? GlobalColors.primaryDarkColor
                            : GlobalColors.primaryLightColor,
                        width: 2,
                        style: BorderStyle.solid,
                      ),
                      borderRadius:
                          BorderRadius.all(Radius.circular(borderRadius)),
                    ),
                    margin: EdgeInsets.all(10),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(borderRadius),
                      onLongPress: () {
                        Provider.of<GlobalData>(context, listen: false)
                            .removeAtTasks(index);
                        writeTasksJson(context);
                      },
                      onTap: () {
                        logger.wtf("On Top $index  ${model.completed!}");
                        setState(() {
                          model.completed = !model.completed!;
                        });
                        writeTasksJson(context);
                      },
                      child: Container(
                        margin: EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color:
                                        ColorsModel.colors[model.tag?.color] ??
                                            Colors.white,
                                    width: 2,
                                  ),
                                  color: model.completed ?? false
                                      ? ColorsModel.colors[model.tag?.color] ??
                                          Colors.white
                                      : Theme.of(context).cardColor,
                                  shape: BoxShape.rectangle,
                                  borderRadius:
                                      BorderRadius.circular(borderRadius),
                                ),
                                child: model.completed!
                                    ? Icon(
                                        Icons.check,
                                        color: model.tag == null
                                            ? Colors.black
                                            : Colors.white,
                                      )
                                    : SizedBox(),
                              ),
                            ),
                            Spacer(),
                            Expanded(
                              flex: 6,
                              child: ColoredBox(
                                color: Colors.transparent,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 10),
                                    Text(
                                      model.name.toString(),
                                      style: TextStyle(
                                          fontSize: 25,
                                          color: model.completed!
                                              ? Provider.of<CustomThemaData>(
                                                          context)
                                                      .getIsDark
                                                  ? Colors.white
                                                      .withOpacity(0.5)
                                                  : Colors.black
                                                      .withOpacity(0.5)
                                              : Provider.of<CustomThemaData>(
                                                          context)
                                                      .getIsDark
                                                  ? Colors.white
                                                  : Colors.black,
                                          decoration: model.completed!
                                              ? TextDecoration.lineThrough
                                              : TextDecoration.none),
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      currentDate(
                                          Provider.of<GlobalData>(context)
                                              .todaysDate,
                                          model.dateTime),
                                      style: TextStyle(
                                        color: model.completed!
                                            ? Provider.of<CustomThemaData>(
                                                        context)
                                                    .getIsDark
                                                ? Colors.white.withOpacity(0.5)
                                                : Colors.black.withOpacity(0.5)
                                            : Provider.of<CustomThemaData>(
                                                        context)
                                                    .getIsDark
                                                ? Colors.white
                                                : Colors.black,
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Icon(
                                CupertinoIcons.tag,
                                size: 30,
                                color: ColorsModel.colors[model.tag?.color],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                } else {
                  return CustomLottieWidget(fileName: LottieModel.page);
                }
              },
              childCount: context.watch<GlobalData>().tasks.length,
            ),
          );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../functions/todo_functions.dart';
import '../global/custom_thema_data_model.dart';
import '../global/global_colors.dart';
import '../global/global_data_model.dart';
import '../model/colors_model.dart';

class TagsView extends StatelessWidget {
  const TagsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double borderRadius = 100;
    return SliverGrid.count(
      crossAxisCount: 2,
      children: [
        if (context.watch<GlobalData>().isLoadTags)
          for (var i = 0; i < context.watch<GlobalData>().tags.length; i++)
            Card(
              margin: EdgeInsets.all(10.0),
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  color: Provider.of<CustomThemaData>(context).getIsDark
                      ? GlobalColors.primaryDarkColor
                      : GlobalColors.primaryLightColor,
                  width: 2,
                  style: BorderStyle.solid,
                ),
                borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
              ),
              elevation: 10,
              shadowColor: Provider.of<CustomThemaData>(context).getIsDark
                  ? GlobalColors.primaryDarkColor
                  : GlobalColors.primaryLightColor,
              child: InkWell(
                onTap: () {},
                borderRadius: BorderRadius.circular(borderRadius),
                onLongPress: () {
                  Provider.of<GlobalData>(context, listen: false)
                      .removeAtTags(i);
                      writeTagsJson(context);
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(borderRadius),
                  ),
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        context.watch<GlobalData>().tags[i].name.toString(),
                        style: TextStyle(fontSize: 20),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Icon(
                        CupertinoIcons.tag_circle,
                        size: 70,
                        color: ColorsModel.colors[
                            Provider.of<GlobalData>(context).tags[i].color],
                      ),
                    ],
                  ),
                ),
              ),
            ),
      ],
    );
  }
}

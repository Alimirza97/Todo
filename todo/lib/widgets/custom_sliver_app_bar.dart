import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../global/custom_thema_data_model.dart';
import '../global/global_colors.dart';
import '../global/global_data_model.dart';

class CustomSliverAppBar extends StatelessWidget {
  CustomSliverAppBar({Key? key, required this.scaffoldKey}) : super(key: key);

  final scaffoldKey;
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      collapsedHeight: 100,
      leading: IconButton(
        onPressed: () {
          scaffoldKey.currentState?.openDrawer();
        },
        icon: Icon(Icons.menu),
        splashRadius: 20,
        splashColor: GlobalColors.primaryDarkColor,
      ),
      //toolbarHeight: 100,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            context.watch<GlobalData>().currentIndex == 1
                ? "Tasker"
                : context.watch<GlobalData>().currentIndex == 2
                    ? "Tags"
                    : "About",
            style: GoogleFonts.pacifico(
              fontSize: 40,
            ),
          ),
          InkWell(
            borderRadius: BorderRadius.circular(60),
            onTap: () {
              Provider.of<CustomThemaData>(context, listen: false).setIsDark =
                  !Provider.of<CustomThemaData>(context, listen: false)
                      .getIsDark;
            },
            child: Provider.of<CustomThemaData>(context).getIsDark
                ? Icon(CupertinoIcons.moon)
                : Icon(Icons.wb_sunny),
          ),
        ],
      ),
      backgroundColor: Theme.of(context).primaryColor,
      expandedHeight: 150,
      elevation: 10,
      shadowColor: context.watch<CustomThemaData>().getIsDark
          ? GlobalColors.primaryDarkColor
          : GlobalColors.primaryLightColor,
      flexibleSpace: FlexibleSpaceBar(
        title: Padding(
          padding: const EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 0.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    Provider.of<GlobalData>(context).todaysDate.day.toString(),
                    style: TextStyle(fontSize: 30),
                  ),
                  SizedBox(
                    width: 2,
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        Provider.of<GlobalData>(context).months,
                        style: TextStyle(fontSize: 8),
                      ),
                      Text(
                        Provider.of<GlobalData>(context)
                            .todaysDate
                            .year
                            .toString(),
                        style: TextStyle(fontSize: 8),
                      ),
                    ],
                  )
                ],
              ),
              Text(
                Provider.of<GlobalData>(context).weekdays.toUpperCase(),
                style: TextStyle(fontSize: 8),
              ),
            ],
          ),
        ),
        centerTitle: true,
      ),
      //pinned: true,
    );
  }
}

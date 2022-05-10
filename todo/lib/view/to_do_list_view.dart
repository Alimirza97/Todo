import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:todo/model/lottie_model.dart';
import 'package:todo/widgets/custom_lottie_widget.dart';

import '../functions/todo_functions.dart';
import '../global/global_data_model.dart';
import '../widgets/custom_floating_action_button.dart';
import '../widgets/custom_sliver_app_bar.dart';
import '../widgets/my_custom_drawer.dart';
import 'tags_view.dart';
import 'tasker_view.dart';

class ToDoListView extends StatefulWidget {
  ToDoListView({Key? key}) : super(key: key);

  @override
  _ToDoListViewState createState() => _ToDoListViewState();
}

class _ToDoListViewState extends State<ToDoListView> {
  bool splash = true;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      await Future.delayed(Duration(seconds: 3));
      setState(() {
        splash = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!context.read<GlobalData>().isLoadTasks) readTasksJson(context);
    if (!context.read<GlobalData>().isLoadTags) readTagsJson(context);
    return Scaffold(
      key: _scaffoldKey,
      drawer: MyCustomDrawer(),
      body: splash
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "To Do",
                    style: GoogleFonts.pacifico(
                      fontSize: 50,
                    ),
                  ),
                  CustomLottieWidget(
                    fileName: LottieModel.todoSplash,
                    fit: BoxFit.fill,
                  ),
                ],
              ),
            )
          : SafeArea(
              child: CustomScrollView(
                slivers: [
                  CustomSliverAppBar(
                    scaffoldKey: _scaffoldKey,
                  ),
                  context.watch<GlobalData>().currentIndex == 1
                      ? TaskerView()
                      : context.watch<GlobalData>().currentIndex == 2
                          ? TagsView()
                          : SliverToBoxAdapter(child: Container()),
                ],
              ),
            ),
      floatingActionButton: splash
          ? null
          : CustomFloatingActionButton(
              scaffoldKey: _scaffoldKey,
            ),
    );
  }
}

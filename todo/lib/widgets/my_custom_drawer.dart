import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../global/global_data_model.dart';
import 'elevated_button_widget.dart';

class MyCustomDrawer extends StatelessWidget {
  MyCustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          MyElevatedButton(
            onPressed: () {
              context.read<GlobalData>().currentIndex = 1;
              Navigator.of(context).pop();
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Tasks"),
                context.read<GlobalData>().currentIndex == 1
                    ? Icon(Icons.arrow_forward)
                    : SizedBox(),
              ],
            ),
            borderWidth: context.read<GlobalData>().currentIndex == 1 ? 5 : 2,
          ),
          MyElevatedButton(
            onPressed: () {
              context.read<GlobalData>().currentIndex = 2;
              Navigator.of(context).pop();
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Tags"),
                context.read<GlobalData>().currentIndex == 2
                    ? Icon(Icons.arrow_forward)
                    : SizedBox(),
              ],
            ),
            borderWidth: context.read<GlobalData>().currentIndex == 2 ? 5 : 2,
          ),
          MyElevatedButton(
            onPressed: () {
              context.read<GlobalData>().currentIndex = 3;
              Navigator.of(context).pop();
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("About"),
                context.read<GlobalData>().currentIndex == 3
                    ? Icon(Icons.arrow_forward)
                    : SizedBox(),
              ],
            ),
            borderWidth: context.read<GlobalData>().currentIndex == 3 ? 5 : 2,
          ),
        ],
      )),
    );
  }
}

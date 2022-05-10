import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'global/custom_thema_data_model.dart';
import 'global/providers.dart';
import 'shared/custom_thema_data.dart';
import 'view/to_do_list_view.dart';

main() {
  runApp(
    MultiProvider(
      providers: Providers.providers,
      child: MyApp(),
    ),
  );
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TO DO',
      darkTheme: darkThemeData,
      theme: Provider.of<CustomThemaData>(context).myTheme,
      home: ToDoListView(),
    );
  }
}
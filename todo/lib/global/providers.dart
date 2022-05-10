import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:todo/global/custom_thema_data_model.dart';
import 'package:todo/global/global_data_model.dart';

class Providers {
  static List<SingleChildWidget> providers = [
    ChangeNotifierProvider(create: (context) => CustomThemaData()),
    ChangeNotifierProvider(create: (context) => GlobalData()),
  ];
}

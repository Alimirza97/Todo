import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/global/global_data_model.dart';
import 'package:todo/widgets/elevated_button_widget.dart';

Future<void> _selectDate(BuildContext context) async {
  final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: Provider.of<GlobalData>(context, listen: false).selectedDate,
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101));
  if (picked != null &&
      picked != Provider.of<GlobalData>(context, listen: false).selectedDate)
    Provider.of<GlobalData>(context, listen: false).selectedDate = picked;
}


class CustomSelectDateButton extends StatelessWidget {
  const CustomSelectDateButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyElevatedButton(
      margin: EdgeInsets.only(
          left: 20, top: 20, right: 10, bottom: 20),
      borderRadius: BorderRadius.circular(60),
      width: 60,
      height: 60,
      primary: Theme.of(context).backgroundColor,
      onPressed: () {
        logger.wtf("Calendar Press");
        _selectDate(context);
      },
      child: Icon(Icons.calendar_today),
    );
  }
}

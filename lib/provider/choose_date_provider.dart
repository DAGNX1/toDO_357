import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChosseDate extends ChangeNotifier{
  var selectedDate =  DateUtils.dateOnly( DateTime.now());
  void chooseDate(BuildContext context) async {
    DateTime?chooseDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 356)));
    if (chooseDate != null) {
      selectedDate =DateUtils.dateOnly(chooseDate) ;
    notifyListeners();
    }
  }
}

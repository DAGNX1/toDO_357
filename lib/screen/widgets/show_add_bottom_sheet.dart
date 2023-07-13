
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do/model/task_model.dart';
import '../../firebase/firebase_fuction.dart';
import '../../provider/choose_date_provider.dart';
import 'custom_text_form_field.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class showAddBootomSheet extends StatefulWidget {
  @override
  State<showAddBootomSheet> createState() => _showAddBootomSheetState();
}

class _showAddBootomSheetState extends State<showAddBootomSheet> {
  var formkey = GlobalKey<FormState>();
  var titlecontroller = TextEditingController();
  var descriptioncontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ChosseDate(),
      builder: (context, child) {
        var pro = Provider.of<ChosseDate>(context);
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: formkey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  AppLocalizations.of(context)!.addNewTask,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(
                  height: 20,
                ),
                CostumTextFormField(
                    controller: titlecontroller,
                    hinttitle: AppLocalizations.of(context)!.taskTitle,
                    labeltitle: AppLocalizations.of(context)!.taskTitle),
                const SizedBox(
                  height: 10,
                ),
                CostumTextFormField(
                    controller: descriptioncontroller,
                    hinttitle: AppLocalizations.of(context)!.taskDescription,
                    labeltitle: AppLocalizations.of(context)!.taskDescription),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  width: double.infinity,
                  child: Text(
                      AppLocalizations.of(context)!.selectDate,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
                InkWell(
                  onTap: () {
                    pro.chooseDate(context);
                  },
                  child: Text(
                    pro.selectedDate.toString().substring(0, 10),
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(color: Colors.grey),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: ElevatedButton(
                      onPressed: () {
                        if (formkey.currentState!.validate()) {
                          TaskModel task = TaskModel(

                              description: descriptioncontroller.text,
                              title: titlecontroller.text,
                              status: false,
                              date: pro.selectedDate.millisecondsSinceEpoch,
                              userId: FirebaseAuth.instance.currentUser!.uid,
                              time: DateTime.now().millisecondsSinceEpoch);
                          FireBaseFunction.addTaskeToFireStore(task);
                          Navigator.pop(context);
                        }
                      },
                      child: Text(
                          AppLocalizations.of(context)!.addTask,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(color: Colors.white),
                      )),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

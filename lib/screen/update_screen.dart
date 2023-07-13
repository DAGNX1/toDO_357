import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do/screen/widgets/custom_text_form_field.dart';

import '../firebase/firebase_fuction.dart';
import '../model/task_model.dart';
import '../provider/choose_date_provider.dart';

class UpdateScreen extends StatelessWidget {

  static const String routeName = "UpdateScreen";
  var formkey = GlobalKey<FormState>();
  TextEditingController? titlecontroller;
  TextEditingController? descriptioncontroller;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    var task = ModalRoute
        .of(context)
        ?.settings
        .arguments as TaskModel;
    if (titlecontroller == null || descriptioncontroller == null) {
      titlecontroller = TextEditingController(text: task.title);
      descriptioncontroller = TextEditingController(text: task.description);
    }

    return ChangeNotifierProvider(
      create: (context) => ChosseDate(),
        builder: (context, child) {
          var prov = Provider.of<ChosseDate>(context);
          return Scaffold(
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  key: formkey,
                  child: Container(
                    margin: EdgeInsets.only(top: 60),
                    height: MediaQuery
                        .of(context)
                        .size
                        .height * 0.70,
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "Update Task",
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .bodyLarge,
                            ),
                            const SizedBox(
                              height: 50,
                            ),
                            CostumTextFormField(
                                controller: titlecontroller!,
                                hinttitle: "Task Title",
                                labeltitle: "Task Title"),
                            const SizedBox(
                              height: 10,
                            ),
                            CostumTextFormField(
                                controller: descriptioncontroller!,
                                hinttitle: "Task Description",
                                labeltitle: "Task Description"),
                            const SizedBox(
                              height: 30,
                            ),
                            InkWell(
                              onTap: () {
                                prov.chooseDate(context);
                              },
                              child: Text(
                                prov.selectedDate.toString().substring(0, 10),
                                style: Theme
                                    .of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(color: Colors.grey),
                              ),
                            ),
                            const SizedBox(
                              height: 100,
                            ),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            20)),
                                    fixedSize: Size(
                                      MediaQuery
                                          .of(context)
                                          .size
                                          .width * 0.7,
                                      MediaQuery
                                          .of(context)
                                          .size
                                          .width * 0.2,
                                    )),
                                onPressed: () {
                                  if (formkey.currentState!.validate()) {
                                    task.description =
                                        descriptioncontroller!.text;
                                    task.title = titlecontroller!.text;
                                    FireBaseFunction.updateTask(task.id, task);
                                    Navigator.pop(context);
                                  }
                                },
                                child: Text(
                                  "Update Task",
                                  style: Theme
                                      .of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(color: Colors.white),
                                )),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        }
    );
  }

  void initState() {

  }

  void disposed() {
    titlecontroller?.dispose();
    descriptioncontroller?.dispose();
  }


}
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:to_do/firebase/firebase_fuction.dart';
import 'package:to_do/model/task_model.dart';
import 'package:to_do/screen/update_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class TaskItem extends StatelessWidget {
  TaskModel taskModel;

  TaskItem(this.taskModel);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 150,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          shape: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(color: Colors.transparent)),
          child: Slidable(
            startActionPane: ActionPane(
              motion: BehindMotion(),
              children: [
                SlidableAction(
                  onPressed: (context) {
                    FireBaseFunction.deleteTask(taskModel.id);
                  },
                  backgroundColor: Color(0xFFFE4A49),
                  foregroundColor: Colors.white,
                  icon: Icons.delete,
                  label: 'Delete',
                ),
                SlidableAction(
                  onPressed: (context) {
                    Navigator.pushNamed(context, UpdateScreen.routeName, arguments: taskModel);

                  },
                  backgroundColor: Color(0xFF21B7CA),
                  foregroundColor: Colors.white,
                  icon: Icons.update,
                  label: 'update',
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Container(
                    height: 60,
                    width: 5,
                    decoration: BoxDecoration(
                        color:taskModel.status?Colors.greenAccent: Colors.blue,
                        borderRadius: BorderRadius.circular(4)),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                            width: MediaQuery
                                .of(context)
                                .size
                                .width * 0.65,
                            child: Text(
                              taskModel.title,
                              overflow: TextOverflow.ellipsis,
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(color:taskModel.status?Colors.greenAccent: Colors.blue),
                            )),
                        SizedBox(height: 10,),
                        SizedBox(
                          width: MediaQuery
                              .of(context)
                              .size
                              .width * 0.65,
                          child: Text(
                            taskModel.description,
                            overflow: TextOverflow.ellipsis,
                            style: Theme
                                .of(context)
                                .textTheme
                                .bodyLarge,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  taskModel.status ? Text(AppLocalizations.of(context)!.done, style: Theme
                      .of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(color: Colors.greenAccent),): InkWell(
                    onTap: () {
                      taskModel.status = true;
                      FireBaseFunction.updateTask(taskModel.id, taskModel);
                    },
                    child: Container(
                        width: 60,
                        height: 40,
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Colors.blue)),
                        child: Icon(Icons.done, color: Colors.white,)),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

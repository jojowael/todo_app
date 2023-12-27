import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:project2/firebase_utils.dart';
import 'package:project2/my_theme.dart';
import 'package:project2/providers/app_config_provider.dart';
import 'package:project2/providers/auth_provider.dart';
import 'package:provider/provider.dart';

import '../model/task.dart';

class EditTaskScreen extends StatefulWidget {
  static const String routeName = 'edit_task_screen';

  @override
  State<EditTaskScreen> createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  DateTime selectedDate = DateTime.now();
  var formKey = GlobalKey<FormState>();
  late AppConfigProvider provider;
  var titlecontroller = TextEditingController();
  var desccontroller = TextEditingController();
  String task = '';
  String desc = '';

  // Task? task;

  @override
  Widget build(BuildContext context) {
    var authprovider = Provider.of<AuthProvider>(context);
    Task passedTask = ModalRoute.of(context)?.settings.arguments as Task;
    // if (task == null) {
    //   var task = ModalRoute.of(context)?.settings.arguments as Task;
    titlecontroller.text = passedTask.title ?? '';
    desccontroller.text = passedTask.description ?? '';
    selectedDate = passedTask.dateTime!;
    var provider = Provider.of<AppConfigProvider>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.toDoList,
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.05,
          vertical: MediaQuery.of(context).size.height * 0.06,
        ),
        decoration: BoxDecoration(
            color:
            provider.isDarkMode() ? MyTheme.blackColor : MyTheme.whiteColor,
            borderRadius: BorderRadius.circular(15)),
        padding: EdgeInsets.all(12),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  AppLocalizations.of(context)!.edit_task,
                  style: provider.isDarkMode()
                      ? Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(color: MyTheme.whiteColor)
                      : Theme.of(context).textTheme.titleMedium,
                ),
              ),
              Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          validator: (text) {
                            if (text == null || text.isEmpty) {
                              return AppLocalizations.of(context)!
                                  .please_enter_task_title;
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            hintText:
                            AppLocalizations.of(context)!.this_is_title,
                            hintStyle: provider.isDarkMode()
                                ? Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(color: MyTheme.whiteColor)
                                : Theme.of(context).textTheme.titleSmall,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          validator: (text) {
                            if (text == null || text.isEmpty) {
                              return AppLocalizations.of(context)!
                                  .enter_Task_Details;
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            hintText:
                            AppLocalizations.of(context)!.task_details,
                            hintStyle: provider.isDarkMode()
                                ? Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(color: MyTheme.whiteColor)
                                : Theme.of(context).textTheme.titleSmall,
                          ),
                          maxLines: 4,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          AppLocalizations.of(context)!.select_Date,
                          style: provider.isDarkMode()
                              ? Theme.of(context)
                              .textTheme
                              .titleSmall!
                              .copyWith(color: MyTheme.whiteColor)
                              : Theme.of(context).textTheme.titleSmall,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          ShowCalender();
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}',
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(color: MyTheme.greyColor),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 70,
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * 0.05,
                          vertical: MediaQuery.of(context).size.height * 0.06,
                        ),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50)),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: MyTheme.primaryLight),
                          child: TextButton(
                              onPressed: () {
                                if (task != "") {
                                  FirebaseUtils.getTasksCollection(
                                          authprovider.currentUser?.id ?? "")
                                      .doc(passedTask.id)
                                      .update({"title": task}).timeout(
                                          Duration(milliseconds: 500));
                                }
                                if (desc != "") {
                                  FirebaseUtils.getTasksCollection(
                                          authprovider.currentUser?.id ?? "")
                                      .doc(passedTask.id)
                                      .update({"desc": desc}).timeout(
                                          Duration(milliseconds: 500));
                                }
                                if (selectedDate?.millisecondsSinceEpoch !=
                                    passedTask.dateTime) {
                                  FirebaseUtils.getTasksCollection(
                                          authprovider.currentUser?.id ?? "")
                                      .doc(passedTask.id)
                                      .update({
                                    "dateTime":
                                        selectedDate?.millisecondsSinceEpoch
                                  }).timeout(Duration(milliseconds: 500));
                                }
                                provider.getAllTasksFromFireStore(
                                    authprovider.currentUser?.id ?? "");
                                Navigator.pop(context);
                              },
                              child: Text(
                                AppLocalizations.of(context)!.save_changes,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall!
                                    .copyWith(color: MyTheme.whiteColor),
                              )),
                        ),
                      )
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }

  void ShowCalender() async {
    var chosenDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365)));
    if (chosenDate != null) {
      selectedDate = chosenDate;
      // t.dateTime = selectedDate;
    }
    setState(() {});
  }
}

// void editTask() {
//   if (formKey.currentState?.validate() == true) {
//     task?.title = titlecontroller.text;
//     task?.description = desccontroller.text;
//     task?.dateTime = selectedDate;
//     var authProvider = Provider.of<AuthProvider>(context, listen: false);
//     DialogUtils.showLoading(context, 'loading...');
//
//     FirebaseUtils.editTask(task!, authProvider.currentUser!.id!)
//         .then((value) {
//       DialogUtils.hideLoading(context);
//     }).timeout(Duration(milliseconds: 500), onTimeout: () {
//       print('success');
//       provider.getAllTasksFromFireStore(authProvider.currentUser!.id!);
//       Navigator.pop(context);
//     });
//   }
//   }

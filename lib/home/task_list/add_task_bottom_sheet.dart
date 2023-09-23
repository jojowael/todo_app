import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../my_theme.dart';
import '../../providers/app_config_provider.dart';

class AddTaskBottomSheet extends StatefulWidget {
  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  DateTime selectedDate = DateTime.now();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    return Container(
      color: provider.isDarkMode() ? MyTheme.blackColor : MyTheme.whiteColor,
      padding: EdgeInsets.all(12),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              AppLocalizations.of(context)!.add_new_Task,
              style: provider.isDarkMode()
                  ? Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(color: MyTheme.whiteColor)
                  : Theme.of(context).textTheme.titleMedium,
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
                              AppLocalizations.of(context)!.enter_Task_Title,
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
                                .please_enter_task_description;
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: AppLocalizations.of(context)!
                              .enter_Task_Description,
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
                          style: provider.isDarkMode()
                              ? Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .copyWith(color: MyTheme.whiteColor)
                              : Theme.of(context).textTheme.titleSmall,
                        ),
                      ),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          addTask();
                        },
                        child: Text(
                          AppLocalizations.of(context)!.add,
                          style: Theme.of(context).textTheme.titleLarge,
                        ))
                  ],
                ))
          ],
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
      setState(() {});
    }
  }

  void addTask() {
    if (formKey.currentState?.validate() == true) {
      //add task to firebase
    }
  }
}

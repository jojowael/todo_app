import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:project2/firebase_utils.dart';
import 'package:provider/provider.dart';

import '../../model/task.dart';
import '../../my_theme.dart';
import '../../providers/app_config_provider.dart';
import '../../providers/auth_provider.dart';
import '../edit_task_screen.dart';

class TaskWidgetItem extends StatefulWidget {
  Task task;

  TaskWidgetItem({required this.task});

  @override
  State<TaskWidgetItem> createState() => _TaskWidgetItemState();
}

class _TaskWidgetItemState extends State<TaskWidgetItem> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    var authProvider = Provider.of<AuthProvider>(context);
    return InkWell(
      onTap: () {
        Navigator.of(context)
            .pushNamed(EditTaskScreen.routeName, arguments: widget.task);
      },
      child: Container(
        margin: EdgeInsets.all(12),
        child: Slidable(
          // The start action pane is the one at the left or the top side.
          startActionPane: ActionPane(
            extentRatio: 0.25,
            motion: const ScrollMotion(),
            children: [
              SlidableAction(
                onPressed: (context) {
                  //delete task
                  FirebaseUtils.deleteTaskFromFireStore(
                          widget.task, authProvider.currentUser!.id!)
                      .timeout(Duration(milliseconds: 500), onTimeout: () {
                    print('todo deleted successful');
                    provider.getAllTasksFromFireStore(
                        authProvider.currentUser!.id!);
                  });
                },
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    bottomLeft: Radius.circular(15)),
                backgroundColor: MyTheme.redColor,
                foregroundColor: MyTheme.whiteColor,
                icon: Icons.delete,
                label: AppLocalizations.of(context)!.delete,
              ),
            ],
          ),
          child: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: provider.isDarkMode()
                  ? MyTheme.blackColor
                  : MyTheme.whiteColor,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  color: widget.task.isDone!
                      ? MyTheme.greenColor
                      : Theme.of(context).primaryColor,
                  height: 80,
                  width: 4,
                ),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        widget.task.title ?? '',
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            color: widget.task.isDone!
                                ? MyTheme.greenColor
                                : Theme.of(context).primaryColor),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        widget.task.description ?? '',
                        style: provider.isDarkMode()
                            ? Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(color: MyTheme.whiteColor)
                            : Theme.of(context).textTheme.titleSmall,
                      ),
                    )
                  ],
                )),
                InkWell(
                  onTap: () {
                    FirebaseUtils.editIsDone(
                        widget.task, authProvider.currentUser!.id!);
                    widget.task.isDone = !widget.task.isDone!;
                    setState(() {});
                  },
                  child: widget.task.isDone!
                      ? Text(
                          'Done!',
                          style: TextStyle(
                              color: MyTheme.greenColor,
                              fontSize: 22,
                              fontWeight: FontWeight.bold),
                        )
                      : Container(
                          padding: EdgeInsets.symmetric(
                            vertical: 7,
                            horizontal: 20,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Theme.of(context).primaryColor,
                          ),
                          // child: InkWell(
                          //   onTap: () {
                          //     Container(
                          //       padding: EdgeInsets.all(10),
                          //       decoration: BoxDecoration(
                          //         borderRadius: BorderRadius.circular(15),
                          //         color: provider.isDarkMode()
                          //             ? MyTheme.blackColor
                          //             : MyTheme.whiteColor,
                          //       ),
                          //       child: Row(
                          //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //         children: [
                          //           Container(
                          //             color: Theme.of(context).primaryColor,
                          //             height: 80,
                          //             width: 4,
                          //           ),
                          //           Expanded(
                          //             child: Column(
                          //               crossAxisAlignment: CrossAxisAlignment.start,
                          //               children: [
                          //                 Padding(
                          //                   padding: const EdgeInsets.all(8.0),
                          //                   child: Text(
                          //                     task.title ?? '',
                          //                     style: Theme.of(context)
                          //                         .textTheme
                          //                         .titleSmall!
                          //                         .copyWith(color: MyTheme.greenColor),
                          //                   ),
                          //                 ),
                          //                 Padding(
                          //                   padding: const EdgeInsets.all(8.0),
                          //                   child: Text(
                          //                     task.description ?? '',
                          //                     style: provider.isDarkMode()
                          //                         ? Theme.of(context)
                          //                             .textTheme
                          //                             .titleSmall!
                          //                             .copyWith(
                          //                                 color: MyTheme.greenColor)
                          //                         : Theme.of(context)
                          //                             .textTheme
                          //                             .titleSmall,
                          //                   ),
                          //                 )
                          //               ],
                          //             ),
                          //           ),
                          //           Icon(
                          //             Icons.done,
                          //             color: MyTheme.greenColor,
                          //             size: 35,
                          //           )
                          //         ],
                          //       ),
                          //     );
                          //
                          //   },
                          child: Icon(
                            Icons.check,
                            color: MyTheme.whiteColor,
                            size: 35,
                          ),
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

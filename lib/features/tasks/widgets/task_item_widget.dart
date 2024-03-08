import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/core/services/snak_bar_service.dart';
import 'package:todo_app/features/firebase_utils.dart';
import 'package:todo_app/features/settings_provider.dart';
import 'package:todo_app/models/task_model.dart';

class TaskItemWidget extends StatelessWidget {
  final TaskModel taskModel;

  const TaskItemWidget({super.key, required this.taskModel});

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    var theme = Theme.of(context);
    var vm = Provider.of<SettingsProvider>(context);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: const Color(0xFFFE4A49),
      ),
      child: Slidable(
        startActionPane: ActionPane(
          extentRatio: 0.265,
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              onPressed: (context) {
                EasyLoading.show();
                FirebaseUtils().deleteTask(taskModel).then((value) {
                  EasyLoading.dismiss();
                  SnackBarService.showSuccessMessage(
                    "Task Deleted Successfully",
                  );
                });
              },
              backgroundColor: const Color(0xFFFE4A49),
              borderRadius: BorderRadius.circular(15),
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Delete',
            ),
          ],
        ),
        child: Container(
          width: mediaQuery.width,
          height: 115,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: vm.isDark() ? const Color(0xFF141922) : Colors.white,
          ),
          child: Row(
            children: [
              Container(
                width: 4,
                height: 62,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: taskModel.isDone ? Colors.green : theme.primaryColor,
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      taskModel.title,
                      style: theme.textTheme.bodyMedium!.copyWith(
                        color: taskModel.isDone
                            ? Colors.green
                            : theme.primaryColor,
                      ),
                    ),
                    Text(
                      taskModel.description,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: theme.textTheme.bodySmall!.copyWith(
                        color: vm.isDark() ? Colors.white : Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.watch_later_outlined,
                          color: vm.isDark() ? Colors.white : Colors.black,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          DateFormat.yMMMMd().format(taskModel.dateTime),
                          style: theme.textTheme.bodySmall!.copyWith(
                            fontWeight: FontWeight.w400,
                            color: vm.isDark() ? Colors.white : Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              if (taskModel.isDone)
                Text(
                  "Done !",
                  style: theme.textTheme.titleLarge!.copyWith(
                    color: taskModel.isDone ? Colors.green : theme.primaryColor,
                  ),
                ),
              if (!taskModel.isDone)
                InkWell(
                  onTap: () {
                    EasyLoading.show();
                    var data = TaskModel(
                      id: taskModel.id,
                      title: taskModel.title,
                      description: taskModel.description,
                      isDone: true,
                      dateTime: taskModel.dateTime,
                    );
                    FirebaseUtils().updateTask(data).then((value) {
                      EasyLoading.dismiss();
                      SnackBarService.showSuccessMessage(
                          "Task Updated Successfully");
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      color: theme.primaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      Icons.check_rounded,
                      color: Colors.white,
                      size: 40,
                      weight: 50,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

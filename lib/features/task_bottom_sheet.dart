import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/core/services/snak_bar_service.dart';
import 'package:todo_app/core/utils/extract_date.dart';
import 'package:todo_app/core/widgets/custom_text_field.dart';
import 'package:todo_app/features/firebase_utils.dart';
import 'package:todo_app/features/settings_provider.dart';
import 'package:todo_app/models/task_model.dart';

class TaskBottomSheet extends StatefulWidget {
  const TaskBottomSheet({super.key});

  @override
  State<TaskBottomSheet> createState() => _TaskBottomSheetState();
}

class _TaskBottomSheetState extends State<TaskBottomSheet> {
  var titleController = TextEditingController();

  var descriptionController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    var theme = Theme.of(context);
    var vm = Provider.of<SettingsProvider>(context);
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 25,
        horizontal: 20,
      ),
      width: mediaQuery.width,
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          )),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Add A New Task",
              textAlign: TextAlign.center,
              style: theme.textTheme.titleLarge!.copyWith(
                color: vm.isDark() ? Colors.white : Colors.black,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            CustomTextField(
              controller: titleController,
              hint: "Enter Your New Task",
              hintColor: Colors.grey.shade600,
              onValidate: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "You Must Enter The Task Title";
                }
                return null;
              },
            ),
            const SizedBox(
              height: 30,
            ),
            CustomTextField(
              controller: descriptionController,
              hint: "Enter Your Task Description",
              hintColor: Colors.grey.shade600,
              maxLines: 3,
              maxLength: 150,
              onValidate: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "You Must Enter The Task Description";
                }
                return null;
              },
            ),
            const SizedBox(
              height: 30,
            ),
            Text(
              "Select Time",
              textAlign: TextAlign.start,
              style: theme.textTheme.titleMedium!.copyWith(
                color: vm.isDark() ? Colors.white : Colors.black,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            GestureDetector(
              onTap: () {
                vm.selectedTaskDate(context);
              },
              child: Text(
                DateFormat.yMMMMd().format(vm.selectedDate),
                textAlign: TextAlign.center,
                style: theme.textTheme.titleMedium!.copyWith(
                  color: vm.isDark() ? Colors.white : Colors.grey.shade600,
                ),
              ),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  var data = TaskModel(
                    title: titleController.text,
                    description: descriptionController.text,
                    isDone: false,
                    dateTime: extractDateTime(vm.selectedDate),
                  );
                  EasyLoading.show();

                  FirebaseUtils().addNewTask(data).then((value) {
                    EasyLoading.dismiss();
                    Navigator.pop(context);
                    SnackBarService.showSuccessMessage(
                        "Task successfully created");
                  }).onError((error, stackTrace) {
                    EasyLoading.dismiss();
                    SnackBarService.showErrorMessage(error.toString());
                  });
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.primaryColor,
                fixedSize: Size(mediaQuery.width, 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                "Add Task",
                style: theme.textTheme.bodyMedium!.copyWith(
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

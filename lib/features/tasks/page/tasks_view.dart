import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/features/firebase_utils.dart';
import 'package:todo_app/features/settings_provider.dart';
import 'package:todo_app/features/tasks/widgets/task_item_widget.dart';
import 'package:todo_app/models/task_model.dart';

class TasksView extends StatefulWidget {
  const TasksView({super.key});

  @override
  State<TasksView> createState() => _TasksViewState();
}

class _TasksViewState extends State<TasksView> {
  DateTime focusTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    var vm = Provider.of<SettingsProvider>(context);
    var theme = Theme.of(context);
    var mediaQuery = MediaQuery.of(context).size;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 60.0),
          child: Stack(
            clipBehavior: Clip.none,
            alignment: const Alignment(0, 1.5),
            children: [
              Container(
                color: theme.primaryColor,
                width: mediaQuery.width,
                height: mediaQuery.height * .22,
                padding: const EdgeInsets.symmetric(
                  horizontal: 51,
                  vertical: 60,
                ),
                child: Text(
                  'To Do List',
                  style: theme.textTheme.titleLarge,
                ),
              ),
              EasyInfiniteDateTimeLine(
                firstDate: DateTime(2023),
                focusDate: focusTime,
                lastDate: DateTime(2025),
                showTimelineHeader: false,
                timeLineProps: const EasyTimeLineProps(
                  separatorPadding: 15,
                ),
                dayProps: EasyDayProps(
                  width: 60,
                  height: 90,
                  inactiveDayStyle: DayStyle(
                    dayStrStyle: theme.textTheme.bodySmall!.copyWith(
                      color: Colors.white,
                    ),
                    monthStrStyle: theme.textTheme.bodySmall!.copyWith(
                      color: Colors.white,
                    ),
                    dayNumStyle: theme.textTheme.bodyMedium!.copyWith(
                      color: Colors.white,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      gradient: const LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color(0xFF071952),
                          Color(0xFF35A29F),
                        ],
                      ),
                    ),
                  ),
                  todayStyle: DayStyle(
                    dayStrStyle: theme.textTheme.bodySmall,
                    monthStrStyle: theme.textTheme.bodySmall,
                    dayNumStyle: theme.textTheme.bodyMedium!.copyWith(
                      color: Colors.black,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade400,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  activeDayStyle: DayStyle(
                    dayNumStyle: theme.textTheme.bodyMedium!.copyWith(
                      color: theme.primaryColor,
                    ),
                    dayStrStyle: theme.textTheme.bodySmall!.copyWith(
                      color: theme.primaryColor,
                    ),
                    monthStrStyle: theme.textTheme.bodySmall!.copyWith(
                      color: theme.primaryColor,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEEEDEB),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.black45,
                      ),
                    ),
                  ),
                ),
                onDateChange: (selectedDate) {
                  setState(() {
                    focusTime = selectedDate;
                    vm.selectedDate = focusTime;
                  });
                },
              ),
            ],
          ),
        ),
        StreamBuilder<QuerySnapshot<TaskModel>>(
          stream: FirebaseUtils().getStreamDataFromFireStore(vm.selectedDate),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Column(
                children: [
                  Text("Error"),
                  Icon(Icons.refresh),
                ],
              );
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            var tasksList =
                snapshot.data?.docs.map((e) => e.data()).toList() ?? [];

            return Expanded(
              child: ListView.builder(
                physics: const ScrollPhysics(
                  parent: BouncingScrollPhysics(),
                ),
                padding: const EdgeInsets.only(
                  top: 15,
                  bottom: 75,
                ),
                itemBuilder: (context, index) => TaskItemWidget(
                  taskModel: tasksList[index],
                ),
                itemCount: tasksList.length,
              ),
            );
          },
        ),
      ],
    );
  }
}

// Expanded(
// child: ListView(
// physics: const ScrollPhysics(
// parent: BouncingScrollPhysics(),
// ),
// padding: const EdgeInsets.only(
// top: 15,
// bottom: 75 ,
// ),
// children: const [
// TaskItemWidget(),
// TaskItemWidget(),
// TaskItemWidget(),
// TaskItemWidget(),
// TaskItemWidget(),
// TaskItemWidget(),
// TaskItemWidget(),
// TaskItemWidget(),
// TaskItemWidget(),
// ],
// ),
// ),

// FutureBuilder<List<TaskModel>>(
//   future: FirebaseUtils().getDataFromFireStore(vm.selectedDate),
//   builder: (context, snapshot) {
//     if (snapshot.hasError) {
//       return const Column(
//         children: [
//           Text("Error"),
//           Icon(Icons.refresh),
//         ],
//       );
//     }
//     if (snapshot.connectionState == ConnectionState.waiting) {
//       return const Center(
//         child: CircularProgressIndicator(),
//       );
//     }
//     var tasksList = snapshot.data ?? [];
//
//     return Expanded(
//       child: ListView.builder(
//         physics: const ScrollPhysics(
//           parent: BouncingScrollPhysics(),
//         ),
//         padding: const EdgeInsets.only(
//           top: 15,
//           bottom: 75,
//         ),
//         itemBuilder: (context, index) => TaskItemWidget(
//           taskModel: tasksList[index],
//         ),
//         itemCount: tasksList.length,
//       ),
//     );
//   },
// ),

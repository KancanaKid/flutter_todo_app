
import 'package:flutter/material.dart';
import 'package:flutter_todo_app/domain/model/task.dart';
import 'package:flutter_todo_app/res/app_context_extension.dart';
class TaskAdapter extends StatelessWidget {
  late List<Task> task;
  Function(Task) onItemChangeStatus;
  Function(Task) onItemSelected;

  TaskAdapter({super.key, required this.task, required this.onItemChangeStatus, required this.onItemSelected});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        shrinkWrap: true,
        itemBuilder: (context, index){
          return GestureDetector(
            onTap: (){
              onItemSelected(task[index]);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Checkbox(
                    value: task[index].isComplete,
                    onChanged: (value){
                      task[index].isComplete = value!;
                      onItemChangeStatus(task[index]);
                    }
                ),
                Text(
                  task[index].title ?? "",
                  style: (
                      !task[index].isComplete) ? context.resources.style.headingTextStyle
                      : context.resources.style.headingLineThroughTextStyle,
                )
              ],
            ),
          );
        },
        separatorBuilder: (context, index){
          return const Divider(
            color: Colors.grey,
            thickness: 1,
            height: 0.5,
          );
        },
        itemCount: task.length
    );
  }
}

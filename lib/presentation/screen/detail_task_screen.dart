import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo_app/bloc/task_event.dart';
import 'package:flutter_todo_app/domain/model/task.dart';
import 'package:flutter_todo_app/res/app_context_extension.dart';
import 'package:intl/intl.dart';

import '../../bloc/task_bloc.dart';
import '../../bloc/task_state.dart';
import '../widget/app_widget.dart';

class DetailTaskScreen extends StatefulWidget {
  static const String id = "detail_task_screen";
  final Task task;
  const DetailTaskScreen({required this.task, Key? key}):super(key: key);

  @override
  State<DetailTaskScreen> createState() => _DetailTaskScreenState();
}

class _DetailTaskScreenState extends State<DetailTaskScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _dueDateController = TextEditingController();
  final _dueDateFocusNode = FocusNode();
  late TaskBloc _taskBloc;

  @override
  void initState() {
    _taskBloc = BlocProvider.of(context);
    _titleController.text = widget.task.title!;
    _dueDateController.text = widget.task.dueDate!;
    _descriptionController.text = widget.task.description!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: context.resources.style.appbarIconTheme,
          centerTitle: true,
          title: Text(
            "Task Detail",
            style: context.resources.style.appbarTitleStyle,
          ),
          leading: BackButton(
            onPressed: () => Navigator.of(context).pop(),
          ),
          actions: [
            IconButton(
                onPressed: (){
                  _taskBloc.add(DeleteTaskEvent(widget.task.id));
                },
                icon: const Icon(Icons.delete_forever)
            )
          ],
        ),
        body: BlocConsumer<TaskBloc, TaskState>(
          builder: (context, state){
            if(state is PageLoadingState){
              return AppWidget.getCenterLoadingView();
            }else{
              return _taskForm(widget.task);
            }
          },
          listener: (context, state){
            if (state is TaskErrorState) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(AppWidget.defaultSnackBar(state.errorMessage));
            } else if (state is TaskQuerySuccessfulState) {
              Navigator.pop(context);
            }
          },
        )
    );
  }

  _showCalendar() async {
    var format = DateFormat.yMd();
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1970),
        lastDate: DateTime(2030),
        helpText: "Choose Due Date",
        cancelText: "Close",
        confirmText: "Choose");

    if (picked != null) {
      _dueDateController.text = format.format(picked);
    }
  }

  Widget _taskForm(Task task){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _titleController,
                    decoration: InputDecoration(
                        labelText: "Title",
                        labelStyle:
                        context.resources.style.subHeadingTextStyle,
                        isDense: true,
                        contentPadding:
                        const EdgeInsets.fromLTRB(8, 8, 8, 8)),
                    validator: (value){
                      if(value == null || value.isEmpty){
                        return "Please enter title";
                      }
                      return null;
                    },
                  ),
                  AppWidget.getDefaultSizedBox(context),
                  TextFormField(
                    controller: _dueDateController,
                    focusNode: _dueDateFocusNode,
                    decoration: InputDecoration(
                      labelText: "Due Date",
                      labelStyle: context.resources.style.subHeadingTextStyle,
                      isDense: true,
                      contentPadding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                      suffixIcon: Icon(
                        Icons.calendar_month_rounded,
                        color: context.resources.color.colorPrimary,
                      ),
                    ),
                    onTap: () {
                      _dueDateFocusNode.unfocus();
                      _showCalendar();
                    },
                    validator: (value){
                      if(value == null || value.isEmpty){
                        return "Please choose due date";
                      }
                      return null;
                    },
                  ),
                  AppWidget.getDefaultSizedBox(context),
                  TextFormField(
                    controller: _descriptionController,
                    maxLines: 5,
                    decoration: InputDecoration(
                      labelText: "Description",
                      labelStyle: context.resources.style.subHeadingTextStyle,
                      isDense: true,
                      contentPadding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                    ),
                    validator: (value){
                      if(value == null || value.isEmpty){
                        return "Please enter description";
                      }
                      return null;
                    },
                  ),
                  AppWidget.getDefaultSizedBox(context),
                  MaterialButton(
                    minWidth: MediaQuery.of(context).size.width,
                    color: context.resources.color.colorPrimary,
                    textColor: context.resources.color.colorAppbarTitleText,
                    onPressed: (){
                      if(!_formKey.currentState!.validate()){
                        ScaffoldMessenger.of(context).showSnackBar(AppWidget.defaultSnackBar("Please complete the form"));
                      }else{
                          _taskBloc.add(EditTaskEvent(task.id, _titleController.text, _descriptionController.text,
                              _dueDateController.text, task.isComplete));
                      }
                    },
                    splashColor: context.resources.color.colorAccent,
                    child: const Text("Save"),
                  )
                ],
              ))),
    );
  }
}

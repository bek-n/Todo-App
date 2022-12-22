import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:panara_dialogs/panara_dialogs.dart';
import 'package:quickalert/models/quickalert_animtype.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:todo_app/Store/local.dart';
import 'package:todo_app/Style/style.dart';
import 'package:todo_app/components/keybord_dis.dart';
import 'package:todo_app/model/todo_model.dart';

import 'home_page.dart';

class EditToDo extends StatefulWidget {
  final ToDoModel todomodel;
  final int index;
  const EditToDo({super.key, required this.todomodel, required this.index});

  @override
  State<EditToDo> createState() => _EditToDoState();
}

class _EditToDoState extends State<EditToDo> {
  TextEditingController note = TextEditingController();
  bool isEmpty = true;
  String oldNote = '';

  @override
  void initState() {
    note.text = widget.todomodel.title;
    oldNote = widget.todomodel.title;

    super.initState();
  }

  @override
  void dispose() {
    note.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        PanaraInfoDialog.show(
          context,
          imagePath: 'assets/image/save.png',
          title: "You didn\'t save note (Siz malumotni saqlamdingiz)",
          message: "othervise you will lose your data",

          panaraDialogType: PanaraDialogType.success,

          barrierDismissible: false, buttonText: 'Back',
          onTapDismiss: () {
            Navigator.pop(context);
          }, // optional parameter (default is true)
        );

        return Future.value(false);
      },
      child: OnUnFocusTap(
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              'Edit Todo',
              style: Style.textStyleSemiRegular(
                  size: 20, textColor: Style.whiteColor),
            ),
            backgroundColor: Color(0xff24A19C),
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: TextFormField(
                  style: Theme.of(context).textTheme.headline2,
                  autofocus: true,
                  controller: note,
                  onChanged: (value) {
                    if (value.isEmpty || oldNote == value) {
                      isEmpty = true;
                    } else {
                      isEmpty = false;
                    }
                    setState(() {});
                  },
                  decoration: InputDecoration(
                      label: Text('Write your notes'),
                      labelStyle: Theme.of(context).textTheme.headline2,
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(35)),
                          borderSide: BorderSide(color: Style.primaryColor)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(35)),
                          borderSide: BorderSide(color: Style.primaryColor))),
                ),
              ),
              150.verticalSpace,
              GestureDetector(
                onTap: () {
                  if (!isEmpty) {
                    LocalStore.editTodo(
                        ToDoModel(
                            title: note.text, isDone: widget.todomodel.isDone),
                        widget.index);

                    QuickAlert.show(
                      // autoCloseDuration: Duration(seconds: 2),
                      animType: QuickAlertAnimType.slideInUp,
                      confirmBtnColor: const Color(0xff24A19C),
                      context: context,
                      type: QuickAlertType.success,
                      text: 'Todo edited Successfully!',
                      onConfirmBtnTap: () {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => HomePage())),
                            (route) => false);
                      },
                    );
                  }
                },
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 400),
                  margin: EdgeInsets.symmetric(horizontal: 24),
                  height: 60.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      gradient: isEmpty
                          ? Style.primaryDisabledGradient
                          : Style.linearGradient,
                      borderRadius: BorderRadius.all(Radius.circular(100))),
                  child: Center(
                    child: Text(
                      'Edit',
                      style: Style.textStyleSemiRegular(
                          textColor: Style.whiteColor),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

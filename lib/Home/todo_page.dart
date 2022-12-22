import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:quickalert/models/quickalert_animtype.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:todo_app/Home/home_page.dart';
import 'package:todo_app/Store/local.dart';
import 'package:todo_app/Style/style.dart';
import 'package:todo_app/components/keybord_dis.dart';
import 'package:todo_app/model/todo_model.dart';

class ToDoPage extends StatefulWidget {
  const ToDoPage({super.key});

  @override
  State<ToDoPage> createState() => _ToDoPageState();
}

class _ToDoPageState extends State<ToDoPage> {
  TextEditingController note = TextEditingController();
  TextEditingController dateOfBirth = TextEditingController();

  bool isEmpty = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    note.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return OnUnFocusTap(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Add Todo',
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
                controller: note,
                onChanged: (value) {
                  if (value.isEmpty) {
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
            Padding(
              padding: const EdgeInsets.only(top: 24, left: 24, right: 24),
              child: TextFormField(
                readOnly: true,
                style: Theme.of(context).textTheme.headline2,
                onChanged: (value) {
                  setState(() {});
                },
                controller: dateOfBirth,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    onPressed: (() {
                      showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1970),
                              lastDate: DateTime.now())
                          .then((value) {
                        dateOfBirth.text = DateFormat('MMMM dd, yyyy')
                            .format(value ?? DateTime.now());
                        setState(() {});
                      });
                    }),
                    icon: SvgPicture.asset(
                      'assets/svg/calendar.svg',
                      height: 24,
                      width: 24,
                      color: Style.primaryColor,
                    ),
                  ),
                  label: Text('Choose the date'),
                  labelStyle: Theme.of(context).textTheme.headline2,
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(35)),
                      borderSide: BorderSide(color: Style.primaryColor)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(35)),
                      borderSide: BorderSide(color: Style.primaryColor)),
                ),
              ),
            ),
            150.verticalSpace,
            GestureDetector(
              onTap: () {
                if (note.text.isNotEmpty) {
                  LocalStore.setTodo(ToDoModel(title: note.text));
                  QuickAlert.show(
                    // autoCloseDuration: Duration(seconds: 2),
                    animType: QuickAlertAnimType.slideInUp,
                    confirmBtnColor: const Color(0xff24A19C),
                    context: context,
                    type: QuickAlertType.success,
                    text: 'Todo added Successfully!',
                    onConfirmBtnTap: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: ((context) => HomePage())),
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
                    'Add',
                    style:
                        Style.textStyleSemiRegular(textColor: Style.whiteColor),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

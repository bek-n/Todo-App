import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rolling_switch/rolling_switch.dart';
import 'package:todo_app/Home/edit_todo.dart';
import 'package:todo_app/Home/todo_page.dart';
import 'package:todo_app/Store/local.dart';
import 'package:todo_app/Style/style.dart';
import 'package:todo_app/main.dart';
import 'package:todo_app/model/todo_model.dart';
import 'dart:io' show Platform;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  List<ToDoModel> listOfTodo = [];
  List<ToDoModel> listOfDone = [];
  TabController? _tabController;
  bool isChangedTheme = true;
  GlobalKey<ScaffoldState> key = GlobalKey();

  @override
  void initState() {
    getInfo();
    _tabController = TabController(length: 2, vsync: this);

    super.initState();
  }

  Future getInfo() async {
    listOfTodo = await LocalStore.getListTodo();
    listOfDone = await LocalStore.getListDone();
    isChangedTheme = await LocalStore.getTheme();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: key,
      drawer: Drawer(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RollingSwitch.icon(
              initialState: !isChangedTheme,
              onChanged: (s) {
                isChangedTheme = !isChangedTheme;
                MyApp.of(context)!.change();
                LocalStore.setTheme(isChangedTheme);
                setState(() {});
              },
              rollingInfoRight: const RollingIconInfo(
                icon: Icons.light_mode,
              ),
              rollingInfoLeft: const RollingIconInfo(
                icon: Icons.dark_mode,
                backgroundColor: Colors.grey,
              ),
            ),

            // Switch(
            //     activeColor: Style.primaryColor,
            //     inactiveThumbColor: Style.whiteColor,
            //     value: !isChangedTheme,
            //     onChanged: (s) {
            //       isChangedTheme = !isChangedTheme;
            //       MyApp.of(context)!.change();
            //       // LocalStore.setTheme(isChangeTheme);
            //       setState(() {});
            //     }),
          ],
        ),
      ),
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Todo List',
        ),
        bottom: TabBar(
            indicatorSize: TabBarIndicatorSize.label,
            indicatorColor: Colors.red,
            unselectedLabelColor: Style.whiteColor,
            labelColor: Style.blackColor,
            controller: _tabController,
            tabs: [
              Tab(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('In Progress'),
                    10.horizontalSpace,
                    Icon(Icons.timelapse)
                  ],
                ),
              ),
              Tab(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Done'),
                    10.horizontalSpace,
                    Icon(Icons.done_all)
                  ],
                ),
              )
            ]),
      ),
      body: Column(
        children: [
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                ListView.builder(
                  itemCount: listOfTodo.length,
                  itemBuilder: ((context, index) => Padding(
                        padding:
                            const EdgeInsets.only(left: 24, right: 24, top: 24),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Style.primaryColor,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30))),
                          child: Row(
                            children: [
                              Checkbox(
                                side: BorderSide(color: Style.whiteColor),
                                activeColor: Color(0xff24A19C),
                                value: listOfTodo[index].isDone,
                                onChanged: ((value) {
                                  listOfTodo[index].isDone =
                                      !listOfTodo[index].isDone;
                                  listOfDone.add(listOfTodo[index]);
                                  LocalStore.setDone(
                                    listOfTodo[index],
                                  );
                                  LocalStore.removeToDo(index);
                                  listOfTodo.removeAt(index);
                                  setState(() {});
                                }),
                              ),
                              Text(
                                listOfTodo[index].title,
                                style: Style.textStyleNormal(
                                    textColor: Style.whiteColor,
                                    isDone: listOfTodo[index].isDone),
                              ),
                              Spacer(),
                              IconButton(
                                  onPressed: (() {
                                    Platform.isIOS
                                        ? showCupertinoDialog(
                                            context: context,
                                            builder: ((context) =>
                                                CupertinoAlertDialog(
                                                  title: Text(
                                                      'Please choose (Tanlang)'),
                                                  actions: [
                                                    TextButton(
                                                        onPressed: (() {
                                                          Navigator.pop(
                                                              context);
                                                          Navigator.of(context)
                                                              .push(
                                                            MaterialPageRoute(
                                                              builder: (_) =>
                                                                  EditToDo(
                                                                todomodel:
                                                                    listOfTodo[
                                                                        index],
                                                                index: index,
                                                              ),
                                                            ),
                                                          );
                                                        }),
                                                        child: Text(
                                                            'Edit (o\'zgartirish)')),
                                                    TextButton(
                                                        onPressed: (() {
                                                          LocalStore.removeToDo(
                                                              index);
                                                          listOfTodo
                                                              .removeAt(index);
                                                          Navigator.pop(
                                                              context);
                                                          setState(() {});
                                                        }),
                                                        child: Text(
                                                            'Delete (o\'chirish)')),
                                                    TextButton(
                                                        onPressed: (() {
                                                          Navigator.pop(
                                                              context);
                                                          setState(() {});
                                                        }),
                                                        child: Text(
                                                            'Cancel (bekor kilish)')),
                                                  ],
                                                )))
                                        : showDialog(
                                            context: context,
                                            builder: ((context) => AlertDialog(
                                                  title: Text(
                                                      'Please choose (Tanlang)'),
                                                  actions: [
                                                    TextButton(
                                                        onPressed: (() {
                                                          Navigator.pop(
                                                              context);
                                                          Navigator.of(context)
                                                              .push(
                                                            MaterialPageRoute(
                                                              builder: (_) =>
                                                                  EditToDo(
                                                                todomodel:
                                                                    listOfTodo[
                                                                        index],
                                                                index: index,
                                                              ),
                                                            ),
                                                          );
                                                        }),
                                                        child: Text(
                                                            'Edit (o\'zgartirish)')),
                                                    TextButton(
                                                        onPressed: (() {
                                                          LocalStore.removeToDo(
                                                              index);
                                                          listOfTodo
                                                              .removeAt(index);
                                                          Navigator.pop(
                                                              context);
                                                          setState(() {});
                                                        }),
                                                        child: Text(
                                                            'Delete (o\'chirish)')),
                                                    TextButton(
                                                        onPressed: (() {
                                                          Navigator.pop(
                                                              context);
                                                          setState(() {});
                                                        }),
                                                        child: Text(
                                                            'Cancel (bekor kilish)')),
                                                  ],
                                                )));
                                  }),
                                  icon: Icon(
                                    Icons.more_vert,
                                    color: Style.whiteColor,
                                  ))
                            ],
                          ),
                        ),
                      )),
                ),
                ListView.builder(
                  itemCount: listOfDone.length,
                  itemBuilder: ((context, index) => Padding(
                        padding:
                            const EdgeInsets.only(left: 24, right: 24, top: 24),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Style.primaryColor,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30))),
                          child: Row(
                            children: [
                              Checkbox(
                                activeColor: Color(0xff1877F2),
                                value: listOfDone[index].isDone,
                                onChanged: ((value) {
                                  listOfDone[index].isDone =
                                      !listOfDone[index].isDone;
                                  listOfTodo.add(listOfDone[index]);
                                  LocalStore.setTodo(
                                    listOfDone[index],
                                  );
                                  LocalStore.removeDone(index);
                                  listOfDone.removeAt(index);

                                  setState(() {});
                                }),
                              ),
                              Text(
                                listOfDone[index].title,
                                style: Style.textStyleNormal(
                                    textColor: Style.whiteColor,
                                    isDone: listOfDone[index].isDone),
                              )
                            ],
                          ),
                        ),
                      )),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: InkWell(
        onTap: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: ((context) => ToDoPage())));
        },
        child: Container(
          width: 65.w,
          height: 65.h,
          decoration: BoxDecoration(
              shape: BoxShape.circle, gradient: Style.linearGradient),
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}

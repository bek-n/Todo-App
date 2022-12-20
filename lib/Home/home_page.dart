import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/Home/edit_todo.dart';
import 'package:todo_app/Home/todo_page.dart';
import 'package:todo_app/Store/local.dart';
import 'package:todo_app/Style/style.dart';
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

  @override
  void initState() {
    getInfo();
    _tabController = TabController(length: 2, vsync: this);

    super.initState();
  }

  Future getInfo() async {
    listOfTodo = await LocalStore.getListTodo();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Style.primaryColor,
        title: Text(
          'Todo List',
          style: Style.textStyleNormal(size: 20, textColor: Colors.white),
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
      body: TabBarView(
        controller: _tabController,
        children: [
          ListView.builder(
            itemCount: listOfTodo.length,
            itemBuilder: ((context, index) => Row(
                  children: [
                    Checkbox(
                      activeColor: Color(0xff24A19C),
                      value: listOfTodo[index].isDone,
                      onChanged: ((value) {
                        listOfTodo[index].isDone = !listOfTodo[index].isDone;
                        LocalStore.editTodo(listOfTodo[index], index);
                        setState(() {});
                      }),
                    ),
                    GestureDetector(
                      onLongPress: () {
                        // ! tugatish kerre!!!!!!!!!!1
                        Platform.isIOS
                            ? showCupertinoDialog(
                                context: context,
                                builder: ((context) => CupertinoAlertDialog(
                                      title: Text('Please choose (Tanlang)'),
                                      actions: [
                                        TextButton(
                                            onPressed: (() {
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: ((context) =>
                                                          EditToDo(
                                                            todomodel:
                                                                listOfTodo[
                                                                    index],
                                                            index: index,
                                                          ))));
                                            }),
                                            child:
                                                Text('Edit (o\'zgartirish)')),
                                        TextButton(
                                            onPressed: (() {
                                              LocalStore.removeToDo(index);
                                              listOfTodo.removeAt(index);
                                              Navigator.pop(context);
                                              setState(() {});
                                            }),
                                            child: Text('Delete (o\'chirish)')),
                                        TextButton(
                                            onPressed: (() {
                                              Navigator.pop(context);
                                            }),
                                            child:
                                                Text('Cancel (bekor kilish)')),
                                      ],
                                    )))
                            : showDialog(
                                context: context,
                                builder: ((context) => Dialog()));
                      },
                      child: Text(
                        listOfTodo[index].title,
                        style: Style.textStyleNormal(
                            isDone: listOfTodo[index].isDone),
                      ),
                    )
                  ],
                )),
          ),
          ListView.builder(
            itemCount: listOfTodo.length,
            itemBuilder: ((context, index) => Row(
                  children: [
                    Checkbox(
                      activeColor: Color(0xff24A19C),
                      value: listOfTodo[index].isDone,
                      onChanged: ((value) {
                        listOfTodo[index].isDone = !listOfTodo[index].isDone;
                        LocalStore.editTodo(listOfTodo[index], index);
                        setState(() {});
                      }),
                    ),
                    GestureDetector(
                      onLongPress: () {
                        // ! tugatish kerre!!!!!!!!!!1
                        Platform.isIOS
                            ? showCupertinoDialog(
                                context: context,
                                builder: ((context) => CupertinoAlertDialog(
                                      title: Text('Please choose'),
                                      actions: [
                                        TextButton(
                                            onPressed: (() {}),
                                            child:
                                                Text('Edit (o\'zgartirish)')),
                                        TextButton(
                                            onPressed: (() {
                                              Navigator.pop(context);
                                            }),
                                            child:
                                                Text('Cancel (bekor kilish)')),
                                      ],
                                    )))
                            : showDialog(
                                context: context,
                                builder: ((context) => Dialog()));
                      },
                      child: Text(
                        listOfTodo[index].title,
                        style: Style.textStyleNormal(
                            isDone: listOfTodo[index].isDone),
                      ),
                    )
                  ],
                )),
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

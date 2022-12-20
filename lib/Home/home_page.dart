import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/Home/todo_page.dart';
import 'package:todo_app/Store/local.dart';
import 'package:todo_app/Style/style.dart';
import 'package:todo_app/model/todo_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<ToDoModel> listOfTodo = [];

  @override
  void initState() {
    getInfo();
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
      ),
      body: ListView.builder(
        itemCount: listOfTodo.length,
        itemBuilder: ((context, index) => Row(
              children: [
                Checkbox(
                  activeColor: Color(0xff24A19C),
                  value: listOfTodo[index].isDone,
                  onChanged: ((value) {
                    listOfTodo[index].isDone = !listOfTodo[index].isDone;
                    LocalStore.setChangeStatus(listOfTodo[index], index);
                    setState(() {});
                  }),
                ),
                Text(
                  listOfTodo[index].title,
                  style:
                      Style.textStyleNormal(isDone: listOfTodo[index].isDone),
                )
              ],
            )),
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

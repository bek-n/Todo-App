import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/model/todo_model.dart';

abstract class LocalStore {
  LocalStore._();

  static setTodo(ToDoModel todo) async {
    SharedPreferences store = await SharedPreferences.getInstance();
    List<String> list = store.getStringList('todo') ?? [];
    String todoJson = jsonEncode(todo.toJson());
    list.add(todoJson);
    store.setStringList('todo', list);
  }

  static editTodo(ToDoModel todo, int index) async {
    SharedPreferences store = await SharedPreferences.getInstance();
    List<String> list = store.getStringList('todo') ?? [];
    List<ToDoModel> listOfTodo = [];
    list.forEach((element) {
      listOfTodo.add(ToDoModel.fromJson(jsonDecode(element)));
    });
    listOfTodo.removeAt(index);
    listOfTodo.insert(index, todo);
    list.clear();
    listOfTodo.forEach((element) {
      list.add(jsonEncode(element.toJson()));
    });
    store.setStringList('todo', list);
  }

  static Future<List<ToDoModel>> getListTodo() async {
    SharedPreferences store = await SharedPreferences.getInstance();
    List<String> list = store.getStringList('todo') ?? [];

    List<ToDoModel> listOfTodo = [];
    list.forEach((element) {
      listOfTodo.add(ToDoModel.fromJson(jsonDecode(element)));
    });
    return listOfTodo;
  }

  static removeToDo(int index) async {
    SharedPreferences store = await SharedPreferences.getInstance();
    List<String> list = store.getStringList('todo') ?? [];
    list.removeAt(index);
    store.setStringList('todo', list);
  }
}

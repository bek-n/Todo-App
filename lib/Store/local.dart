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

  static setDone(ToDoModel todo) async {
    SharedPreferences store = await SharedPreferences.getInstance();
    List<String> list = store.getStringList("done") ?? [];
    String todoJson = jsonEncode(todo.toJson());
    list.add(todoJson);
    store.setStringList("done", list);
  }

  static editLocalDone(ToDoModel todo, int index) async {
    SharedPreferences store = await SharedPreferences.getInstance();
    List<String> list = store.getStringList("done") ?? [];
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
    store.setStringList("done", list);
  }

  static Future<List<ToDoModel>> getListDone() async {
    SharedPreferences store = await SharedPreferences.getInstance();
    List<String> list = store.getStringList("done") ?? [];
    List<ToDoModel> listOfTodo = [];
    list.forEach((element) {
      listOfTodo.add(ToDoModel.fromJson(jsonDecode(element)));
    });
    return listOfTodo;
  }

  static removeDone(int index) async {
    SharedPreferences store = await SharedPreferences.getInstance();
    List<String> list = store.getStringList("done") ?? [];
    list.removeAt(index);
    store.setStringList("done", list);
  }

  static setTheme(bool isLight) async {
    SharedPreferences store = await SharedPreferences.getInstance();
    store.setBool("theme", isLight);
  }

  static Future<bool> getTheme() async {
    SharedPreferences store = await SharedPreferences.getInstance();
    return store.getBool("theme") ?? true;
  }
}

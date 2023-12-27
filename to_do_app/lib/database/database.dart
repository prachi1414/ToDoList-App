import 'package:hive_flutter/hive_flutter.dart';

class ToDoDatabase{

List ToDoList = [];

  //reference hive box 
  final _myBox = Hive.box('myBox');

  //run this method if this is opening this app for first time ever 
  void CreateInitialData(){
    ToDoList=[
      ["Make tutorial", false],
      ["Do exercise", false]
    ];
  }

  //load the data from database 
  
  void loadData(){
   ToDoList = _myBox.get("TODOLIST");
  }

  //update database 

  void updateDatabase(){
  _myBox.put("TODOLIST", ToDoList);
  }
}
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:to_do_app/database/database.dart';
import 'package:to_do_app/util/Dialog_box.dart';
import 'package:to_do_app/util/todo_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
//reference the hive box
final _myBox = Hive.box('myBox');
 
ToDoDatabase db = ToDoDatabase();

void initState()
{

  //if user is opening the app for first time app ever , then create a default data
  if(_myBox.get("TODOLIST") == null){
    db.CreateInitialData();
  }
  else{
    //there are some data 
    db.loadData();
  }

  super.initState();
}

//text controller 
final _controller = TextEditingController();



//checkbox change 
void CheckBoxChanged(bool? value,int index){
  setState(() {
    db.ToDoList[index][1] = !db.ToDoList[index][1];
  }
 );
 db.updateDatabase();
}
//to save new task 
void SaveNewTask(){
  setState(() {
    db.ToDoList.add([ _controller.text, false]);
    _controller.clear();
  });
  Navigator.of(context).pop();
  db.updateDatabase();
}

//create new task
void CreateNewTask(){
  showDialog(
    context: context, 
    builder: (context){
      return DialogBox(
        controller: _controller,
        OnSave: SaveNewTask,
        OnCancel: () => Navigator.of(context).pop(),
      );
    },
  );
}

//delete task 
void deletetask(int index){
  setState(() {
    db.ToDoList.removeAt(index);
  });
db.updateDatabase();
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[200],
      appBar: AppBar(
        title: Text('TO DO'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: CreateNewTask,
        child: Icon(Icons.add),
       ),
      body: ListView.builder(
          itemCount: db.ToDoList.length,
          itemBuilder: (context, index) {
            return ToDoTile(
              taskName: db.ToDoList[index][0],
              taskCompleted: db.ToDoList[index][1],
              onChanged: (value) => CheckBoxChanged(value, index),
              deleteFunction: (context)=> deletetask(index),
            );
          }),
    );
  }
}

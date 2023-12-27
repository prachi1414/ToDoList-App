import 'package:flutter/material.dart';
import 'package:to_do_app/util/my_button.dart';

class DialogBox extends StatelessWidget {
  final controller;
  VoidCallback OnSave;
  VoidCallback OnCancel;

 DialogBox({
    super.key,
    required this.controller,
    required this.OnCancel,
    required this.OnSave,
    });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.yellow[300],
      content: Container(
        height: 120,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            //get user input
            TextField(
            controller: controller,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: "Add new task here",
            ),
            ),
            //buttons save-> cancel
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                //save button 
               MyButton(text: "Save", onPressed: OnSave),

               const SizedBox(width: 8,),
                //cancel button
               
               MyButton(text: "Cancel", onPressed: OnCancel),

              ],
            )
          ],
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:mytodos/buttons.dart';

class TaskDialogBox extends StatelessWidget {
  VoidCallback onSave;
  VoidCallback onCancel;
  final controller;
  TaskDialogBox(
      {Key? key,
      required this.controller,
      required this.onSave,
      required this.onCancel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.redAccent[100],
      content: SizedBox(
          height: 120,
          child: Column(
            children: [
              TextField(
                controller: controller,
                decoration: const InputDecoration(
                  hintText: 'Add New Task',
                  border: OutlineInputBorder(),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  MyButton(text: 'Save', onPressed: onSave),
                  const SizedBox(
                    width: 8,
                  ),
                  MyButton(text: 'Cancel', onPressed: onCancel),
                ],
              )
            ],
          )),
    );
  }
}

import 'package:flutter/material.dart';

class ToDoTile extends StatelessWidget {
  final String taskName;
  final bool checked;
  Function(bool?)? onChanged;
  ToDoTile(
      {Key? key,
      required this.taskName,
      required this.checked,
      required this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25, right: 25, top: 25),
      child: Container(
        padding: const EdgeInsets.all(25),
        decoration: BoxDecoration(
            color: Colors.redAccent, borderRadius: BorderRadius.circular(10)),
        child: Row(
          children: [
            Checkbox(
                value: checked,
                onChanged: onChanged,
                activeColor: Colors.green),
            Text(
              taskName,
              style: TextStyle(
                  fontSize: 20,
                  decoration: checked
                      ? TextDecoration.lineThrough
                      : TextDecoration.none),
            ),
          ],
        ),
      ),
    );
  }
}

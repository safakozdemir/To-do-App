import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ToDoTile extends StatelessWidget {
  final String taskName;
  final bool checked;
  Function(bool?)? onChanged;
  Function(BuildContext)? deleteFunction;
  ToDoTile(
      {Key? key,
      required this.taskName,
      required this.checked,
      required this.onChanged,
      required this.deleteFunction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25, right: 25, top: 25),
      child: Slidable(
        endActionPane: ActionPane(
          motion: const StretchMotion(),
          children: [
            SlidableAction(
              onPressed: deleteFunction,
              icon: Icons.delete,
              backgroundColor: Colors.black38,
              borderRadius: BorderRadius.circular(12),
            ),
          ],
        ),
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
              Expanded(
                child: Text(
                  taskName,
                  style: TextStyle(
                      fontSize: 20,
                      decoration: checked
                          ? TextDecoration.lineThrough
                          : TextDecoration.none),
                ),
              ),
              const Icon(
                Icons.chevron_left,
              )
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:crud_todo_app/common/utils.dart';
import 'package:crud_todo_app/model/category.model.dart';
import 'package:crud_todo_app/model/todo.model.dart';
import 'package:crud_todo_app/ui/widgets/custom_checkbox.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TodoItem extends StatelessWidget {
  const TodoItem({
    Key? key,
    required this.item,
    required this.category,
    this.onEdit,
    this.onRemove,
    this.onCheck,
  }) : super(key: key);

  final Todo item;
  final Category category;
  final Function()? onEdit;
  final Function()? onRemove;
  final Function(bool)? onCheck;

  @override
  Widget build(BuildContext context) {
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actions: !item.isCompleted && !item.finalDate.isDurationNegative
          ? <Widget>[
              IconSlideAction(
                caption: 'Edit',
                color: Color(0xFF4D4E50),
                icon: Icons.edit,
                onTap: onEdit,
              ),
            ]
          : <Widget>[],
      secondaryActions: !item.isCompleted
          ? <Widget>[
              IconSlideAction(
                caption: 'Remove',
                color: Colors.red,
                icon: Icons.delete,
                onTap: onRemove,
              ),
            ]
          : <Widget>[],
      child: ListTile(
        title: Text(
          item.subject,
          style: item.isCompleted
              ? TextStyle(
                  fontSize: 22,
                  color: Color(0xFF6474A9),
                  decoration: TextDecoration.lineThrough,
                )
              : TextStyle(fontSize: 22),
        ),
        subtitle: Text(
          item.finalDate.isDurationNegative
              ? item.finalDate.timeDateToFormattedString
              : item.finalDate.isToday
                  ? item.finalDate.timeFormattedString
                  : item.finalDate.dateTimeToFormattedString,
          style: item.isCompleted
              ? TextStyle(
                  fontSize: 16,
                  decoration: TextDecoration.lineThrough,
                )
              : item.finalDate.isDurationNegative
                  ? TextStyle(
                      fontSize: 16,
                      color: Colors.red,
                    )
                  : TextStyle(fontSize: 16),
        ).paddingSymmetric(v: 4),
        trailing: CustomCheckbox(
          value: item.isCompleted,
          enabled: !item.isCompleted,
          onChanged: onCheck!,
        ),
      ),
    );
  }
}

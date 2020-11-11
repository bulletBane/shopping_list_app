import 'package:flutter/material.dart';
import 'package:shopping_list_app/models/list_items.dart';
import 'package:shopping_list_app/utils/dbhelper.dart';

class ItemsDialog {
  final txtName = TextEditingController();
  final txtQuantity = TextEditingController();
  final txtNote = TextEditingController();

  Widget buildDialog(BuildContext context, ListItem item, bool isNew) {
    DbHelper helper = DbHelper();
    helper.openDb();
    if (!isNew) {
      txtName.text = item.name;
      txtQuantity.text = item.quantity;
      txtNote.text = item.note;
    }
    return AlertDialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
        title: Text((isNew) ? 'New shopping list' : 'Edit shopping list'),
        content: SingleChildScrollView(
          child: Column(children: <Widget>[
            TextField(
                controller: txtName,
                decoration: InputDecoration(hintText: 'Shopping List Name')),
            TextField(
              controller: txtQuantity,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(hintText: 'List item quantity'),
            ),
            TextField(
              controller: txtNote,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(hintText: 'Shopping List item note'),
            ),
            RaisedButton(
              child: Text('Save Shopping List'),
              onPressed: () {
                item.name = txtName.text;
                item.quantity = txtQuantity.text;
                item.note = txtNote.text;
                helper.insertItem(item);
                Navigator.pop(context);
              },
            ),
          ]),
        ));
  }
}

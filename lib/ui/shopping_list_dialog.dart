import 'package:flutter/material.dart';
import '../utils/dbhelper.dart';
import '../models/shopping_list.dart';

class ShoppingListDialog {
  final txtName = TextEditingController();
  final txtPriority = TextEditingController();

  Widget buildDialog(
      BuildContext context, ShoppingList shoppingList, bool isNew) {
    DbHelper helper = DbHelper();
    if (!isNew) {
      txtName.text = shoppingList.name;
      txtPriority.text = shoppingList.priority.toString();
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
              controller: txtPriority,
              keyboardType: TextInputType.number,
              decoration:
                  InputDecoration(hintText: 'Shopping List Priority (1-3)'),
            ),
            RaisedButton(
              child: Text('Save Shopping List'),
              onPressed: () {
                shoppingList.name = txtName.text;
                shoppingList.priority = int.parse(txtPriority.text);
                helper.insertList(shoppingList);
                Navigator.pop(context);
              },
            ),
          ]),
        ));
  }
}

import 'package:flutter/material.dart';
import './utils/dbhelper.dart';
import './models/list_items.dart';
import './models/shopping_list.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Shoppping List',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: ShopingList());
  }
}

class ShopingList extends StatefulWidget {
  @override
  _ShopingListState createState() => _ShopingListState();
}

class _ShopingListState extends State<ShopingList> {
  DbHelper helper = DbHelper();

  Future showData() async {
    await helper.openDb();

    ShoppingList list = ShoppingList(0, 'Bakery', 2);
    int listId = await helper.insertList(list);

    ListItem item = ListItem(0, listId, 'Bread', 'note', '1 kg');
    int itemId = await helper.insertItem(item);

    print('List Id: ' + listId.toString());
    print('Item Id: ' + itemId.toString());
  }

  @override
  Widget build(BuildContext context) {
    showData();
    return Container();
  }
}

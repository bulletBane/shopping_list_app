import 'package:flutter/material.dart';
import 'package:shopping_list_app/ui/items_screen.dart';
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

  List<ShoppingList> shoppingList;

  Future showData() async {
    await helper.openDb();
    shoppingList = await helper.getLists();
    setState(() {
      shoppingList = shoppingList;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    showData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    showData();
    return Container(
      color: Colors.white,
      child: ListView.builder(
          itemCount: (shoppingList != null) ? shoppingList.length : 0,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              color: Colors.white,
              elevation: 2.0,
              child: ListTile(
                  title: Text(shoppingList[index].name),
                  leading: CircleAvatar(
                    child: Text(shoppingList[index].priority.toString()),
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                ItemsScreen(shoppingList[index])));
                  },
                  trailing: IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {},
                  )),
            );
          }),
    );
  }
}
//

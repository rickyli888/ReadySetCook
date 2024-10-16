import 'package:flutter/material.dart';
import 'package:ready_set_cook/screens/storage/widget/storage_row.dart';
import 'package:ready_set_cook/screens/storage/add.dart';
import 'package:ready_set_cook/screens/storage/edit.dart';
import 'package:ready_set_cook/services/grocery.dart';
import 'package:ready_set_cook/models/ingredient.dart';
import 'package:intl/intl.dart';

class Storage extends StatefulWidget {
  @override
  _StorageState createState() => _StorageState();
}

class _StorageState extends State<Storage> {
  GroceryDatabase _groceryDB = null;
  /*
  var _timePeriod = DateTime.now().subtract(const Duration(days: 7));
  var _displayText = "Last Week until now";
  var _pressIndex = 0;
  */
  var  _timePeriod = DateTime(DateTime.now().year, DateTime.now().month - 1, DateTime.now().day);
  var  _displayText = "Last Month until now";
  var  _pressIndex = 1;

  void _weekTapped() {
    _pressIndex = 0;
    _timePeriod = DateTime.now().subtract(const Duration(days: 7));
    _displayText = "Last Week until now";
    setState(() {
      print(_timePeriod);
    });
  }

  void _monthTapped() {
    _pressIndex = 1;
    var _now = new DateTime.now();
    _timePeriod = DateTime(_now.year, _now.month - 1, _now.day);
    _displayText = "Last Month until now";
    setState(() {
      print(_timePeriod);
    });
  }

  void _customTapped(BuildContext ctx) {
    _pressIndex = 2;
    showDatePicker(
            context: ctx,
            initialDate: DateTime.now(),
            firstDate: DateTime(2020),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      _timePeriod = pickedDate;
      String formattedDate = DateFormat('yyyy-MM-dd').format(_timePeriod);
      _displayText = formattedDate + " until now";
      setState(() {
        print(_timePeriod);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_groceryDB == null) {
      _groceryDB = GroceryDatabase(context);
    }
    return Scaffold(
        backgroundColor: Colors.blue[50],
        floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Add()),
              );
            },
            icon: Icon(Icons.add),
            label: Text("Add")),
        body: Column(
          children: [
            Container(
                height: 180,
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 20),
                          child: Text("Select Time Period",
                              style: TextStyle(
                                  color: Colors.blueGrey,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                    Container(
                        margin:
                            EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            ButtonTheme(
                                minWidth: 100.0,
                                height: 50.0,
                                child: RaisedButton(
                                  color: (_pressIndex == 0)
                                      ? Colors.blue
                                      : Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  onPressed: _weekTapped,
                                  child: Text("Last Week",
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: (_pressIndex == 0)
                                              ? Colors.white
                                              : Colors.blueGrey)),
                                )),
                            ButtonTheme(
                                minWidth: 100.0,
                                height: 50.0,
                                child: RaisedButton(
                                  color: (_pressIndex == 1)
                                      ? Colors.blue
                                      : Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  onPressed: _monthTapped,
                                  child: Text("Last Month",
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: (_pressIndex == 1)
                                              ? Colors.white
                                              : Colors.grey)),
                                )),
                            ButtonTheme(
                                minWidth: 100.0,
                                height: 50.0,
                                child: RaisedButton(
                                  color: (_pressIndex == 2)
                                      ? Colors.blue
                                      : Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  onPressed: () => _customTapped(context),
                                  child: Text("Custom",
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: (_pressIndex == 2)
                                              ? Colors.white
                                              : Colors.blueGrey)),
                                )),
                          ],
                        )),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 20),
                          child: Text(_displayText,
                              style: TextStyle(
                                  color: Colors.blueGrey,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                  ],
                )),
            Expanded(
              child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30.0),
                          topRight: Radius.circular(30.0))),
                  child: StreamBuilder(
                      stream: _groceryDB.getGrocerySnap(),
                      builder: (ctx, storageSnapshot) {
                        if (storageSnapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        }
                        final storageSnap = storageSnapshot.data.documents;
                        return ListView.builder(
                            itemCount: storageSnap.length,
                            itemBuilder: (ctx, index) {
                              final String id = storageSnap[index].id;
                              final String name = storageSnap[index]["name"];
                              final String quant =
                                  storageSnap[index]['quantity'];
                              final String unit = storageSnap[index]['unit'];
                              final int shelfLife =
                                  storageSnap[index]['shelfLife'];
                              final String imageUrl =
                                  storageSnap[index]['imageUrl'];
                              final DateTime date = DateTime.parse(
                                  storageSnap[index]['startDate']
                                      .toDate()
                                      .toString());

                              final Ingredient ingredient = Ingredient(
                                  id: id,
                                  name: name,
                                  quantity: quant,
                                  unit: unit,
                                  startDate: date,
                                  shelfLife: shelfLife,
                                  imageUrl: imageUrl);

                              final DateTime foodDate =
                                  storageSnap[index]["startDate"].toDate();
                              if (foodDate.isBefore(_timePeriod)) {
                                return SizedBox(height: 0);
                              }
                              // return a widget that can be slided
                              return Dismissible(
                                onDismissed: (DismissDirection direction) {
                                  // right->left delete, left->right edit
                                  if (direction ==
                                      DismissDirection.endToStart) {
                                    setState(() {
                                      _groceryDB.deleteItem(id);
                                    });
                                    Scaffold.of(context).showSnackBar(SnackBar(
                                        content: Text("$name deleted")));
                                  } else {
                                    setState(() {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  Edit(ingredient)));
                                    });
                                  }
                                },
                                // background for edit
                                background: Container(
                                  child: Center(
                                    child: Text(
                                      'Edit',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                  color: Colors.blue,
                                ),
                                // background for delete
                                secondaryBackground: Container(
                                  child: Center(
                                    child: Text(
                                      'Delete',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                  color: Colors.red,
                                ),
                                child: StorageRow(ingredient),
                                key: UniqueKey(),
                                //direction: DismissDirection.endToStart,
                              );
                            });
                      })),
            )
          ],
        ));
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lord_bank/database/database_helper.dart';
import 'package:lord_bank/models/userData.dart';

class CustomerList extends StatefulWidget {
  const CustomerList({Key key}) : super(key: key);

  @override
  _CustomerListState createState() => _CustomerListState();
}

class _CustomerListState extends State<CustomerList> {
  //List<UserData> _list;
  DatabaseHelper _dbhelper = new DatabaseHelper();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.deepOrangeAccent[200],
        elevation: 1.0,
        title: Text('Customers'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepOrangeAccent[200],
        onPressed: () async {
          await Navigator.pushNamed(context, '/addNewCustomer');
          setState(() {});
        },
        splashColor: Colors.white,
        child: Icon(
          Icons.person_add_alt_1_rounded,
          size: 30,
          color: Colors.white,
        ),
      ),
      body: FutureBuilder<List<UserData>>(
        initialData: [],
        future: _dbhelper.getUserDetails(),
        builder: (context, snapshot) {
          final users = snapshot.data;

          switch(snapshot.connectionState){
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator(),);
            default:
              if(users.isEmpty) {
                return Center(child: Text('No Users. Please add some users'));
              }
              else {
                return buildUsers(users);
              }
          }
        },
      ),
    );
  }

  Widget buildUsers(List<UserData> users) => ListView.separated(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 5,vertical: 8),
        itemCount: users.length,
        separatorBuilder: (context, index) {
          return Divider(
            thickness: 1,
            height: 1,
            indent: 15,
            endIndent: 15,
          );
        },
        itemBuilder: (context, index) {
          final user = users[index];
          return ListTile(
            leading: CircleAvatar(
              radius: 24,
              child: Text(
                user.userName[0],
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
              backgroundColor: Colors.deepOrange[100],
            ),
            title: Padding(
              padding: const EdgeInsets.symmetric(vertical: 7),
              child: Text(user.userName,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600
                ),
              ),
            ),
            subtitle: Text(
              'A/c :  ${user.cardNumber}',
              style: TextStyle(
                fontSize: 16
              ),
            ),
            trailing: Text(
              '₹ ${user.totalAmount.toString()}',
              style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.blue,
              ),
            ),
            onTap: () async {
              await Navigator.of(context).pushNamed('/customer_info', arguments: user);
              setState(() {});
            } ,

            onLongPress: () {
              showMenu(
                color: Colors.deepOrangeAccent[200],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                  ),
                context: context,
                position: RelativeRect.fromLTRB(100, 800, 0, 0),
                items: <PopupMenuEntry>[
                  PopupMenuItem(
                    child: FlatButton.icon(
                      icon: Icon(Icons.delete, color: Colors.white),
                      label: Text(' Delete',
                      style: TextStyle( fontSize: 18, color: Colors.white)),
                      onPressed: () async {
                        await _dbhelper.delete(user.id);
                        Navigator.pop(context);
                        setState(() {});
                      },
                    ),
                  ),
                ],
              );
            },
          );
        },
      );
}

import 'package:flutter/material.dart';
import 'package:lord_bank/models/userData.dart';

class CustomerInfo extends StatefulWidget {
  @override
  _CustomerInfoState createState() => _CustomerInfoState();
}

class _CustomerInfoState extends State<CustomerInfo> {
  UserData user;
  @override
  Widget build(BuildContext context) {
    user = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(user.userName, style: TextStyle(fontSize: 24)),
        elevation: 1,
      ),
      body: Padding(
        padding: EdgeInsets.all(40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                radius: 40,
                child: Icon(
                  Icons.person,
                  size: 50,
                ),
              ),
            ),
            Divider(
              height: 70.0,
              color: Colors.black26,
            ),
            Text(
              'Name  :  ${user.userName}',
              style: TextStyle(fontSize: 25),
            ),
            SizedBox(height: 30,),
            Text('A/c No :  ${user.cardNumber}',
              style: TextStyle(fontSize: 25),),
            SizedBox(height: 30,),
            Text('UPI id   :  ${user.userName.toLowerCase()+user.id.toString()}@gpay',
              style: TextStyle(fontSize: 25),),
            SizedBox(height: 30,),
            Row(
              children: [
                Text('Balance : ',
                  style: TextStyle(
                    fontSize: 25,
                  ),
                ),
                Text(' ₹${user.totalAmount}',
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w600,
                      color: Colors.green
                  ),
                ),
              ],
            ),
            SizedBox(height: 100,),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/transfer_money', arguments: user);
                },
                child: Container(
                  padding: EdgeInsets.all(8),
                  child: Text('Transfer Money',
                    style: TextStyle(fontSize: 25),),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

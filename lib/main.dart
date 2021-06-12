import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lord_bank/screens/addNewCustomer.dart';
import 'package:lord_bank/screens/customer_info.dart';
import 'package:lord_bank/screens/customer_list.dart';
import 'package:lord_bank/screens/home.dart';
import 'package:lord_bank/screens/transaction_history.dart';
import 'package:lord_bank/screens/transfer_money.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => Home(),
        '/customer_list': (context) => CustomerList(),
        '/addNewCustomer': (context) => AddNewCustomer(),
        '/customer_info': (context) => CustomerInfo(),
        '/transaction_history': (context) => TransactionHistory(),
        '/transfer_money': (context) => TransferMoney(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}

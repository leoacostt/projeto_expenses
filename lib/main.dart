import 'package:flutter/material.dart';
import 'package:projeto_expenses/components/chart.dart';
import 'dart:math';
import '../models/transaction.dart';
import 'components/transaction_form.dart';
import 'components/transaction_list.dart';

main() => runApp(ExpensesApp());

class ExpensesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = ThemeData();

    return MaterialApp(
      home: MyHomePage(),
      theme: theme.copyWith(
        colorScheme: theme.colorScheme.copyWith(
          primary: Colors.lightBlueAccent[400],
          secondary: Colors.pinkAccent,
        ),
        textTheme: theme.textTheme.copyWith(
            headline6: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 14,
                fontWeight: FontWeight.normal,
                color: Colors.black),
            headline5: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black)),
        appBarTheme: AppBarTheme(
          titleTextStyle: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _transactions = [
    // Transaction(
    //     id: 't0',
    //     title: 'Conta antiga',
    //     value: 100.76,
    //     date: DateTime.now().subtract(Duration(days: 33))),
  ];

  List<Transaction> get _recentTransactions {
    return _transactions.where((tr) {
      return tr.date.isAfter(DateTime.now().subtract(
        Duration(days: 7),
      ));
    }).toList();
  }

  _openTransactionFormModal(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return TransactionForm(_addTransactions);
        });
  }

  _addTransactions(String title, double value, DateTime date) {
    final newTransaction = Transaction(
      id: Random().nextDouble().toString(),
      title: title,
      value: value,
      date: date,
    );

    setState(() {
      _transactions.add(newTransaction);
    });
    Navigator.of(context).pop();
  }

  _removeTransaction(String id) {
    setState(() {
      _transactions.removeWhere((tr) => tr.id == id); 
    });
  }

  @override
  Widget build(BuildContext context) {  
    final appBar = AppBar(
        title: Text('Despesas Pessoais'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _openTransactionFormModal(context),
          )
        ],
      );
      
    final availableHeight = MediaQuery.of(context).size.height 
      - appBar.preferredSize.height 
      - MediaQuery.of(context).padding.top
      - 25;

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              
              Container(
                height: availableHeight * 0.180,
                child: Chart(_recentTransactions)),
              SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Container(
                  height: availableHeight * 0.05,
                  child: Text(
                    'Lista de transações',
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 18 * MediaQuery.of(context).textScaleFactor,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Container(
                height: availableHeight * 0.75,
                child: TransactionList(_transactions, _removeTransaction)),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _openTransactionFormModal(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

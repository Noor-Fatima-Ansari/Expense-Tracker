import 'package:flutter/material.dart';
import 'model.dart';
import 'package:intl/intl.dart';

class Info extends StatelessWidget {
  final Expense expense;
  Info({super.key, required this.expense});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Expense Details', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.teal,
      ),
      body: Center(
        child: Container(
            height: 400,
            width: 400,

          child: Card(
            color: Colors.teal.withOpacity(0.1),
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Name: ${expense.name}',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.bold)),
                  Text('Amount: ${expense.amount}',
                      style: TextStyle(color: Colors.black, fontSize: 15)),
                  Text('Date: ${DateFormat('yyyy-MM-dd').format(expense.date)}',
                      style: TextStyle(color: Colors.black, fontSize: 15)),
                  Text('Category: ${expense.category}',
                      style: TextStyle(color: Colors.black, fontSize: 15)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

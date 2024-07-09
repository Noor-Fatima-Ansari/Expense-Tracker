import 'package:flutter/material.dart';
import 'Edit.dart';
import 'Home.dart';
import 'infoPage.dart';
import 'model.dart';


class Details extends StatefulWidget {
  final List<Expense> expenses;
  Details({required this.expenses});

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Expenses', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.teal,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: widget.expenses.length,
              itemBuilder: (context, index) {
                final expense = widget.expenses[index];
                return Card(
                  color: Colors.teal.withOpacity(0.1),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Stack(
                      children: [
                        Positioned(
                          right: 1,
                          top: 0,
                          child: InkWell(
                            onTap: () async {
                              final updatedExpense = await showDialog<Expense>(
                                context: context,
                                builder: (context) => EditExpenseDialog(expense: expense),
                              );
                              if (updatedExpense != null) {
                                setState(() {
                                  widget.expenses[index] = updatedExpense;
                                });
                              }
                            },
                            child: Icon(
                              Icons.edit,
                              size: 28,
                              color: Colors.teal,
                            ),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Name: ${expense.name}',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold)),
                            Text('Amount: ${expense.amount}',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 15)),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    shadowColor: Colors.grey,
                                    minimumSize: Size(40, 50),
                                    backgroundColor: Colors.teal,
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Info(expense: expense),
                                      ),
                                    );
                                  },
                                  child: Text('Details',
                                      style: TextStyle(color: Colors.white)),
                                ),
                                IconButton(
                                  icon: Icon(Icons.delete,
                                      size: 28, color: Colors.red),
                                  onPressed: () {
                                    setState(() {
                                      widget.expenses.removeAt(index);
                                    });
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text('Expense Deleted')),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 10),
          FloatingActionButton(
            backgroundColor: Colors.teal,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Home()),
              );
            },
            child: Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

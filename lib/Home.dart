import 'package:flutter/material.dart';
import 'details.dart';
import 'model.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  DateTime? datePicker;
  String? selected = 'Transport';
  TextEditingController nameController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  List<Expense> expenses = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Expense', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(
                    hintText: 'Enter expense name',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.teal),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    hintStyle: const TextStyle(color: Colors.teal, fontSize: 15),
                  ),
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: amountController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.teal),
                    ),
                    hintStyle: const TextStyle(color: Colors.teal, fontSize: 15),
                    hintText: 'Enter amount',
                  ),
                ),
                SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Select date  ',
                        style: TextStyle(
                            color: Colors.teal,
                            fontSize: 19,
                            fontWeight: FontWeight.bold),
                      ),
                      InkWell(
                        child: Icon(
                          Icons.calendar_month,
                          size: 28.0,
                          color: Colors.teal,
                        ),
                        onTap: () async {
                          datePicker = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1000),
                            lastDate: DateTime(2025),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(width: 5),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: const Text(
                        'Categories',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.teal,
                          fontSize: 19,
                        ),
                      ),
                    ),
                    const SizedBox(width: 22),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.teal.withOpacity(0.1),
                          ),
                          child: Column(
                            children: [
                              ListTile(
                                title: const Text(
                                  'Transport',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 15),
                                ),
                                leading: Radio<String>(
                                  activeColor: Colors.teal,
                                  value: 'Transport',
                                  groupValue: selected,
                                  onChanged: (String? value) {
                                    setState(() {
                                      selected = value;
                                    });
                                  },
                                ),
                              ),
                              ListTile(
                                title: const Text(
                                  'Food',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 15),
                                ),
                                leading: Radio<String>(
                                  value: 'Food',
                                  groupValue: selected,
                                  activeColor: Colors.teal,
                                  onChanged: (String? value) {
                                    setState(() {
                                      selected = value;
                                    });
                                  },
                                ),
                              ),
                              ListTile(
                                title: const Text(
                                  'Entertainment',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 15),
                                ),
                                leading: Radio<String>(
                                  value: 'Entertainment',
                                  activeColor: Colors.teal,
                                  groupValue: selected,
                                  onChanged: (String? value) {
                                    setState(() {
                                      selected = value;
                                    });
                                  },
                                ),
                              ),
                              ListTile(
                                title: const Text(
                                  'Other',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 15),
                                ),
                                leading: Radio<String>(
                                  activeColor: Colors.teal,
                                  value: 'Other',
                                  groupValue: selected,
                                  onChanged: (String? value) {
                                    setState(() {
                                      selected = value;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shadowColor: Colors.grey,
                          minimumSize: Size(90, 50),
                          backgroundColor: Colors.teal,
                        ),
                        onPressed: () {
                          if (nameController.text.isNotEmpty &&
                              amountController.text.isNotEmpty &&
                              datePicker != null) {
                            final expense = Expense(
                              name: nameController.text,
                              amount: amountController.text,
                              date: datePicker!,
                              category: selected!,
                            );
                            setState(() {
                              expenses.add(expense);
                            });

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Expense Added')),
                            );

                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Please fill all fields')),
                            );
                          }
                        },
                        child: Text('Save Details',
                            style: TextStyle(color: Colors.white)),
                      ),
                      SizedBox(width: 15),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Details(expenses: expenses),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.teal,
                          shadowColor: Colors.grey,
                          minimumSize: Size(90, 50),
                        ),
                        child: Text('All expenses', style: TextStyle(color: Colors.white)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

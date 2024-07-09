import 'package:flutter/material.dart';
import 'model.dart';

class EditExpenseDialog extends StatefulWidget {
  final Expense expense;
  EditExpenseDialog({required this.expense});

  @override
  _EditExpenseDialogState createState() => _EditExpenseDialogState();
}

class _EditExpenseDialogState extends State<EditExpenseDialog> {
  late TextEditingController nameController;
  late TextEditingController amountController;
  late DateTime selectedDate;
  late String selectedCategory;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.expense.name);
    amountController = TextEditingController(text: widget.expense.amount);
    selectedDate = widget.expense.date;
    selectedCategory = widget.expense.category;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Edit Expense'),
      content: SingleChildScrollView(
        child: Column(
          children: [
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(hintText: 'Enter expense name'),
            ),
            TextFormField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(hintText: 'Enter amount'),
            ),
            Row(
              children: [
                Text('Select date: '),
                TextButton(
                  onPressed: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: selectedDate,
                      firstDate: DateTime(1000),
                      lastDate: DateTime(2000),
                    );
                    if (pickedDate != null && pickedDate != selectedDate) {
                      setState(() {
                        selectedDate = pickedDate;
                      });
                    }
                  },
                  child: Text(
                    "${selectedDate.toLocal()}".split(' ')[0],
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              ],
            ),
            DropdownButton<String>(
              value: selectedCategory,
              items: ['Transport', 'Food', 'Entertainment', 'Other']
                  .map((String category) {
                return DropdownMenuItem<String>(
                  value: category,
                  child: Text(category),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  selectedCategory = newValue!;
                });
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            final updatedExpense = Expense(
              name: nameController.text,
              amount: amountController.text,
              date: selectedDate,
              category: selectedCategory,
            );
            Navigator.pop(context, updatedExpense);
          },
          child: Text('Save'),
        ),
      ],
    );
  }
}

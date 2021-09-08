import 'dart:io';
import 'package:expense_tracker/widgets/adaptive_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransactions extends StatefulWidget {
  final void Function(String, double, DateTime) function;
  NewTransactions(this.function);

  @override
  _NewTransactionsState createState() => _NewTransactionsState();
}

class _NewTransactionsState extends State<NewTransactions> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  dynamic _selectedDate;

  void _submit() {
    final title = titleController.text;
    final amount = double.parse(amountController.text);
    if (title.isEmpty || amount <= 0 || amount.isNaN || _selectedDate == null) {
      return;
    }

    widget.function(title, amount, _selectedDate);

    Navigator.of(context).pop();
  }

  void showDate() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2019),
            lastDate: DateTime.now())
        .then((value) {
      if (value == null) {
        return;
      } else {
        setState(() {
          _selectedDate = value;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
              top: 10,
              left: 10,
              right: 10,
              bottom: MediaQuery.of(context).viewInsets.bottom + 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                controller: titleController,
                onSubmitted: (_) => _submit(),
                decoration: InputDecoration(
                  labelText: "Title",
                ),
              ),
              TextField(
                controller: amountController,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => _submit(),
                decoration: InputDecoration(
                  labelText: "Amount",
                ),
              ),
              Container(
                height: 70,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(_selectedDate == null
                        ? 'No Date Chosen!'
                        : 'Transaction date is ${DateFormat.yMd().format(_selectedDate)}'),
                    AdaptiveButton("Choose Date", showDate),
                  ],
                ),
              ),
              ElevatedButton(
                  onPressed: _submit,
                  child: Text(
                    'Add Transaction',
                    style: TextStyle(
                        color: Theme.of(context).textTheme.button!.color),
                  ),
                  style: TextButton.styleFrom(
                    primary: Colors.purple,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

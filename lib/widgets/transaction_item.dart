import 'dart:math';

import 'package:expense_tracker/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionItem extends StatefulWidget {
  const TransactionItem({
    Key? key,
    required Transaction transaction,
    required void Function(String p1) deleteFunction,
  })  : transaction = transaction,
        _deleteFunction = deleteFunction,
        super(key: key);

  final Transaction transaction;
  final void Function(String p1) _deleteFunction;

  @override
  _TransactionItemState createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem> {
  late Color _bgColor;

  @override
  void initState() {
    const availableColors = [
      Colors.red,
      Colors.blue,
      Colors.green,
      Colors.purple
    ];

    _bgColor = availableColors[Random().nextInt(4)];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
      child: ListTile(
        leading: Container(
          height: 40,
          width: 60,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              shape: BoxShape.rectangle,
              border: Border.all(
                width: 2,
                color: _bgColor,
              )),
          child: Padding(
            padding: EdgeInsets.all(6),
            child: FittedBox(child: Text("\$${widget.transaction.amount}")),
          ),
        ),
        title: Text(
          widget.transaction.title,
          style: Theme.of(context).textTheme.headline6,
        ),
        subtitle:
            Text(DateFormat('yyyy-MM-dd').format(widget.transaction.date)),
        trailing: MediaQuery.of(context).size.width > 500
            ? TextButton.icon(
                style: TextButton.styleFrom(
                  primary: Theme.of(context).errorColor,
                ),
                onPressed: () {
                  widget._deleteFunction(widget.transaction.id);
                },
                icon: Icon(Icons.delete),
                label: Text('Delete Transaction'))
            : IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  widget._deleteFunction(widget.transaction.id);
                },
                color: Theme.of(context).errorColor,
              ),
      ),
    );
  }
}

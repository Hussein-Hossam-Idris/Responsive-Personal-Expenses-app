import 'package:expense_tracker/models/transaction.dart';
import 'package:expense_tracker/widgets/transaction_item.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> _userTransactions;
  final void Function(String) _deleteFunction;
  TransactionList(this._userTransactions, this._deleteFunction);

  @override
  Widget build(BuildContext context) {
    return _userTransactions.isEmpty
        ? LayoutBuilder(
            builder: (context, constraints) {
              return Column(
                children: [
                  Text("No Transactions Added yet",
                      style: Theme.of(context).textTheme.headline6),
                  SizedBox(
                    height: constraints.maxHeight * 0.1,
                  ),
                  Container(
                    height: constraints.maxHeight * 0.6,
                    child: Image.asset(
                      "assets/images/waiting.png",
                      fit: BoxFit.cover,
                    ),
                  )
                ],
              );
            },
          )
        : ListView(
            children: _userTransactions.map((tx) {
            return TransactionItem(
                key: ValueKey(tx.id),
                transaction: tx,
                deleteFunction: _deleteFunction);
          }).toList());
  }
}

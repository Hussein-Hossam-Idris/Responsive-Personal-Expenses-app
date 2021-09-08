import 'package:expense_tracker/models/transaction.dart';
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
        : ListView.builder(
            itemCount: _userTransactions.length,
            itemBuilder: (context, index) {
              return Card(
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                child: ListTile(
                  leading: Container(
                    height: 40,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        shape: BoxShape.rectangle,
                        border: Border.all(
                          width: 2,
                          color: Theme.of(context).primaryColor,
                        )),
                    child: Padding(
                      padding: EdgeInsets.all(6),
                      child: FittedBox(
                          child: Text("\$${_userTransactions[index].amount}")),
                    ),
                  ),
                  title: Text(
                    _userTransactions[index].title,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  subtitle: Text(DateFormat('yyyy-MM-dd')
                      .format(_userTransactions[index].date)),
                  trailing: MediaQuery.of(context).size.width > 500
                      ? TextButton.icon(
                          style: TextButton.styleFrom(
                            primary: Theme.of(context).errorColor,
                          ),
                          onPressed: () {
                            _deleteFunction(_userTransactions[index].id);
                          },
                          icon: Icon(Icons.delete),
                          label: Text('Delete Transaction'))
                      : IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            _deleteFunction(_userTransactions[index].id);
                          },
                          color: Theme.of(context).errorColor,
                        ),
                ),
              );
              // return Card(
              //     elevation: 5,
              //     child: Row(
              //       children: [
              //         Container(
              //           margin: EdgeInsets.symmetric(
              //               vertical: 10, horizontal: 15),
              //           padding: EdgeInsets.all(10),
              //           decoration: BoxDecoration(
              //               borderRadius: BorderRadius.circular(20),
              //               border: Border.all(
              //                 color: Theme.of(context).primaryColor,
              //                 width: 2,
              //               )),
              //           child: Text(
              //             "\$${_userTransactions[index].amount.toStringAsFixed(2)}",
              //             style: TextStyle(
              //               fontWeight: FontWeight.bold,
              //               fontSize: 20,
              //               color: Theme.of(context).primaryColor,
              //             ),
              //           ),
              //         ),
              //         Column(
              //           crossAxisAlignment: CrossAxisAlignment.start,
              //           children: [
              //             Text(
              //               _userTransactions[index].title,
              //               style: Theme.of(context).textTheme.headline6,
              //             ),
              //             SizedBox(
              //               height: 5,
              //             ),
              //             Text(
              //               DateFormat("yyyy-MM-dd")
              //                   .format(_userTransactions[index].date)
              //                   .toString(),
              //               style: TextStyle(color: Colors.grey),
              //             ),
              //           ],
              //         )
              //       ],
              //     ));
            },
          );
  }
}

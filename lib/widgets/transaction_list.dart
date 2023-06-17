import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function removeTransaction;
  TransactionList(this.transactions, this.removeTransaction, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? Column(
            children: <Widget>[
              Text(
                'No transaction added yet!',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                  height: 200,
                  child: Image.asset(
                    'assets/images/waiting.png',
                    fit: BoxFit.cover,
                  )),
            ],
          )
        : ListView.builder(
            itemBuilder: (ctx, index) {
              return Card(
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                elevation: 5,
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    child: Padding(
                        padding: EdgeInsets.all(6),
                        child: FittedBox(
                          child: Text('\$${transactions[index].amount}'),
                        )),
                  ),
                  title: Text(
                    transactions[index].title,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  subtitle:
                      Text(DateFormat.yMMMd().format(transactions[index].date)),
                  trailing: IconButton(
                    onPressed: () => removeTransaction(transactions[index].id),
                    icon: Icon(Icons.delete),
                    color: Theme.of(context).colorScheme.error,
                  ),
                ),
              );
              // return Card(
              //   child: Row(children: <Widget>[
              //     Container(
              //       margin: const EdgeInsets.symmetric(
              //           vertical: 10, horizontal: 15),
              //       padding: const EdgeInsets.all(10),
              //       decoration: BoxDecoration(
              //           border: Border.all(
              //               color: Theme.of(context).primaryColor,
              //               width: 2)),
              //       child: Text(
              //           '\$${transactions[index].amount.toStringAsFixed(2)}',
              //           style: TextStyle(
              //             fontWeight: FontWeight.bold,
              //             fontSize: 20,
              //             color: Theme.of(context).primaryColor,
              //           )),
              //     ),
              //     Column(
              //       crossAxisAlignment: CrossAxisAlignment.start,
              //       children: <Widget>[
              //         Text(transactions[index].title,
              //             style: Theme.of(context).textTheme.titleLarge),
              //         Text(
              //           DateFormat().format(transactions[index].date),
              //           style: const TextStyle(color: Colors.grey),
              //         )
              //       ],
              //     )
              //   ]),
              // );
            },
            itemCount: transactions.length,
          );
  }
}

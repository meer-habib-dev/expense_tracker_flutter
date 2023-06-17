import 'package:expense_tracker/widgets/chart_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class Chart extends StatelessWidget {
  Chart(this.recentTransactions, {Key? key}) : super(key: key);

  final List<Transaction> recentTransactions;

  // List<Map<String, Object>> get groupedTransactionValues {
  //   return List.generate(7, (index) {
  //     final weekDay = DateTime.now().subtract(Duration(days: index));
  //     var totalSum = 0.0;
  //     for (var i = 0; i < recentTransactions.length; i++) {
  //       if (recentTransactions[i].date.day == weekDay.day &&
  //           recentTransactions[i].date.month == weekDay.month &&
  //           recentTransactions[i].date.year == weekDay.year) {
  //         totalSum += recentTransactions[i].amount;
  //       }
  //     }
  //     print(DateFormat.E().format(weekDay).substring(0, 1));
  //     print(totalSum);
  //     return {
  //       'day': DateFormat.E().format(weekDay).substring(0, 1),
  //       "amount": totalSum
  //     };
  //   }).reversed.toList();
  // }

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );
      var totalSum = 0.0;

      for (var i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date.day == weekDay.day &&
            recentTransactions[i].date.month == weekDay.month &&
            recentTransactions[i].date.year == weekDay.year) {
          totalSum += recentTransactions[i].amount;
        }
      }

      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': totalSum,
      };
    }).reversed.toList();
  }

  double get totalSpending {
    return groupedTransactionValues.fold(0.0, (sum, item) {
      return sum + (item['amount'] as double);
    });
  }

  @override
  Widget build(BuildContext context) {
    print(groupedTransactionValues);
    return Card(
      elevation: 6,
      margin: const EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactionValues.map((data) {
            return Flexible(
                fit: FlexFit.tight,
                child: Chart_Bar(
                    data['day'] as String,
                    data['amount'] as double,
                    totalSpending == 0.0
                        ? 0.0
                        : (data['amount'] as double) / totalSpending));
          }).toList(),
        ),
      ),
    );
  }
}

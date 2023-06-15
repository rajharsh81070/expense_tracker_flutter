import 'package:expense_tracker_flutter/models/expense.dart';
import 'package:expense_tracker_flutter/widgets/expenses-list/expense_item.dart';
import 'package:flutter/material.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList({super.key, required this.expenses});

  final List<Expense> expenses;

  Widget expenseItemBuilder(BuildContext context, int index) {
    final expense = expenses[index];
    return ExpenseItem(expense: expense);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: expenseItemBuilder,
      itemCount: expenses.length,
    );
  }
}

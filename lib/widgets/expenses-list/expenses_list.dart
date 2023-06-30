import 'package:expense_tracker_flutter/models/expense.dart';
import 'package:expense_tracker_flutter/widgets/expenses-list/expense_item.dart';
import 'package:flutter/material.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList({
    super.key,
    required this.expenses,
    required this.onRemoveExpense,
  });

  final List<Expense> expenses;
  final void Function(
    String expenseId,
    DismissDirection direction,
  ) onRemoveExpense;

  Widget expenseItemBuilder(BuildContext context, int index) {
    final expense = expenses[index];
    return Dismissible(
      key: ValueKey(expense.id),
      onDismissed: (direction) => onRemoveExpense(
        expense.id,
        direction,
      ),
      background: Container(
        color: Theme.of(context).colorScheme.error.withOpacity(0.75),
        margin: EdgeInsets.symmetric(
          vertical: Theme.of(context).cardTheme.margin!.vertical,
          horizontal: Theme.of(context).cardTheme.margin!.horizontal,
        ),
      ),
      child: ExpenseItem(expense: expense),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: expenseItemBuilder,
      itemCount: expenses.length,
    );
  }
}

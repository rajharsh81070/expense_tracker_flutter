import 'package:expense_tracker_flutter/widgets/chart/chart.dart';
import 'package:expense_tracker_flutter/widgets/expenses-list/expenses_list.dart';
import 'package:expense_tracker_flutter/widgets/new_expense.dart';
import 'package:flutter/material.dart';

import '../models/category.dart';
import '../models/expense.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [
    Expense(
      title: 'Flutter Course',
      amount: 19.99,
      date: DateTime.now(),
      category: Category.work,
    ),
    Expense(
      title: 'Cinema',
      amount: 15.69,
      date: DateTime.now(),
      category: Category.leisure,
    )
  ];

  void _addNewExpense(
    Expense expense,
  ) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  void _removeExpense(String expenseId, DismissDirection direction) {
    final int expenseIndex =
        _registeredExpenses.indexWhere((expense) => expense.id == expenseId);

    final expense = _registeredExpenses[expenseIndex];

    setState(() {
      _registeredExpenses.remove(expense);
    });

    ScaffoldMessenger.of(context).clearSnackBars();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        action: SnackBarAction(
            label: 'Undo',
            onPressed: () {
              setState(() {
                _registeredExpenses.insert(expenseIndex, expense);
              });
            }),
        content: const Text('Expense deleted.'),
      ),
    );
  }

  void _openAddExpenseOverlay() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (ctx) => NewExpense(
        onAddNewExpense: _addNewExpense,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    Widget noExpenseFound = const Center(
      child: Text('No expenses found. Start adding some!'),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Expense Tracker'),
        actions: [
          IconButton(
            onPressed: _openAddExpenseOverlay,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: width < 600
          ? Column(
              children: [
                const SizedBox(height: 8),
                Chart(expenses: _registeredExpenses),
                Expanded(
                  child: _registeredExpenses.isNotEmpty
                      ? ExpensesList(
                          expenses: _registeredExpenses,
                          onRemoveExpense: _removeExpense,
                        )
                      : noExpenseFound,
                ),
              ],
            )
          : Row(
              children: [
                const SizedBox(height: 8),
                Expanded(
                  child: Chart(expenses: _registeredExpenses),
                ),
                Expanded(
                  child: _registeredExpenses.isNotEmpty
                      ? ExpensesList(
                          expenses: _registeredExpenses,
                          onRemoveExpense: _removeExpense,
                        )
                      : noExpenseFound,
                ),
              ],
            ),
    );
  }
}

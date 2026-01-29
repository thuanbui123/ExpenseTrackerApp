import 'package:flutter/material.dart';

import '../widgets/new_todo.dart';
import '../widgets/new_transaction.dart';

class UIHelper {
  static void showNewTransactionSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (_) => const NewTransaction(),
    );
  }

  static void showNewTodoSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (_) => const NewTodo(),
    );
  }
}

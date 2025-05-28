import 'package:flutter/material.dart';
import 'package:learningdart/utilities/dialogs/generic_dialog.dart';

Future<bool> showDeleteDialog(BuildContext context) {
  return showGenericDialog(
    context: context,
    title: "Delete Item",
    content: "Do you really want to delete this item?",
    optionsBuilder: () => {
      'Cancel': false,
      'Delete': true,
    }
  ).then((value) => value ?? false);
}
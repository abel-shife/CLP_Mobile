import 'package:flutter/material.dart';

class SnackBarBuilder extends StatelessWidget {
  final String message;

  const SnackBarBuilder({
    Key key,
    this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SnackBar(
        backgroundColor: Theme.of(context).primaryColor,
        action: SnackBarAction(
          label: "Close",
          textColor: Colors.white,
          onPressed: () {},
        ),
        content: (Text(message)));
  }
}

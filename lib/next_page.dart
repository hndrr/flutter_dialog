import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class NextPage extends StatelessWidget {
  NextPage(this.value);
  final bool value;

  _showAlertDialog(BuildContext context) {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('title'),
          content: Text('Description'),
          actions: <Widget>[
            TextButton(
              child: Text('CANCEL'),
              onPressed: () => {Navigator.pop(context)},
            ),
            TextButton(
              child: Text('OK'),
              onPressed: () => {Navigator.pop(context)},
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance
        .addPostFrameCallback((_) => value ? _showAlertDialog(context) : null);

    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter dialog'),
      ),
      body: Container(
        alignment: Alignment.center,
        color: Colors.grey[100],
        child: Text(
          value.toString(),
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
        ),
      ),
    );
  }
}

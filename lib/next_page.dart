import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class NextPage extends StatelessWidget {
  // ignore: avoid_positional_boolean_parameters
  const NextPage({Key? key, required this.value}) : super(key: key);
  final bool value;

  Future<dynamic> _showAlertDialog(BuildContext context) {
    return showBarModalBottomSheet<Widget>(
      barrierColor: Colors.black.withOpacity(0.4),
      context: context,
      builder: (context) => Container(
        alignment: Alignment.center,
        height: MediaQuery.of(context).size.height / 2,
        margin: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Text('BottomSheet'),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Close BottomSheet'),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance!
        .addPostFrameCallback((_) => value ? _showAlertDialog(context) : null);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter dialog'),
      ),
      body: Container(
        alignment: Alignment.center,
        color: Colors.grey[100],
        child: Text(
          value.toString(),
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.red,
          ),
        ),
      ),
    );
  }
}

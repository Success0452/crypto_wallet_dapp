
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class snackbar extends StatefulWidget {
  final String label;
 const snackbar({Key? key, required this.label}) : super(key: key);

  @override
  State<snackbar> createState() => _snackbarState();
}

class _snackbarState extends State<snackbar> {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: snackBar(label: widget.label),
    );
  }

  snackBar({String? label}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label!),
            const CircularProgressIndicator(
              color: Colors.white,
            )
          ],
        ),
        duration: const Duration(days: 1),
        backgroundColor: Colors.blue,
      ),
    );
  }
}

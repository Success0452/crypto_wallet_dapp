
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class snackbarClear extends StatefulWidget {
  const snackbarClear({Key? key}) : super(key: key);

  @override
  State<snackbarClear> createState() => _snackbarClearState();
}

class _snackbarClearState extends State<snackbarClear> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: snackbarC(),
    );
  }
  snackbarC(){
    ScaffoldMessenger.of(context).clearSnackBars();
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class snackbarStop extends StatefulWidget {
  const snackbarStop({Key? key}) : super(key: key);

  @override
  State<snackbarStop> createState() => _snackbarStopState();
}

class _snackbarStopState extends State<snackbarStop> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: snackbarS(),
    );
  }

  snackbarS(){
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
  }
}

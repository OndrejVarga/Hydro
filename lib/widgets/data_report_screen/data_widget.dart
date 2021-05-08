import 'package:flutter/material.dart';

class DataReportField extends StatelessWidget {
  final Widget inside;

  DataReportField(this.inside);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(20)),
        padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 25),
        child: inside);
  }
}

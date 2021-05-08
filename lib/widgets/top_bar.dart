import 'package:flutter/material.dart';

class TopBar extends StatelessWidget {

  final String text1,text2;
  TopBar(this.text1,this.text2);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 35, horizontal: 25),
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.white, width: 0.7))),
      child: Row(
        children: [
          Text(
            text1,
            style: Theme.of(context).textTheme.headline1.copyWith(fontSize: 20),
          ),
          Text(
            text2,
            style: Theme.of(context).textTheme.headline2.copyWith(fontSize: 20),
          ),
        ],
      ),
    );
  }
}

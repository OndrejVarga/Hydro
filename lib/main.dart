import 'package:Hydro/screens/main_screen.dart';
import './providers/core.dart';
import './utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Hydro',
      theme: MyTheme.getTheme(context),
      home: MultiProvider(
          providers: [ChangeNotifierProvider.value(value: Core())],
          child: MainScreen()),
    );
  }
}

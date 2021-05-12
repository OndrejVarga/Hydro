import 'package:Hydro/widgets/top_bar.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutAppScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              TopBar(
                'About ',
                'app',
                backBtn: true,
              ),
              Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'This app was created with Flutter and Dart by Ondrej Varga',
                      style: Theme.of(context)
                          .textTheme
                          .headline2
                          .copyWith(fontSize: 30),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: GestureDetector(
                          child: Text(
                            "Code for application",
                            style: Theme.of(context)
                                .textTheme
                                .headline2
                                .copyWith(
                                    fontSize: 30,
                                    color: Colors.blue,
                                    decoration: TextDecoration.underline),
                          ),
                          onTap: () async {
                            final url = 'https://github.com/OndrejVarga/Hydro';
                            if (await canLaunch(url)) {
                              await launch(
                                url,
                              );
                            }
                          }),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: GestureDetector(
                          child: Text(
                            "More projects",
                            style: Theme.of(context)
                                .textTheme
                                .headline2
                                .copyWith(
                                    fontSize: 30,
                                    color: Colors.blue,
                                    decoration: TextDecoration.underline),
                          ),
                          onTap: () async {
                            final url = 'https://github.com/OndrejVarga';
                            if (await canLaunch(url)) {
                              await launch(
                                url,
                              );
                            }
                          }),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';


class FadeinImage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: FadeInImage.assetNetwork(placeholder: "assets/lo.gif", image: 'https://icons8.com/preloaders/preloaders/281/Moving%20vertically.gif', )),
    );
  }
}
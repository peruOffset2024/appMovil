import 'package:flutter/material.dart';

class LayoutAmp extends StatefulWidget {
  const LayoutAmp({super.key});

  @override
  State<LayoutAmp> createState() => _LayoutAmpState();
}

class _LayoutAmpState extends State<LayoutAmp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Card(
          child: Image.asset(
            'assets/layout.png',
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}

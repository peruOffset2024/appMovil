import 'package:flutter/material.dart';

class MyFooter extends StatelessWidget {
  const MyFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 600,
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
      ElevatedButton(onPressed: (){}, child: Icon(Icons.home)),
      SizedBox(width: 60,),
      FloatingActionButton(onPressed: (){}),
      SizedBox(width: 60,),
      TextButton(onPressed: (){}, child: Text('hello')),
      
    ],),);
  }
}
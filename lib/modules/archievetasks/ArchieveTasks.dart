import 'package:flutter/material.dart';

class ArchieveTaskpage extends StatelessWidget {
  const ArchieveTaskpage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Archieve Tasks',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 25.0,
        ),
      ),
    );
  }
}

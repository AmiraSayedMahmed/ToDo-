import 'package:flutter/material.dart';
import 'package:todo/shared/components/componants.dart';

class NewTaskpage extends StatelessWidget {
  const NewTaskpage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemBuilder: (context , index) => buildTaskItem(),
        separatorBuilder: (context , index) => Container(
          width: double.infinity,
          color: Colors.grey[300],
          height: 1.0,
        ),
        itemCount: 5 , );
  }
}

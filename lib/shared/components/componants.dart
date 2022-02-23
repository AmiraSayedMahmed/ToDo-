import 'dart:ui';

import 'package:flutter/material.dart';

Widget defaultformfield({
  required TextEditingController controller,
  required TextInputType type,
  VoidCallback? onSubmit,
  VoidCallback? onChange,
  VoidCallback? ontab,
   VoidCallback? validate,
  required String label,
  required IconData prefix,
})=>
  TextFormField(
    controller: controller,
    keyboardType: type,
    onFieldSubmitted:(s){onSubmit!();},
    onChanged:(s){onChange!();} ,
    validator: (s){validate!();},
    onTap: (){ontab!();},
    decoration: InputDecoration(
      labelText: label,
      prefixIcon: Icon(
          prefix
      ),
      border: const OutlineInputBorder(),
    ),


  );

Widget buildTaskItem() => Padding(
  padding: const EdgeInsets.all(20.0),
  child: Row (
    children: [
      CircleAvatar(
        radius: 40.0,
        child: Text(
          '02:00 pm',
        ),
      ),
      SizedBox(
        width: 20.0,
      ),
      Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text (
            'Title Task',
            style: TextStyle(
              fontSize: 16.0 ,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text (
            '14-2-2000',
            style: TextStyle(
              fontSize: 16.0 ,
              color: Colors.grey,
            ),
          ),
        ],
      )
    ],

  ),
);























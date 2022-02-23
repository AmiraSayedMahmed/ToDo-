import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo/modules/archievetasks/ArchieveTasks.dart';
import 'package:todo/modules/donetasks/DoneTasks.dart';
import 'package:todo/shared/components/componants.dart';
import '../modules/newtasks/DoTasks.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:intl/intl.dart';

import 'package:sqflite/sqflite.dart' show Database, openDatabase;

class Homelayout extends StatefulWidget {
  const Homelayout({Key? key}) : super(key: key);

  @override
  _HomelayoutState createState() => _HomelayoutState();
}

class _HomelayoutState extends State<Homelayout> {
  int currentindex = 0;
  List<Widget> pages = [
    NewTaskpage(),
    DoneTaskpage(),
    ArchieveTaskpage(),
  ];
  List<String> titles = [
    'New Tasks',
    'Done Tasks',
    'Archived Tasks',
  ];
  Database? database;
  var scaffoldkey = GlobalKey<ScaffoldState>();
  var formkey = GlobalKey<FormState>();
  bool showbottom = false;
  IconData iconn = Icons.edit;
  var titlecontroller = TextEditingController();
  var timecontroller = TextEditingController();
  var datacontroller = TextEditingController();
  List<Map> tasks =[];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    CreateDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldkey,
      appBar: AppBar(
        title: Text(
          titles[currentindex],
        ),
      ),
      body: pages[currentindex],
      floatingActionButton: FloatingActionButton(
        onPressed: ()  {
          InsertDatabase(
            title: titlecontroller.text,
            time: timecontroller.text,
            date: datacontroller.text,
          );
          if (showbottom) {

              Navigator.pop(context);
              showbottom = false;
              setState(() {
                iconn = Icons.edit;
              });

          } else {
            scaffoldkey.currentState?.showBottomSheet(
              (context) => Form(
                key: formkey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                 children: [
                   Container(
                     child: defaultformfield(
                       controller: titlecontroller,
                       type: TextInputType.text,
                       ontab:(){
                         print ('title tabbed');
                       } ,

                       label: 'task title',
                       prefix: Icons.title,

                     ),
                   ),
                   SizedBox(
                     height:15.0 ,),
                   Container(
                     child: defaultformfield(
                       controller: timecontroller,
                       type: TextInputType.datetime,
                       ontab:(){
                         print ('timing tabbed');
                         showTimePicker(
                             context: context,
                             initialTime: TimeOfDay.now()).then(
                                 (value) {
                               timecontroller.text = value!.format(context);
                             });
                       } ,

                       label: 'task time',
                       prefix: Icons.watch_later_outlined,

                     ),
                   ),
                   SizedBox(
                     height:15.0 ,),
                   Container(
                     child: defaultformfield(
                       controller: datacontroller,
                       type: TextInputType.datetime,
                       ontab:(){
                         print ('timing tabbed');
                         showDatePicker(
                             context: context,
                             initialDate: DateTime.now(),
                             firstDate: DateTime.now(),
                             lastDate: DateTime.parse('2021-12-12')).
                         then((value){
                         print(DateFormat.yMMMd().format(value!));
                         datacontroller.text = DateFormat.yMMMd().format(value);
                         });


                       } ,

                       label: 'task date',
                       prefix: Icons.calendar_today,

                     ),
                   ),
                 ],
                ),
              ),
            ).closed.then((value){
              showbottom = false;
              setState(() {
                iconn = Icons.edit;
              });
            });
            showbottom = true;
            setState(() {
              iconn = Icons.add;
            });
          }
        },
        child: Icon(
          iconn,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentindex,
        onTap: (index) {
          setState(() {
            currentindex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.menu,
            ),
            label: 'Tasks',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.done,
            ),
            label: 'Done',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.archive,
            ),
            label: 'Archieve',
          ),
        ],
      ),
    );
  }



  void CreateDatabase() async {
    database = await openDatabase(
      'todo.db',
      version: 1,
      onCreate: (database, version) async {
        print('database created');
        database
            .execute(
                'CREATE TABLE tasks (id INTEGER PRIMARY KEY ,title TEXT,time TEXT, status TEXT ')
            .then((value) {
          print(tasks[0]);
        }).catchError((e) {
          print(e.toString());
        });
      },
      onOpen: (database) {
        getDatafromDatabase(database).then((value) {
           tasks = value;
        });
        print('database opened');
      },
    );
  }

  Future InsertDatabase({
  required String title,
    required String time,
    required String date,
}) async {
    return await database!.transaction((txn)   =>
      txn
          .rawInsert(
              'INSERT INTO tasks(title,time,status)VALUES("$title","$time","new")')
          .then((value) {
        print('$value inserted');
      }).catchError((e) {
        print('error when inserted ${e.toString()}');
      }),
    );
  }

  Future getDatafromDatabase(database) async
  {
    return await database.rowQuery('SELECT * FROM tasks');
  }
}

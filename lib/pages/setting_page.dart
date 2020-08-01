//import 'package:flutter/material.dart';
//import 'package:intl/intl.dart';
//import 'package:todolistapp/db/task.dart';
//import 'package:todolistapp/db/db_provider.dart';
//
//class SettingPage extends StatefulWidget {
//  final int selfid;
//
//  const SettingPage({Key key, this.selfid}) : super(key: key);
//
//
//  @override
//  _SettingPageState createState() => _SettingPageState();
//}
//
//class _SettingPageState extends State<SettingPage> {
//  Future<List<Task>> selfTask;
//  final udCtrl = TextEditingController();
//
////  var _labelText = 'Set due date';
////
////
////  Future<void> _selectDate(BuildContext context) async {
////    final DateTime selected = await showDatePicker(
////      context: context,
////      initialDate: DateTime.now(),
////      firstDate: DateTime(2020),
////      lastDate: DateTime(2021),
////    );
////    if (selected != null) {
////      setState(() {
////        _labelText = (DateFormat('MM/dd/yyyy HH:mm')).format(selected);
////      });
////    }
////  }
//
//  Future<void> setDb() async{
//    await DbProvider.setDb();
//    selfTask = DbProvider.getSelfDb(widget.selfid);
//    setState(() {});
//  }
//
//  @override
//  void initState() {
//    super.initState();
//    setDb();
//  }
//
//  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: AppBar(
//          title:Text('Setting')
//      ),
//      body: FutureBuilder<List<Task>>(
//          future: selfTask,
//          builder: (BuildContext context, AsyncSnapshot snapshot) {
//            if(snapshot.hasData) {
//              return Column(
//                children: <Widget>[
//                  Expanded(child: Text(snapshot.data))
//                ],
//              );
//            } else{
//              return Expanded(child: Container());
//            }
//          }
//      )
//
//    );
//  }
//}

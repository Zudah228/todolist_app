import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todolistapp/db/task.dart';
import 'package:todolistapp/db/db_provider.dart';

class SettingPage extends StatefulWidget {
  final Task selfdb;

  const SettingPage({Key key, this.selfdb}):super(key: key);

  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  Future<List<Task>> selfTask;
  final udCtrl = TextEditingController();
  bool _validate = false;

  Future<void> setDb() async{
    await DbProvider.setDb();
    selfTask = DbProvider.getSelfDb(widget.selfdb.id);
    setState(() {});
  }

//  var _labelText = 'Set due date';
//
//
//  Future<void> _selectDate(BuildContext context) async {
//    final DateTime selected = await showDatePicker(
//      context: context,
//      initialDate: DateTime.now(),
//      firstDate: DateTime(2020),
//      lastDate: DateTime(2021),
//    );
//    if (selected != null) {
//      setState(() {
//        _labelText = (DateFormat('MM/dd/yyyy HH:mm')).format(selected);
//      });
//    }
//  }

  @override
  void initState() {
    super.initState();
    setDb();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text('Setting'),
        backgroundColor: Colors.grey,
      ),
      body: FutureBuilder<List<Task>>(
          future: selfTask,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            return Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Expanded(
                      child: Column(
                        children: <Widget>[
                          Align(alignment: Alignment.centerLeft,
                              child: Text('title',
                                style: TextStyle(
                                fontSize: 20.0,
                                color: Colors.grey,
                              ),)),
                          TextField(
                            controller: udCtrl,
                            decoration: InputDecoration(
                              hintText: snapshot.data[0].title
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 20.0),
                            child: ButtonTheme(
                              child: RaisedButton(
                                  child: Text("Update"),
                                  color: Colors.grey,
                                  textColor: Colors.white,
                                  onPressed: () async {
                                    udCtrl.text.isEmpty ? _validate = true : _validate = false;
                                    Task newTask = Task(
                                        title: udCtrl.text,
                                    );
                                    if(_validate) {
                                      return null;
                                    } else {
                                      await DbProvider.updateTask(newTask, snapshot.data[0].id);
                                      setDb();
                                    }
                                  }
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            );
          }
      )
    );
  }
}

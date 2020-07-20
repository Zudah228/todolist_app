import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:todolistapp/db/task.dart';
import 'package:todolistapp/db/db_provider.dart';
import 'package:todolistapp/pages/setting_page.dart';
import 'completed_page.dart';


class ListPage extends StatefulWidget {
  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  bool _validate = false;
  Future<List<Task>> tasks;
  final eCtrl = TextEditingController();


  //テーブル消す時に聞くやつ
  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Can I delete?'),
          actions: <Widget>[
            FlatButton(
              child: Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              color: Colors.red,
              child: Text('Delete'),
              onPressed: () {
                DbProvider.deleteTable();
                setDb();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  //タスクの詳細設定
//  Future<void> _setTaskDialog(id, title,) async {
//    return showDialog<void>(
//      context: context,
//      barrierDismissible: true,
//      builder: (BuildContext context) {
//        return AlertDialog(
//          title: Text('Set task'),
//          content: TextField(
//            decoration: InputDecoration(
//              border: InputBorder.none,
//              hintText: 'Write your task',
//              contentPadding: EdgeInsets.only(left: 10),
//              errorText: _validate ? 'Can\'t be empty.' : null,
//            ),
//            controller: udCtrl,
//            onChanged: (title) async{
//              udCtrl.text.isEmpty ? _validate = true : _validate = false;
//              Task newTask = Task(
//                title: udCtrl.text,
//              );
//              _validate ? await DbProvider.updateTask(newTask, id) : null;
//              setDb();
//              udCtrl.clear();
//            },
//          ),
//          actions: <Widget>[
//            FlatButton(
//              child: Text('Close'),
//              onPressed: () {
//                Navigator.of(context).pop();
//              },
//            ),
//            FlatButton(
//              child: Text('update'),
//              color: Colors.blue,
//              onPressed: () async{
//                Task newTask = Task(
//                  title: udCtrl.text,
//                );
//                await DbProvider.updateTask(newTask, id);
//                setDb();
//                udCtrl.clear();
//                Navigator.of(context).pop();
//              },
//            ),
//          ],
//        );
//      },
//    );
//  }

  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  Future<void> setDb() async{
    await DbProvider.setDb();
    tasks = DbProvider.getDb();
    setState(() {
    });
  }

  Task newTask = Task();

  double _formHeight = 75;

  @override
  void initState() {
    super.initState();
    setDb();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Task")),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.check_box,
                color: Colors.white),
              onPressed: () async{
                await Navigator.push(
                  context, MaterialPageRoute(builder: (context) => CompletedPage())
                );
              setDb();
            },
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: _formHeight,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black38,
                  width: 1.0
                ),
                borderRadius: BorderRadius.circular(4)
              ),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Write your task',
                        contentPadding: EdgeInsets.only(left: 10),
                        errorText: _validate ? 'Can\'t be empty.' : null,
                      ),
                      controller: eCtrl,
                    ),
                  ),
                  ButtonTheme(
                    height: _formHeight,
                    child: RaisedButton(
                        child: Text("+"),
                        color: Colors.blue,
                        textColor: Colors.white,
                        onPressed: () async {
                          eCtrl.text.isEmpty ? _validate = true : _validate = false;
                          Task newTask = Task(
                            status: 0,
                            title: eCtrl.text,
                            addedDate: DateTime.now(),
                            completedDate: null
                          );
                          _validate ? null : await DbProvider.insertTask(newTask);
                          setDb();
                          eCtrl.clear();
                        }
                    ),
                  ),
                ],
              ),
            ),
          ),
          FutureBuilder<List<Task>>(
            future: tasks,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return Expanded(
                  child: ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Dismissible(
                          key: ObjectKey(snapshot.data[index]),
                          child: Slidable(
                            actionPane: SlidableDrawerActionPane(),
                            child: ListTile(
                              leading: Icon(Icons.list),
                              title: Text(snapshot.data[index].title),
                              subtitle: Text('Added at ' + DateFormat('MM/dd/yyyy HH:mm').format(snapshot.data[index].addedDate)),
                              trailing: Checkbox(
                                activeColor: Colors.green,
                                value: (snapshot.data[index].status == 1) ? true : false,
                                onChanged: (bool check) async{
                                  if (check) {
                                    newTask = Task (
                                      status: 1,
                                      completedDate: DateTime.now()
                                  );
                                  } else {
                                    newTask = Task (
                                      status: 0,
                                      completedDate: null
                                    );
                                  }
                                  await DbProvider.updateStatus(newTask, snapshot.data[index].id);
                                  setDb();
                                },

                              ),
                            ),
                            secondaryActions: <Widget>[
                              IconSlideAction(
                                caption: 'Setting',
                                color: Colors.grey,
                                icon: Icons.settings,
                                onTap: () async{
                                  await Navigator.push(context, MaterialPageRoute(builder: (context) => SettingPage(selfid: snapshot.data[index].id))
                                  );
                                },
                              ),
                              IconSlideAction(
                                caption: 'Delete',
                                color: Colors.red,
                                icon: Icons.delete,
                                onTap: () async{
                                  await DbProvider.deleteTask(snapshot.data[index].id);
                                  setDb();
                                },
                              ),

                            ],
                          ),
                        );
                      }
                  ),
                );
              } else {
                return Expanded(child: Container());
              }
            }
            ),
        ],
      ),
      bottomNavigationBar: FlatButton.icon(
        icon: Icon(Icons.clear_all),
        label: Text('Delete All Data'),
        onPressed: () {
          _showMyDialog();
        },
          )
      );
  }
}

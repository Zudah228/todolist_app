import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:todolistapp/db/task.dart';
import 'package:todolistapp/db/db_provider.dart';
import 'package:todolistapp/pages/setting_page.dart';

class CompletedPage extends StatefulWidget {
  _CompletedPageState createState() => _CompletedPageState();
}

class _CompletedPageState extends State<CompletedPage> {

  Future<List<Task>> comptasks;

  Future<void> setDb() async{
    await DbProvider.setDb();
    comptasks = DbProvider.getcompDb();
    setState(() {});
  }


  @override

  void initState() {
    super.initState();
    setDb();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Center(child: Text("Completed Task"))
      ),
      body: Column(
        children: <Widget>[
          FutureBuilder<List<Task>>(
            future: comptasks,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return Expanded(
                  child: ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Dismissible(
                        key: ObjectKey(snapshot.data[index]),
                        child: ListTile(
                          leading: Icon(Icons.check),
                          title: Text(snapshot.data[index].title),
                          subtitle: Text('Completed at ' + DateFormat('MM/dd/yyyy HH:mm').format(snapshot.data[index].completedDate)),
                        ),
                      );
                    }),
                );
              } else {
                return Expanded(child: Container(child: LinearProgressIndicator(),),);
              }
              }
          ),
        ],
      )

    );
  }
}

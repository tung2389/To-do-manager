import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../view/widgets/Drawer/drawer.dart';
import '../../view/widgets/Task/task.dart';
import '../../view/widgets/TaskCreator/creator.dart';

class Home extends StatelessWidget {

  Future<String> _getUID() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String uid = prefs.getString('uid');
    return uid;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('To-do manager'),
      ),
      drawer: NavDrawer(),
      body: Container(
        child: FutureBuilder<String>(
          future:  _getUID(),
          builder: (context, AsyncSnapshot<String> uid) {
            if(uid.hasData) {
              return StreamBuilder(
                  stream: Firestore.instance
                                  .collection('user')
                                  .document(uid.data)
                                  .collection('todo')
                                  .snapshots(),
                  builder: (context, snapshot) {
                    if(!snapshot.hasData) {
                      return Center(
                        child: CircularProgressIndicator()
                      );
                    }
                    else {
                      dynamic taskList = snapshot.data.documents;
                      return ListView.builder(
                        padding: EdgeInsets.all(10.0),
                        itemBuilder: (context, index) => TaskView(
                          task: taskList[index].data
                        ) ,
                        itemCount: taskList.length,
                      );
                    }
                  },
                  // buildItem(index, snapshot.data.documents[index]
                  //   child: TaskView(
                  //   task: Task(
                  //     id: '1234',
                  //     name: 'Do your homework',
                  //     importance: 'medium',
                  //     description: 'Do your Math homework',
                  //     startTime: '',
                  //     endTime: '',
                  //     createdAt: ''
                  //   )
                  // ),
              );
            }
            else {
              return Center(
                child: SizedBox(
                  child: CircularProgressIndicator(),
                  width: 60,
                  height: 60,
                ),
              );
            }
          }
        )
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showDialog( 
          context: context,
          barrierDismissible: true,
          builder: (BuildContext context) {
            return CreatorDialog();
          }
        ),
        child: const Icon(Icons.add)
      ),
    );
  }
}
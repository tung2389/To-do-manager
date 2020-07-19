import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../widgets/Task/task.dart';
import '../../../../model/task.dart';

class CompletedTab extends StatelessWidget {
  Future<String> _getUID() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String uid = prefs.getString('uid');
    return uid;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder<String>(
        future:  _getUID(),
        builder: (context, AsyncSnapshot<String> uid) {
          if(uid.hasData) {
            return StreamBuilder(
                stream: Firestore.instance
                                .collection('user')
                                .document(uid.data)
                                .collection('todo')
                                .where('status', isEqualTo: 'completed')
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
                      itemBuilder: (context, index) {
                        Map<String, dynamic> rawTask = taskList[index].data;
                        rawTask['id'] = taskList[index].documentID; //insert ID to Map task
                        Task task = Task.fromMap(rawTask);
                        return TaskView(
                          task: task,
                          parentContext: context,
                          mode: 'view'
                        );
                      }, 
                      itemCount: taskList.length,
                    );
                  }
                },
                // buildItem(index, snapshot.data.documents[index]
                //   child: TaskView(
                //   task: Task(
                //     id: '1234',
                //     title: 'Do your homework',
                //     priority: 'medium',
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
    );
  }
}


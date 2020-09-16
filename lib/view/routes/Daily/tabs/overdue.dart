import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../widgets/Task/Daily/daily.dart';
import '../../../../model/daily.dart';
import '../../../../controller/local.dart';

class OverdueTab extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          SizedBox(height: 20),
          Text('In this tab you can see dailly tasks that you missed yesterday'),
          FutureBuilder<String>(
            future:  LocalData.getUserId(),
            builder: (context, AsyncSnapshot<String> uid) {
              if(uid.hasData) {
                return StreamBuilder(
                    stream: Firestore.instance
                                    .collection('user')
                                    .document(uid.data)
                                    .collection('yesterdayOverdue')
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
                          shrinkWrap: true,
                          padding: EdgeInsets.all(10.0),
                          itemBuilder: (context, index) {
                            Map<String, dynamic> rawTask = taskList[index].data;
                            rawTask['id'] = taskList[index].documentID; //insert ID to Map task
                            DailyTask task = DailyTask.fromMap(rawTask);
                            return DailyTaskView(
                              task: task,
                              parentContext: context,
                              mode: 'viewOverdue',
                            );
                          }, 
                          itemCount: taskList.length,
                        );
                      }
                    },
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
          ),
        ],
      )
    );
  }
}


import 'package:flutter/material.dart';
import '../../widgets/Drawer/drawer.dart';
import '../../widgets/NavigationCard/navCard.dart';
import '../../widgets/yesterdayDailies/yesterdayDailies.dart';
import '../../../controller/local.dart';
import '../../../controller/user.dart';
import '../../../controller/daily.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final int today = DateTime.now().day;
  List<String> dailyTaskStatus;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Home page'),
        ),
        drawer: NavDrawer(),
        body: Container(
          padding: EdgeInsets.all(10.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FutureBuilder<String>(
                  future: LocalData.getUserName(),
                  builder: (context, AsyncSnapshot<String> username){
                    if(username.hasData) {
                      return Text(
                        'Hello ' + username.data  + '. ' + 'Have a nice day!',
                        style: TextStyle(
                          fontSize: 20
                        ),
                      );
                    }
                    else{
                      return SizedBox(
                        child: CircularProgressIndicator(),
                        width: 20,
                        height: 20,
                      );
                    }
                  }
                ),
                SizedBox(height: 20),
                NavCard(
                  route: '/daily',
                  title: 'Check your daily tasks',
                  icon: Icon(
                    Icons.work,
                    color: Colors.green,
                    size: 30.0,
                  )
                ),
                SizedBox(height: 10),
                NavCard(
                  route: '/todo',
                  title: 'Check your to-do tasks',
                  icon: Icon(
                    Icons.access_time,
                    color: Colors.blue,
                    size: 30.0,
                  )
                ),
                FutureBuilder<bool>(
                  future: UserService.checkNewDay(today),
                  builder: (context, AsyncSnapshot<bool> isNewDay) {
                    if(isNewDay.hasData) {
                      if(isNewDay.data) {
                        DailyService
                          .getAllDailyTasks()
                          .then((dailyTaskList) {
                            // Create Overdue tasks list
                            List<Map<String, dynamic>> overdueTasks = new List<Map<String, dynamic>>();
                            dailyTaskStatus = List<String>(dailyTaskList.length);
                            for(int i = 0; i < dailyTaskList.length; i++) {
                              Map<String, dynamic> task = dailyTaskList[i].data;
                              if(task['status'] == 'pending') {
                                task['index'] = i;
                                task['id'] = dailyTaskList[i].documentID;
                                overdueTasks.add(task);
                              }
                              dailyTaskStatus[i] = task['status'];
                            }
                            if(overdueTasks.length > 0) {
                              showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (BuildContext context) {
                                  return YesterdayDailies(
                                    overdueTasks: overdueTasks,
                                    dailyTaskList: dailyTaskList,
                                    dailyTaskStatus: dailyTaskStatus,
                                    changeTaskStatus: (int index, String value) {
                                      dailyTaskStatus[index] = value;
                                    }
                                  );
                                }                             
                              );
                            }
                          });
                      }
                    }
                    return Text('');
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
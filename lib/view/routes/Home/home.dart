import 'package:flutter/material.dart';
import '../../widgets/Drawer/drawer.dart';
import '../../widgets/NavigationCard/navCard.dart';
import '../../widgets/yesterdayDailies/yesterdayDailies.dart';
import '../../../controller/local.dart';
import '../../../controller/user.dart';
import '../../../controller/daily.dart';

class Home extends StatelessWidget {
  final DailyService _dailyService = new DailyService();
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
                FutureBuilder<String>(
                  future: LocalData.getUserId(),
                  builder: (context, AsyncSnapshot<String> userId) {
                    if(userId.hasData) {
                      UserService userService = UserService(
                        uid: userId.data 
                      );
                      int today = DateTime.now().day;
                      userService
                      .checkNewDay(today)
                      .then((isNewDay) {
                        if(isNewDay) {
                          _dailyService
                            .getOverdueTasks()
                            .then((documentsSnapshot) {
                              if(documentsSnapshot.length > 0) {
                                showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (BuildContext context) {
                                    return YesterdayDailies(
                                      overdueTasks: documentsSnapshot,
                                      handleYesterdayDailies: () => _dailyService.handleYesterdayTasks(),
                                      updateLastAccessDay: () => userService.updatelastAccessDay(today)
                                    );
                                  }                             
                                );
                              }
                            });
                        }
                      });
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
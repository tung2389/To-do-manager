import 'package:flutter/material.dart';
import '../../widgets/Drawer/drawer.dart';
import '../../../controller/local.dart';

class Home extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Home page'),
          // bottom: TabBar(
          //   tabs: [
          //     Tab(
          //       text: 'Pending',
          //       icon: Icon(Icons.access_time)
          //     ),
          //     Tab(
          //       text: 'Completed',
          //       icon: Icon(Icons.check)
          //     ),
          //   ],
          // ),
        ),
        drawer: NavDrawer(),
        body: Container(
          padding: EdgeInsets.all(10.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FutureBuilder<String>(
                  future: getUserName(),
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
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  // Add InkWell effect
                  child: Material(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: InkWell(
                      onTap: () {
                        Navigator.pushReplacementNamed(context, '/daily');
                      },
                      child: SizedBox(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            children: <Widget>[
                              Text(
                                'Check your daily tasks',
                                style: TextStyle(
                                  fontSize: 30
                                ),
                              ),
                              Icon(
                                Icons.work,
                                color: Colors.green,
                              )
                            ],
                          ),
                        ),
                        width: MediaQuery.of(context).size.width / 1.6,
                      ),
                    ),
                  ),
                  elevation: 10
                ),
                SizedBox(height: 10),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)
                  ),
                  elevation: 10,
                  child: Icon(
                    Icons.calendar_today,
                    color: Colors.blue,
                  ),
                )
              ],
            ),
          ),
        ),
        // floatingActionButton: FloatingActionButton(
        //   onPressed: () => showDialog( 
        //     context: context,
        //     barrierDismissible: true,
        //     builder: (BuildContext context) {
        //       return TodoCreator();
        //     }
        //   ),
        //   child: const Icon(Icons.add)
        // ),
      ),
    );
  }
}
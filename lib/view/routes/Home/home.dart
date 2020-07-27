import 'package:flutter/material.dart';
import '../../widgets/Drawer/drawer.dart';

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
        // body: TabBarView(
        //   children: [
        //     PendingTab(),
        //     CompletedTab()
        //   ]
        // ),
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
import 'package:flutter/material.dart';
import '../../widgets/Drawer/drawer.dart';
import '../../widgets/Task/Todo/Creator/creator.dart';
import 'tabs/pending.dart';
import 'tabs/completed.dart';

class Todo extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('List of to-do tasks'),
          bottom: TabBar(
            tabs: [
              Tab(
                text: 'Pending',
                icon: Icon(Icons.access_time)
              ),
              Tab(
                text: 'Completed',
                icon: Icon(Icons.check)
              ),
            ],
          ),
        ),
        drawer: NavDrawer(),
        body: TabBarView(
          children: [
            PendingTab(),
            CompletedTab()
          ]
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => showDialog( 
            context: context,
            barrierDismissible: true,
            builder: (BuildContext context) {
              return TodoCreator();
            }
          ),
          child: const Icon(Icons.add)
        ),
      ),
    );
  }
}
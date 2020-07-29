import 'package:flutter/material.dart';

class NavCard extends StatelessWidget {
  final String route;
  final String title;
  final StatelessWidget icon;
  NavCard({this.route, this.title, this.icon});
  @override 
  Widget build(BuildContext context) {
  return Card(
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
          Navigator.pushReplacementNamed(context, route);
        },
        child: SizedBox(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 20
                  ),
                ),
                SizedBox(height: 10),
                icon,
                SizedBox(height: 10),
                Icon(
                  Icons.arrow_forward,
                )
              ],
            ),
          ),
          width: MediaQuery.of(context).size.width / 1.6,
        ),
      ),
    ),
    elevation: 10
    );
  }
}
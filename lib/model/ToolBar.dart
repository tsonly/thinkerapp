import 'package:flutter/material.dart';

Widget ToolBar(width, _scaffold, context) {
  var top = MediaQuery.of(context).padding.top;
  return PreferredSize(preferredSize: Size(width,48),
  child: Card(
      margin: EdgeInsets.all(0),
      child: Container(
        padding: EdgeInsets.only(left: 8,top:top),
        margin: EdgeInsets.all(3),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              child: Text(
                "Thinker",
                style: TextStyle(color: Colors.purple[700]),
              ),
              padding: EdgeInsets.only(left: 8, right: 8),
            ),
            Expanded(
              child: FlatButton(
                  onPressed: () {
                    Navigator.of(_scaffold.currentContext).pushNamed("findpeople");
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Encontre alguém",
                        style: TextStyle(color: Colors.purple[700]),
                      ),
                      SizedBox(height: 8),
                      Container(
                        color: Colors.purple[700],
                        height: 1,
                      )
                    ],
                  )),
            ),
            IconButton(
              icon: Icon(
                Icons.menu,
                color: Colors.purple[700],
              ),
              onPressed: () {},
            )
          ],
        ),
      )));
}

import 'package:flutter/material.dart';

Widget Header(context) {
  return Container(
      padding: EdgeInsets.only(left: 16),
      color: Colors.white60,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: FlatButton(
              onPressed: () {},
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  side: BorderSide(width: 2, color: Colors.purple[700])),
              child: Container(
                  padding:
                      EdgeInsets.only(left: 4, right: 4, top: 8, bottom: 8),
                  child: Column(
                    children: <Widget>[
                      GestureDetector(child:Text(
                        "Compartilhe um momento",
                        style: TextStyle(color: Colors.purple[700]),
                      ), onTap: (){
                        Navigator.of(context).pushNamed("newpost");
                      },),
                    ],
                  )),
            ),
          ),
          SizedBox(
            width: 14,
          ),
          IconButton(
            icon: Icon(
              Icons.image,
              color: Colors.purple[700],
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(
              Icons.videocam,
              color: Colors.purple[700],
            ),
            onPressed: () {},
          )
        ],
      ));
}
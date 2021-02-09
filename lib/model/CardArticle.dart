import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:native_video_view/native_video_view.dart';
import 'package:transparent_image/transparent_image.dart';

Widget CardArticle(item, _scaffold, controller, myId, timeline) {
  var videoController;
  if (item.video.length > 0) {}
  var width = MediaQuery.of(_scaffold.currentContext).size.width;
  var liked = false;
  if (item.like.contains(myId)) {
    liked = true;
  }
  var strTime = "";
  var time = item.timestamp;

  var format = DateFormat("dd/MM/yyyy");

  var date = DateTime.fromMillisecondsSinceEpoch(time);
  var now = DateTime.now();

  var difference = now.difference(date);

  if (difference.inMinutes < 60)
    strTime = "há ${difference.inMinutes} min";
  else if (difference.inHours >= 1 && difference.inDays < 1)
    strTime = "há ${difference.inHours}h";
  else if (difference.inDays >= 1 && difference.inDays < 8)
    strTime = "há ${difference.inDays}d";
  else
    strTime = format.format(date);

  return Card(
      child: Padding(
    padding: EdgeInsets.all(8),
    child: Column(
      children: <Widget>[
        //HEADER
        Row(
          children: <Widget>[
            CircleAvatar(
              child: Icon(Icons.person),
            ),
            SizedBox(
              width: 8,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  item.author,
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
                Text(
                  strTime,
                )
              ],
            ),
            Expanded(
              child: Text(""),
            ),
            Align(
              child: IconButton(
                icon:
                    Icon(Icons.keyboard_arrow_down, color: Colors.purple[700]),
                onPressed: () {
                  _scaffold.currentState.showBottomSheet((context) {
                    return Card(
                      margin: EdgeInsets.all(8),
                      elevation: 4,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ListTile(
                            title: Text(
                              "Compartilhar em...",
                              style: TextStyle(color: Colors.black),
                            ),
                            onTap: () {},
                          ),
                          ListTile(
                            title: Text(
                              "Deixar de seguir ${item.author}",
                              style: TextStyle(color: Colors.black),
                            ),
                            onTap: () {},
                          ),
                          ListTile(
                            title: Text(
                              "Desfazer amizade com ${item.author}",
                              style: TextStyle(color: Colors.black),
                            ),
                            onTap: () {},
                          ),
                          ListTile(
                            title: Text(
                              "Denúnciar publicação",
                              style: TextStyle(color: Colors.black),
                            ),
                            onTap: () {},
                          ),
                          //ListTile(title: Text("" , style: TextStyle(color: Colors.black),), onTap: (){},),
                        ],
                      ),
                    );
                  });
                },
                alignment: Alignment.centerRight,
              ),
            ),
          ],
        ),
        //FIM HEADER

        //BODY

        item.text.length > 0
            ? Container(
                padding: EdgeInsets.all(8),
                child: Text(
                  item.text,
                  style: TextStyle(fontSize: 16),
                ),
                alignment: Alignment.centerLeft,
              )
            : SizedBox(),

        item.image.length > 0
            ? Container(
                width: width,
                height: 200,
                child: FadeInImage.memoryNetwork(
                  fit: BoxFit.cover,
                  placeholder: kTransparentImage,
                  image: item.image[0],
                ))
            : SizedBox(),

        item.video.length > 0
            ? Container(
                width: width,
                height: 200,
                child: NativeVideoView(
                  onCreated: (con) {
                    con.setVideoSource(item.video,
                        sourceType: VideoSourceType.network);
                  },
                  onPrepared: (con, info) {
                    //con.play();
                  },
                  onCompletion: (VideoViewController con) {},
                ))
            : SizedBox(),
        //FIM BODY

        //FOOTER

        //----------likes and comments-----------//
        Container(
            padding: EdgeInsets.only(left: 6, top: 4),
            child: Row(
              children: [
                item.like.length > 0
                    ? Text("${item.like.length} like")
                    : SizedBox()
              ],
            )),
        //---------------------------------------//

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            FlatButton(
              color: liked ? Colors.purple : Colors.white,
              child: Text(
                liked ? "Curtiu" : "Curtir",
                style: TextStyle(color: liked ? Colors.white : Colors.black),
              ),
              onPressed: () async {
                var article =
                    await controller.like(item.id, liked ? "false" : "true");
                article.position = item.position;
                //print(article);
                timeline(article);
              },
            ),
            Container(
              width: 1,
              height: 15,
              color: Colors.grey,
            ),
            FlatButton(
              child: Text("Comentar"),
              onPressed: () {},
            ),
            Container(
              width: 1,
              height: 15,
              color: Colors.grey,
            ),
            FlatButton(
              child: Text("Compartilhar"),
              onPressed: () {},
            )
          ],
        )
        //FIM FOOTER
      ],
    ),
  ));
}

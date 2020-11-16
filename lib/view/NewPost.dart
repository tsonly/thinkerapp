import 'dart:collection';
import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:thinker/apimax/controller/ArticleController.dart';
import 'package:thinker/apimax/database/SecureController.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class NewPost extends StatefulWidget {
  @override
  _NewPostState createState() => _NewPostState();
}

class _NewPostState extends State<NewPost> {
  ArticleController articleController;
  var images = [];
  var state = 0;
  var video = "";
  var buttonText = "Cancelar";
  var controllerText = new TextEditingController();
  Widget videoItem = SizedBox();

  var _scaffold = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    articleController = new ArticleController();
  }

 

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var top = MediaQuery.of(context).padding.top;
    
    return Scaffold(
      //resizeToAvoidBottomInset: false,
      //resizeToAvoidBottomPadding: false,
      key: _scaffold,
      appBar: PreferredSize(
        child: Card(
            margin: EdgeInsets.only(left:0, right:0, top:top),
            
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(left: 8, right: 8),
                  child: Row(
                    children: <Widget>[
                      CircleAvatar(
                        child: Icon(
                          Icons.person,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        children: <Widget>[
                          Text("Tiago Silva"),
                          Text("Público"),
                        ],
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                      ),
                      Expanded(
                        child: Text(""),
                      ),
                      FlatButton(
                        child: Text(buttonText),
                        onPressed: () {
                          if (state == 0)
                            Navigator.of(context).pop();
                          else {
                            share();
                          }
                        },
                      ),
                      SizedBox(
                        width: 8,
                      )
                    ],
                  ),
                ),
              ],
            )),
        preferredSize: Size(width, 48),
      ),
      body: Container(
        padding: EdgeInsets.all(8),
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                margin: EdgeInsets.only(left: 8, right: 8),
                child: TextField(
                  controller: controllerText,
                  onChanged: (text) {
                    setState(() {
                      updateButton();
                    });
                  },
                  maxLines: 4,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "As pessoas estão ansiosas por isso!"),
                ),
              ),
            ),
            if (video.length > 0) videoItem else SizedBox(),
            images.length > 0
                ? Expanded(
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        return Stack(
                          children: [
                            Container(
                                padding: EdgeInsets.all(4),
                                child: Image.file(File(images[index].path))),
                            Container(
                                padding: EdgeInsets.all(4),
                                alignment: Alignment.topRight,
                                child: Container(
                                  child: IconButton(
                                      icon: Icon(
                                        Icons.close,
                                        color: Colors.white,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          images.removeAt(index);
                                          updateButton();
                                        });
                                      }),
                                  color: Color.fromARGB(100, 0, 0, 0),
                                ))
                          ],
                        );

                        //return Container(padding: EdgeInsets.all(4), child: Image.network("https://img-s-msn-com.akamaized.net/tenant/amp/entityid/AAap6Kj.img?h=768&w=1080&m=6&q=60&o=t&l=f&x=924&y=425"));
                      },
                      itemCount: images.length,
                    ),
                  )
                : SizedBox(),
            Row(
              children: [
                IconButton(
                  icon: Icon(
                    Icons.image,
                    color: Colors.purple,
                    size: 30,
                  ),
                  onPressed: () {
                    choiceImages();
                  },
                ),
                IconButton(
                  icon: Icon(
                    Icons.videocam,
                    color: Colors.purple,
                    size: 30,
                  ),
                  onPressed: () {
                    choiceVideo();
                  },
                ),
                FlatButton(
                  child: Text("Escolher uma mídia..."),
                  onPressed: () async {
                    await choiceAny();
                  },
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  choiceAny() async {
    try {
      List<File> files = await FilePicker.getMultiFile(
        type: FileType.custom,
        allowedExtensions: ['jpg', 'jpeg', 'png'],
      );

      if (files.length > 0) {
        setState(() {
          images = files;
          updateButton();
        });
      }
    } catch (e) {}
  }

  choiceVideo() async {
    try {
      File file = await FilePicker.getFile(
        type: FileType.video,
      );

      if (file.path != null) {
        setState(() {
          images.clear();
          video = file.path.toString();
          updateButton();
          createVideo();
        });
      }
    } catch (e) {}
  }

  choiceImages() async {
    try {
      List<File> files = await FilePicker.getMultiFile(
        type: FileType.image,
      );

      if (files.length > 0) {
        setState(() {
          video = "";
          images = files;
          updateButton();
        });
      }
    } catch (e) {}
  }

  void updateButton() {
    if (images.length > 0 ||
        controllerText.text.length > 0 ||
        video.length > 0) {
      buttonText = "Compartilhar";
      state = 1;
    } else {
      buttonText = "Cancelar";
      state = 0;
    }
  }

  createVideo() async {
    VideoThumbnail.thumbnailFile(
            video: video,
            thumbnailPath: (await getTemporaryDirectory()).path,
            imageFormat: ImageFormat.PNG,
            maxHeight: 300,
            quality: 40)
        .then((value) {
      setState(() {
        videoItem = Stack(children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                  padding: EdgeInsets.all(4), child: Image.file(File(value))),
              IconButton(
                icon: Icon(
                  Icons.play_arrow,
                  color: Colors.white,
                ),
                onPressed: () {},
              )
            ],
          ),
          Container(
            alignment: Alignment.topRight,
            padding: EdgeInsets.all(8),
            child: SizedBox(
                child: IconButton(
                    icon: Icon(
                      Icons.close,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      setState(() {
                        video = "";
                        updateButton();
                      });
                    })),
          ),
        ]);
      });
    });
  }

  share() async {
    Map<String, bool> tasks = new HashMap();
    if (images.length > 0) {
      var time = DateTime.now().toString();
      var secure = FlutterSecureStorage();
      var email = await secure.read(key: "email");

      var urls = [];

      for (var element in images) {
        tasks[element.toString()] = false;
        StorageReference ref = FirebaseStorage()
            .ref()
            .child(email)
            .child("posts")
            .child(base64.encode(utf8.encode(element.path.toString())) + "." + time);

        ref.putFile(element).events.listen((event) async {
          if (event.type == StorageTaskEventType.success) {
            var url = await event.snapshot.ref.getDownloadURL();
            urls.add(url);
            tasks[element.toString()] = true;
          }

          if (!tasks.values.contains(false)) {
            var result = await articleController.sendArticle(
                images: urls, video: "", text: controllerText.text);
            if (result) {
              Navigator.of(context).pop();
            } else {
              _scaffold.currentState.showSnackBar(SnackBar(
                content: Text("Houve um problema..."),
                backgroundColor: Colors.redAccent,
              ));
            }
          }
        });
      }
    } else if (video.length > 0) {
      var time = DateTime.now().toString();
      var secure = FlutterSecureStorage();
      var email = await secure.read(key: "email");

        StorageReference ref = FirebaseStorage()
            .ref()
            .child(email)
            .child("posts")
            .child(base64.encode(utf8.encode(video.toString())) + "." + time);

        ref.putFile(File(video)).events.listen((event) async {
          if (event.type == StorageTaskEventType.success) {
            var url = await event.snapshot.ref.getDownloadURL();
            var result = await articleController.sendArticle(
                images: [], video: url, text: controllerText.text);
            if (result) {
              Navigator.of(context).pop();
            } else {
              _scaffold.currentState.showSnackBar(SnackBar(
                content: Text("Houve um problema..."),
                backgroundColor: Colors.redAccent,
              ));
            }
          }
        });
      
    } else {
      var result = await articleController
          .sendArticle(images: [], video: "", text: controllerText.text);
      if (result) {
        Navigator.of(context).pop();
      } else {
        _scaffold.currentState.showSnackBar(SnackBar(
          content: Text("Houve um problema..."),
          backgroundColor: Colors.redAccent,
        ));
      }
      return;
    }
  }
}

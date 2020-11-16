import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:thinker/apimax/controller/ArticleController.dart';
import 'package:thinker/model/CardArticle.dart';
import 'package:thinker/model/Header.dart';
import 'package:thinker/model/ToolBar.dart';
import 'package:thinker/view/AmigosView.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var timeline = [];
  var currentSelected = 0;
  var _controller = PageController(initialPage: 0, keepPage: true);
  var articleController = new ArticleController();
  var _scaffold = GlobalKey<ScaffoldState>();
  var secure = FlutterSecureStorage();
  var myId = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    showTimeline();
  }

  showTimeline() async {
    var line = await articleController.timeline();
    myId = await secure.read(key: "id");
    setState(() {
      timeline = line;
    });
  }

  updateTimeLine(item){
    
    setState(() {
      print(item.position);
      timeline[item.position] = item;
      
    });
    
  }

@override
  void didUpdateWidget(HomePage oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom, SystemUiOverlay.top]);
  }

  @override
  Widget build(BuildContext context) {
    
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        key: _scaffold,
        body: Column(children: [
          ToolBar(width, _scaffold, context),
         Expanded(child:PageView(
          onPageChanged: (selected) {
            setState(() {
              currentSelected = selected;
            });
          },
          controller: _controller,
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            //TIME LINE
            RefreshIndicator(
              onRefresh: ()=>showTimeline(),
              child: ListView.builder(
                padding: EdgeInsets.only(top: 0, left: 4, right: 4, bottom: 4),
                itemBuilder: (context, index) {
                  
                  if (index == 0)
                    return Header(context);
                  else{
                    timeline[index-1].position = index-1;
                    return CardArticle(timeline[index-1], _scaffold, articleController, myId, updateTimeLine);
                  }
                    
                },
                itemCount: timeline.length + 1,
              ),
            ),

            Amigos(),
            Container(child: FlatButton(child: Text("Sair"), onPressed: ()async{
              await secure.deleteAll();
              Navigator.of(context).pushReplacementNamed("splash");
            },),)
          ],
        ),)
        ]),
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.home, color: Colors.grey),
                title: SizedBox(),
                activeIcon: Icon(Icons.home, color: Colors.purple[700])),
            BottomNavigationBarItem(
                icon: Icon(Icons.group, color: Colors.grey),
                title: SizedBox(),
                activeIcon: Icon(Icons.group, color: Colors.purple[700])),
            BottomNavigationBarItem(
                icon: Icon(Icons.notifications, color: Colors.grey),
                title: SizedBox(),
                activeIcon:
                    Icon(Icons.notifications, color: Colors.purple[700])),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.person,
                  color: Colors.grey,
                ),
                title: SizedBox(),
                activeIcon: Icon(Icons.person, color: Colors.purple[700])),
          ],
          currentIndex: currentSelected,
          elevation: 4,
          selectedItemColor: Colors.purple[700],
          onTap: (selected) {
            print(selected);
            setState(() {
              currentSelected = selected;
              _controller.animateToPage(selected,
                  duration: Duration(milliseconds: 400), curve: Curves.easeIn);
            });
          },
        ));
  }


}

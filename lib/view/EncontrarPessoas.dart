import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:thinker/apimax/controller/AccountController.dart';

class EncontrarPessoas extends StatefulWidget {
  @override
  _EncontrarPessoasState createState() => _EncontrarPessoasState();
}

class _EncontrarPessoasState extends State<EncontrarPessoas> {
  var list = [];
  var _controller = TextEditingController();
  var accountController = new AccountController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  search() async {
    if (_controller.text.length > 0) {
      var mList = await accountController.search(_controller.text);
      print(mList);
      setState(() {
        list = mList;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.restoreSystemUIOverlays();
    return Scaffold(
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.all(0),
            color: Colors.purple[700],
            child: Container(
              padding: EdgeInsets.only(top: 30, left: 12, right: 12, bottom: 5),
              child: TextField(
                controller: _controller,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    hintText: "Encontre alguém aqui...",
                    hintStyle: TextStyle(color: Colors.white54),
                    suffixIcon: IconButton(
                      icon: Icon(
                        Icons.search,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        search();
                      },
                    ),
                    border: InputBorder.none),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(0),
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Icon(Icons.person, color: Colors.purple[800],size: 50,),
                  title: Text(list[index]['email']),
                  onTap: () {},
                );
              },
              itemCount: list.length,
            ),
          ),
        ],
      ),
    );
  }
}

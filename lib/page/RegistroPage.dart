import 'package:flutter/material.dart';
import 'package:thinker/apimax/controller/AccountController.dart';

class RegistroPage extends StatefulWidget {
  @override
  _RegistroPageState createState() => _RegistroPageState();
}

class _RegistroPageState extends State<RegistroPage> {

  var acceptTerm = false;
  var accountController = AccountController();
  var emailController = TextEditingController();
  var senhaController = TextEditingController();
  var _scaffold = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffold,
      resizeToAvoidBottomInset: false,
      body: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Thinker",
                style: TextStyle(fontSize: 30, color: Colors.purple, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 100,
              ),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  hintText: "Email",
                  border: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.purple[200], width: 1)),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 2, color: Colors.purple),
                  ),
                ),
              ),
              SizedBox(
                height: 8,
              ),
              TextFormField(
                controller: senhaController,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: "Senha",
                  border: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.purple[200], width: 1)),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 2, color: Colors.purple),
                  ),
                ),
              ),
              CheckboxListTile(title: Text("li e aceito os termos de usúario"), onChanged: (value){setState(() {
                acceptTerm = value;
              });}, value: acceptTerm,),
              SizedBox(
                height: 16,
              ),
              FlatButton(
                
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                padding: EdgeInsets.only(top: 15, bottom:15),
                  child:Container(
                    
                    width: double.infinity,
                    alignment: Alignment.center,
                    child: Text(
                    "REGISTRAR",
                    style: TextStyle(color: Colors.white),
                  
                  ),),
                  onPressed: () async {
                    
                    if(acceptTerm){
                      var result = await accountController.registro(emailController.text, senhaController.text);
                      if(!result){
                        _scaffold.currentState.showSnackBar(SnackBar(content: Text("Email inválido ou em uso", style: TextStyle(color: Colors.white),),backgroundColor: Colors.purple[600],));
                      }else{
                        Navigator.of(context).pushReplacementNamed("home");
                      }
                    }
                    else _scaffold.currentState.showSnackBar(SnackBar(content: Text("Por favor, aceite os termos!", style: TextStyle(color: Colors.white),),backgroundColor: Colors.purple[600],));
                  },
                  color: acceptTerm? Colors.purple:Colors.purple[200],
                ),
                 SizedBox(
                height: 4,
              ),
                FlatButton(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4), side: BorderSide(width: 2, color: Colors.purple)),
                padding: EdgeInsets.only(top: 15, bottom:15),
                  child:Container(
                    width: double.infinity,
                    alignment: Alignment.center,
                    child: Text(
                    "FAZER LOGIN",
                    style: TextStyle(color: Colors.purple),
                  
                  ),),
                  onPressed: () {
                     Navigator.of(context).pushReplacementNamed("login");
                  },
                  color: Colors.white70,
                ),
              
            ],
          )),
    );
  }
}
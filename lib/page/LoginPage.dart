import 'package:flutter/material.dart';
import 'package:thinker/apimax/controller/AccountController.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var accountController = AccountController();
  var emailController = TextEditingController();
  var senhaController = TextEditingController();
  var _scaffold = GlobalKey<ScaffoldState>();

  var opacity = 0.0;
  var up = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(milliseconds: 1500), () {
      setState(() {
        opacity = 1.0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffold,
      resizeToAvoidBottomInset: false,
      body: Container(
          padding: EdgeInsets.all(16),
          child: Stack(
            children: <Widget>[
              AnimatedContainer(
                duration: Duration(milliseconds: 800),
                curve: Curves.easeIn,
                margin: opacity == 0.0
                    ? EdgeInsets.zero
                    : EdgeInsets.only(top: 100),
                alignment:
                    opacity == 0.0 ? Alignment.center : Alignment.topCenter,
                child: Text(
                  "Thinker",
                  style: TextStyle(
                      fontSize: 50,
                      color: Colors.purple,
                      fontWeight: FontWeight.bold),
                ),
              ),
              AnimatedOpacity(
                opacity: opacity,
                duration: Duration(milliseconds: 1000),
                curve: Curves.easeIn,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    SizedBox(
                      height: 100,
                    ),
                    TextFormField(
                      controller: emailController,
                      decoration: InputDecoration(
                        hintText: "Email",
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.purple[200], width: 1)),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 2, color: Colors.purple),
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
                            borderSide: BorderSide(
                                color: Colors.purple[200], width: 1)),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 2, color: Colors.purple),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    FlatButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4)),
                      padding: EdgeInsets.only(top: 15, bottom: 15),
                      child: Container(
                        width: double.infinity,
                        alignment: Alignment.center,
                        child: Text(
                          "ENTRAR",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      onPressed: () async {
                        print("LOGIN");
                        var result = await accountController.login(
                            emailController.text, senhaController.text);
                        if (result) {
                          Navigator.of(context).pushReplacementNamed("home");
                        } else {
                          _scaffold.currentState.showSnackBar(SnackBar(
                            content: Text(
                              "Usúario não encontrado",
                              style: TextStyle(color: Colors.white),
                            ),
                            backgroundColor: Colors.purple[600],
                          ));
                        }
                      },
                      color: Colors.purple,
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    FlatButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                          side: BorderSide(width: 2, color: Colors.purple)),
                      padding: EdgeInsets.only(top: 15, bottom: 15),
                      child: Container(
                        width: double.infinity,
                        alignment: Alignment.center,
                        child: Text(
                          "CRIAR UMA CONTA",
                          style: TextStyle(color: Colors.purple),
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).pushNamed("registro");
                      },
                      color: Colors.white70,
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}

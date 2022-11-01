import 'package:flutter/material.dart';
import 'package:flutter_praktek_ujikom/dashboard.dart';
import 'package:flutter_praktek_ujikom/Profile.dart';
import 'package:flutter_praktek_ujikom/main.dart';
import 'package:flutter_praktek_ujikom/model/sql_helper.dart';
import 'package:flutter_praktek_ujikom/register.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatelessWidget {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> setSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setString("email", usernameController.text);
    await prefs.setString("password", passwordController.text);
  }

  List<Map<String, dynamic>> _dataUser = [];
  static List<String> loggedUser = [];

  void ReadDatabase() async {
    final data = await SQLHelper.getItems();

    setState() {
      _dataUser = data;
    }
  }

  @override
  initState() {
    ReadDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 100.0, bottom: 100.0),
              child: Text(
                'PINK',
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontFamily: 'Catenaccio',
                    fontSize: 100,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 50.0, right: 50.0, bottom: 20.0),
              child: TextFormField(
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    hintText: "Input Username",
                    hintStyle: TextStyle(color: Colors.white),
                    fillColor: Colors.white),
                controller: usernameController,
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 50.0, right: 50.0, bottom: 20.0),
              child: TextFormField(
                style: TextStyle(color: Colors.white),
                obscureText: true,
                decoration: InputDecoration(
                  hintText: "Input Password",
                  hintStyle: TextStyle(color: Colors.white),
                  fillColor: Colors.white,
                ),
                controller: passwordController,
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 50.0, right: 50.0),
              child: MaterialButton(
                  minWidth: double.infinity,
                  textColor: Colors.white,
                  height: 50.0,
                  color: Colors.pinkAccent[400],
                  onPressed: () {
                    // Text('Username ${_dataUser[0]['username']}');
                    int lenght = _dataUser.length;
                    var i = 0;
                    for (i = 0; i < lenght; i++) {
                      if (_dataUser[i]['username'] == usernameController.text &&
                          _dataUser[i]['password'] == passwordController.text) {
                        loggedUser[0] = usernameController.text;
                        loggedUser[1] = passwordController.text;
                        loggedUser[2] = _dataUser[i]['nama'];
                        loggedUser[3] = _dataUser[i]['no_telp'];
                        setSharedPreferences();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Dashboard()));
                      }
                      if (i == lenght) {}
                    }
                  },
                  child: Text("LOGIN")),
            ),
            Container(
              margin: EdgeInsets.only(top: 50.0),
              child: Text(
                'Belum memiliki akun?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10.0),
              child: TextButton(
                style: TextButton.styleFrom(
                    textStyle: const TextStyle(
                        fontSize: 12,
                        color: Colors.blue,
                        decoration: TextDecoration.underline)),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Register()));
                },
                child: const Text("Daftar!"),
              ),
            )
          ],
        ),
      ),
      backgroundColor: Colors.pink[600],
    );
  }
}

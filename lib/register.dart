import 'package:flutter/material.dart';
import 'package:flutter_praktek_ujikom/Profile.dart';
import 'package:flutter_praktek_ujikom/login.dart';
import 'package:flutter_praktek_ujikom/main.dart';
import 'package:flutter_praktek_ujikom/model/myEncrypter.dart';
import 'package:flutter_praktek_ujikom/model/sql_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Register extends StatelessWidget {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController namaController = TextEditingController();
  TextEditingController nomorController = TextEditingController();

  Future<void> setSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setString("username", usernameController.text);
    await prefs.setString("password", passwordController.text);
  }

  Future<void> addItem() async {
    var plainText = MyEncryptionDecryption.encryptAES(passwordController.text);
    await SQLHelper.createItem(usernameController.text, plainText.base64,
        namaController.text, nomorController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView(
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
                decoration: InputDecoration(
                    hintText: "Input nama",
                    hintStyle: TextStyle(color: Colors.white),
                    fillColor: Colors.white),
                controller: namaController,
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 50.0, right: 50.0, bottom: 20.0),
              child: TextFormField(
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    hintText: "Input nomor telpon",
                    hintStyle: TextStyle(color: Colors.white),
                    fillColor: Colors.white),
                controller: nomorController,
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
                    // setSharedPreferences();
                    addItem();
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('!'),
                    ));
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginPage()));
                  },
                  child: Text("REGISTER")),
            ),
            Container(
                margin: EdgeInsets.only(top: 10, left: 50, right: 50),
                child: Text(
                  'Sudah memiliki akun?',
                  style: TextStyle(color: Colors.white),
                )),
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
                      MaterialPageRoute(builder: (context) => LoginPage()));
                },
                child: const Text("Login!"),
              ),
            )
          ],
        ),
      ),
      backgroundColor: Colors.pink[600],
    );
  }
}

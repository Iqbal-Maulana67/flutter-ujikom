import 'package:flutter/material.dart';
import 'package:flutter_praktek_ujikom/dashboard.dart';
import 'package:flutter_praktek_ujikom/model/myEncrypter.dart';
import 'package:flutter_praktek_ujikom/model/sql_helper.dart';
import 'package:flutter_praktek_ujikom/register.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Profile.dart';
import 'GPS.dart';
import 'login.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var username = prefs.getString('username');
  print(username);
  runApp(MaterialApp(home: username == null ? MyLogin() : Dashboard()));
  // runApp(MyLogin());
}

class MyLogin extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  static String? _username = "";
  static String? _nama = "";
  static String? _password = "";
  static String? _no_telp = "";

  Future<void> setSharedPreferences(String index, String username,
      String password, String nama, String no_telp) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setString('index', index);
    await prefs.setString("username", username);
    await prefs.setString("password", password);
    await prefs.setString("nama", nama);
    await prefs.setString("no_telp", no_telp);
  }

  List<Map<String, dynamic>> _dataUser = [];

  void ReadDatabase() async {
    final data = await SQLHelper.getItems();

    setState(() {
      _dataUser = data;
    });
  }

  @override
  void initState() {
    super.initState();
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
                    print(lenght);
                    for (i = 0; i < lenght; i++) {
                      print('${_dataUser[i]['username']}');
                      var plainText = MyEncryptionDecryption.encryptAES(
                          passwordController.text);
                      if (_dataUser[i]['username'] == usernameController.text &&
                          _dataUser[i]['password'] == plainText.base64) {
                        setSharedPreferences(
                            _dataUser[i]['id'].toString(),
                            _dataUser[i]['username'],
                            _dataUser[i]['password'],
                            _dataUser[i]['nama'],
                            _dataUser[i]['no_telp']);

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

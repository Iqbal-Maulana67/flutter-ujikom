import 'package:flutter/material.dart';
import 'package:flutter_praktek_ujikom/Profile.dart';
import 'package:flutter_praktek_ujikom/main.dart';
import 'package:flutter_praktek_ujikom/GPS.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Dashboard extends StatelessWidget {
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text("PINK Dashboard"),
        backgroundColor: Colors.pink[600],
      ),
      body: Center(
          child: Text(
        'Selamat datang!',
        style: TextStyle(fontSize: 35),
      )),
      drawer: MyDrawer(onTap: (ctx, i) {
        index = i;
        Navigator.pop(ctx);
      }),
    ));
  }
}

class MyDrawer extends StatelessWidget {
  final Function onTap;

  MyDrawer({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.8,
      child: Drawer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            ListTile(
                leading: Icon(Icons.home),
                title: Text('Profile'),
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Profile()))),
            ListTile(
                leading: Icon(Icons.person),
                title: Text('GPS'),
                onTap: () => Navigator.push(
                    context, MaterialPageRoute(builder: (context) => GPS()))),
            Divider(
              height: 1,
            ),
            ListTile(
                leading: Icon(Icons.exit_to_app),
                title: Text('Logout'),
                onTap: () async {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  prefs.remove('index');
                  prefs.remove('username');
                  prefs.remove('password');
                  prefs.remove('nama');
                  prefs.remove('no_telp');
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext ctx) => LoginPage()));
                }),
          ],
        ),
      ),
    );
  }
}

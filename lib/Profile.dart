import 'package:flutter/material.dart';
import 'package:flutter_praktek_ujikom/main.dart';
import 'package:flutter_praktek_ujikom/model/sql_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  List<Map<String, dynamic>> loggedUser = [];
  List<Map<String, dynamic>> _dataUser = [];

  void readLoggedUser(String index) async {
    final data = await SQLHelper.getItem(int.parse(index));

    setState(() {
      loggedUser = data;
    });
  }

  void readDatabase() async {
    final data = await SQLHelper.getItems();

    setState(() {
      _dataUser = data;
    });
  }

  String _username = 'default';
  String _password = '';
  String _no_telp = '';
  String _nama = '';

  void convertNullable(String? s) {}

  _getPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // _username = prefs.getString('username');
    // _password = prefs.getString('password');
    // _no_telp = prefs.getString('no_telp');
    // _nama = prefs.getString('nama');
    String? index;
    if (prefs.getString('index') != null) {
      index = prefs.getString('index');
      readLoggedUser(index.toString());
    }
  }

  void _deleteItem(int id) async {
    await SQLHelper.deleteItem(id);
    // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
    //   content: Text('Successfully deleted a journal!'),
    // ));
    readDatabase();
  }

  Future<void> _updateItem(int id) async {
    await SQLHelper.updateItem(
        id,
        _usernameController.text,
        _passwordController.text,
        _namaController.text,
        _no_telpController.text);
    readDatabase();
  }

  String? getData(String filter) {
    int length = loggedUser.length;
    for (var i = 0; i < length; i++) {
      if (filter == 'username') {
        return loggedUser[i]['username'];
      }
      if (filter == 'password') {
        return loggedUser[i]['password'];
      }
      if (filter == 'nama') {
        return loggedUser[i]['nama'];
      }
      if (filter == 'no_telp') {
        return loggedUser[i]['no_telp'];
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _getPreferences();
    readDatabase();
    print(_username);
  }

  TextEditingController _usernameController = TextEditingController();
  TextEditingController _namaController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _no_telpController = TextEditingController();

  void _showForm(int? id) async {
    if (id != null) {
      // id == null -> create new item
      // id != null -> update an existing item
      final existingJournal =
          _dataUser.firstWhere((element) => element['id'] == id);
      _usernameController.text = existingJournal['username'];
      _namaController.text = existingJournal['nama'];
      _passwordController.text = existingJournal['password'];
      _no_telpController.text = existingJournal['no_telp'];
    }

    showModalBottomSheet(
        context: context,
        elevation: 5,
        isScrollControlled: true,
        builder: (_) => Container(
              padding: EdgeInsets.only(
                top: 15,
                left: 15,
                right: 15,
                // this will prevent the soft keyboard from covering the text fields
                bottom: MediaQuery.of(context).viewInsets.bottom + 120,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Username',
                    style: TextStyle(color: Colors.grey),
                  ),
                  TextField(
                    controller: _usernameController,
                    decoration: const InputDecoration(hintText: 'Username'),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Password',
                    style: TextStyle(color: Colors.grey),
                  ),
                  TextField(
                    controller: _passwordController,
                    decoration: const InputDecoration(hintText: 'Password'),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Nama',
                    style: TextStyle(color: Colors.grey),
                  ),
                  TextField(
                    controller: _namaController,
                    decoration: const InputDecoration(hintText: 'Nama'),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'No. Telepon',
                    style: TextStyle(color: Colors.grey),
                  ),
                  TextField(
                    controller: _no_telpController,
                    decoration: const InputDecoration(hintText: 'No. Telepon'),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      // Save new journal
                      // if (id == null) {
                      //   await _addItem();
                      // }

                      if (id != null) {
                        await _updateItem(id);
                      }

                      // Clear the text fields
                      _usernameController.text = '';
                      _passwordController.text = '';
                      _namaController.text = '';
                      _no_telpController.text = '';

                      // Close the bottom sheet
                      Navigator.of(context).pop();
                    },
                    child: Text(id == null ? 'Create New' : 'Update'),
                  )
                ],
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text("PINK Profile"),
        backgroundColor: Colors.pink[600],
      ),
      body: Center(
        child: ListView.builder(
          itemCount: _dataUser.length,
          itemBuilder: (context, index) => Card(
            color: Colors.amber[200],
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        margin: EdgeInsets.all(10),
                        child: Text(
                          "ID : ${_dataUser[index]['id']}",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(10),
                        child: Text(
                          "Username",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 25, top: 5, bottom: 5),
                        child: Text("${_dataUser[index]['username']}"),
                      ),
                      Container(
                        margin: EdgeInsets.all(10),
                        child: Text(
                          "Password",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 25, top: 5, bottom: 5),
                        child: Text("${_dataUser[index]['password']}"),
                      ),
                      Container(
                        margin: EdgeInsets.all(10),
                        child: Text(
                          "Nama",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 25, top: 5, bottom: 5),
                        child: Text("${_dataUser[index]['nama']}"),
                      ),
                      Container(
                        margin: EdgeInsets.all(10),
                        child: Text(
                          "No Telpon",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 25, top: 5, bottom: 5),
                        child: Text("${_dataUser[index]['no_telp']}"),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Flexible(
                              fit: FlexFit.tight, flex: 1, child: SizedBox()),
                          Flexible(
                              fit: FlexFit.tight,
                              flex: 3,
                              child: ElevatedButton(
                                onPressed: () {
                                  _showForm(_dataUser[index]['id']);
                                },
                                child: Text("Ubah"),
                              )),
                          Flexible(
                              fit: FlexFit.tight, flex: 2, child: SizedBox()),
                          Flexible(
                              fit: FlexFit.tight,
                              flex: 3,
                              child: ElevatedButton(
                                onPressed: () {
                                  _deleteItem(_dataUser[index]['id']);
                                },
                                child: Text("Hapus"),
                              )),
                          Flexible(
                              fit: FlexFit.tight, flex: 1, child: SizedBox()),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}

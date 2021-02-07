import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:search_listview/models/user.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<User> allUsers;
  List<User> filterUser;
  var txtSearchController = TextEditingController();
  Future<List<User>> getUsers() async {
    var url = "https://jsonplaceholder.typicode.com/users";
    var api = await http.get(url);
    if (api.statusCode == 200) {
      return (json.decode(api.body) as List)
          .map((e) => User.fromJson(e))
          .toList();
    } else {
      throw Exception("Error");
    }
  }

  @override
  void initState() {
    getUsers().then((value) {
      allUsers = value;
      filterUser = allUsers;
    });
    super.initState();
  }

  void doSearch(String s) {
    setState(() {
      filterUser = allUsers
          .where((element) =>
              element.name.toLowerCase().contains(s.toLowerCase()) ||
              element.email.toLowerCase().contains(s.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search in listview"),
      ),
      body: Column(
        children: [
          searhField(),
          userListWidget(),
        ],
      ),
    );
  }

  Widget searhField() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: txtSearchController,
        onChanged: doSearch,
      ),
    );
  }

  Widget userListWidget() {
    return Expanded(
      child: FutureBuilder<List<User>>(
          future: getUsers(),
          builder: (context, snapshot) {
            allUsers = snapshot.data;
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return ListView.builder(
                  itemCount: filterUser.length,
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 7,
                      child: ListTile(
                        title: Text(filterUser[index].name),
                        subtitle: Text(filterUser[index].email),
                        leading: CircleAvatar(
                          backgroundColor: Colors.blue.shade200,
                          child: Text(filterUser[index].id.toString()),
                        ),
                      ),
                    );
                  });
            }
          }),
    );
  }
}

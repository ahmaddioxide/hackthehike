import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:restapi_flutter/Model/UserModel.dart';


class UserApi extends StatefulWidget {
  const UserApi({super.key});

  @override
  State<UserApi> createState() => _UserApiState();
}

class _UserApiState extends State<UserApi> {

  List<UserModel> userList = [];

  Future<List<UserModel>> getUserApi() async {
    final responce = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
    var data = jsonDecode(responce.body.toString());
    if (responce.statusCode == 200) {
      userList.clear();
      for (Map i in data) {
        userList.add(UserModel.fromJson(i));
      }
      return userList;
    } else {
      return userList;
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Api'),
      ),
      body: Column(
        children: [
          Expanded(child: FutureBuilder(
            future: getUserApi(),
            builder: (context, AsyncSnapshot<List<UserModel>> snapshot){
              if(!snapshot.hasData){
                return const Center(child: CircularProgressIndicator());
              }else{
                return ListView.builder(
                  itemCount: userList.length,
                  itemBuilder: (context, index){
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [

                            ReuseableRow(title: "Name", value: snapshot.data![index].name.toString()),
                            ReuseableRow(title: "Username", value: snapshot.data![index].username.toString()),
                            ReuseableRow(title: "Email", value: snapshot.data![index].email.toString()),
                            ReuseableRow(title: "Address", value: snapshot.data![index].address!.city.toString()),
                            ReuseableRow(title: "Location", value: snapshot.data![index].address!.geo!.lat.toString()),
                            ReuseableRow(title: "Company", value: snapshot.data![index].company!.name.toString()),

                          ],
                        ),
                      ),
                    );
                  },
                );
              }
            },
          ))
        ],
      ),
    );
  }
}


class ReuseableRow extends StatelessWidget {
  String title, value;
   ReuseableRow({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title),
        Text(value),
      ],
    );
  }
}



import 'package:flutter/material.dart';
import 'package:flutter_first/model/user_model.dart';

class MyDetailPage extends StatelessWidget {
  MyDetailPage({Key? key, required this.userModel}) : super(key: key);
  final UserModel userModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          title: const Text('Details Page'),
        ),
        body: Center(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Center(
                child: CircleAvatar(
                  maxRadius: 60,
                  backgroundImage: NetworkImage(userModel.avatar),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(userModel.firstName + " " + userModel.lastName),
              const SizedBox(
                height: 10,
              ),
              Text(userModel.email)
            ],
          ),
        )));
  }
}

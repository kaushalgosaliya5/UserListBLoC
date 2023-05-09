import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_first/bloc/app_event.dart';
import 'package:flutter_first/detail_page.dart';
import 'package:flutter_first/model/user_model.dart';
import 'package:flutter_first/repos/repository.dart';
import 'package:flutter_first/utils/constants.dart';

import 'bloc/app_bloc.dart';
import 'bloc/app_state.dart';

class MyHomeApp extends StatelessWidget {
  const MyHomeApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          UserBloc(RepositoryProvider.of<UserRepository>(context))
            ..add(LoadUserEvent()),
      child: Scaffold(
          appBar: AppBar(
              backgroundColor: Colors.green,
              title: Text(
                AppConstants.appName,
                textAlign: TextAlign.center,
              )),
          body: BlocBuilder<UserBloc, UserState>(
            builder: (context, state) {
              if (state is UserLoadingState) {
                print("UserLoadingState");
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (state is UserLoadedState) {
                print("UserLoadedState");
                List<UserModel> userList = state.users;
                return ListView.builder(
                    itemCount: userList.length,
                    itemBuilder: (_, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (builder) =>
                                  MyDetailPage(userModel: state.users[index])));
                        },
                        child: Hero(
                          tag: "background${state.users[index].id}",
                          child: Card(
                            color: Colors.blue,
                            elevation: 4,
                            margin: const EdgeInsets.all(10),
                            child: ListTile(
                              title: Text(
                                userList[index].firstName,
                                style: const TextStyle(color: Colors.white),
                              ),
                              subtitle: Text(
                                userList[index].lastName,
                                style: const TextStyle(color: Colors.white),
                              ),
                              trailing: CircleAvatar(
                                backgroundImage:
                                    NetworkImage(userList[index].avatar),
                              ),
                            ),
                          ),
                        ),
                      );
                    });
              }

              if (state is UserErrorState) {
                return const Center(
                  child: Text("Error"),
                );
              }

              return Container();
            },
          )),
    );
  }
}

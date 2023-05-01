import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_first/home_page.dart';
import 'package:flutter_first/repos/repository.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: RepositoryProvider(
        create: (context) => UserRepository(),
        child: const MyHomeApp(),
      ), // RepositoryProvider(
      //create: (context) => UserRepository(), child: const MyHomeApp()),
      /* initialRoute: "/home",
      routes: {
        AppConstants.homeRoute: (context) => const MyHomeApp(),
        AppConstants.detailRoute: (context) => const MyDetailPage(),
        AppConstants.listRoute: (context) => const MyListPage(),
      },*/
    );
  }
}

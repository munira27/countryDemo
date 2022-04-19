import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inheritx_project/app_screen/county_listscreen.dart';
import 'package:inheritx_project/repository/country_bloc.dart';
import 'package:inheritx_project/repository/country_event.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner:false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider.value(
          value:CountryBloc()..add(GetCountryResponse()),
          child: CountryListScreen()),
    );
  }
}

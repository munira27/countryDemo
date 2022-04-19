
import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inheritx_project/apisample.dart';
import 'package:inheritx_project/app_screen/county_listscreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/countryModel.dart';
import 'country_event.dart';
import 'country_state.dart';
import 'package:dio/dio.dart';

class CountryBloc extends Bloc<CountryEvent,CountryState>
{

  CountryBloc() : super(InitialState());

  @override
  CountryState get intialState=>InitialState();

  @override
  Stream<CountryState> mapEventToState(CountryEvent event) async*{
    // TODO: implement mapEventToState
    final dio = Dio();
    final client = RestClient(dio);
    if(event is GetCountryResponse)
    {
      yield LoadingState();
      try
      {
        List<Data> finallist=[];
        CountriesModel countryModel=await client.getCountryData();
        final SharedPreferences sharedPreferences= await SharedPreferences.getInstance();
        await sharedPreferences.setString("countrylist",jsonEncode(countryModel.data));
        var value=sharedPreferences.getString("countrylist");
        final List<dynamic> jsonData=jsonDecode(value!);
         finallist=jsonData.map<Data>((jsonList) {
          return Data.fromJson(jsonList);
        } ).toList();

        print("the list is $finallist");

        yield GetCountryData(finallist);
      }
      catch(e)
      {
        yield ErrorState(e.toString());
      }
    }
  }



}
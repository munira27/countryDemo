import 'package:inheritx_project/model/countryModel.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'apisample.g.dart';

@RestApi(baseUrl: "https://countriesnow.space/api/v0.1/")
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @GET("/countries/info?returns=currency,flag,unicodeFlag,dialCode")
  Future<CountriesModel> getCountryData();
}
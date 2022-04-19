
import 'package:inheritx_project/model/countryModel.dart';

abstract class CountryState
{
  CountryState();
}
class GetCountryData extends CountryState
{
  List<Data> countriesModel;
  GetCountryData(this.countriesModel);
}
class InitialState extends CountryState
{
  InitialState();
}
class LoadingState extends CountryState
{
  LoadingState();
}
class ErrorState extends CountryState
{
  String error;
  ErrorState(this.error);
}
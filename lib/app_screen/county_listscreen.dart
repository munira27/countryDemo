import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:inheritx_project/app_screen/detail_page.dart';
import 'package:inheritx_project/model/countryModel.dart';
import 'package:shared_preferences/shared_preferences.dart';


class CountryListScreen extends StatefulWidget {
  const CountryListScreen({Key? key}) : super(key: key);

  @override
  _CountryListScreenState createState() => _CountryListScreenState();
}

class _CountryListScreenState extends State<CountryListScreen> {

  Widget appBarTitle = Text("List of Country");
  Icon actionIcon = Icon(Icons.search);

  final TextEditingController _filter = TextEditingController();
  String _searchText = "";
  List<Data> names = [];
  List<Data> filteredNames =[];
  Icon _searchIcon = Icon(Icons.search);
  Widget _appBarTitle = Text( 'Country List' );


  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    _getNames();
    super.initState();
  }

  void _getNames() async {
    final SharedPreferences sharedPreferences= await SharedPreferences.getInstance();
    var value=sharedPreferences.getString("countrylist");
    final List<dynamic> jsonData=jsonDecode(value!);
    List<Data> tempList = [];
    tempList=jsonData.map<Data>((jsonList) {
      return Data.fromJson(jsonList);
    } ).toList();
    setState(() {

      names = tempList;
      names.shuffle();
      filteredNames = names;
      filteredNames.sort((a, b) =>a.name!.compareTo(b.name!));
      //filteredNames.sort((a, b) =>a.currency!.compareTo(b.currency));
    });
  }


  _CountryListScreenState() {
    _filter.addListener(() {
      if (_filter.text.isEmpty) {
        setState(() {
          _searchText = "";
          filteredNames = names;
        });
      } else {
        setState(() {
          _searchText = _filter.text;
        });
      }
    });
  }



   searchPressed() {
    setState(() {
      if (_searchIcon.icon == Icons.search) {
        this._searchIcon = Icon(Icons.close);
        _appBarTitle = TextField(
          controller: _filter,
          decoration: InputDecoration(
              prefixIcon: Icon(Icons.search),
              hintText: 'Search...'
          ),
        );
      } else {
        this._searchIcon = Icon(Icons.search);
        this._appBarTitle = Text( 'Search Example' );
        filteredNames = names;
        _filter.clear();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(title:_appBarTitle,
      leading:IconButton(
        icon:Icon(Icons.search),
        onPressed: searchPressed,

      ),),
     body:buildListView(),
    );
  }

   buildListView() {

     if (!(_searchText.isEmpty)) {
       List<Data> tempList = [];
       for (int i = 0; i < filteredNames.length; i++) {
         if (filteredNames[i].name!.toLowerCase().contains(_searchText.toLowerCase())) {
           tempList.add(filteredNames[i]);
         }
       }

       filteredNames = tempList;
     }
    return Container(
      child: ListView.builder(itemCount:names == null ? 0 :
      filteredNames.length
      ,itemBuilder:(BuildContext c,int index)
      {

       return Row(
         children: [
           Expanded(
             flex:1,
             child: Padding(
               padding:EdgeInsets.all(10),
               child: GestureDetector(
                 onTap:()
                 {
                   Navigator.push(
                     context,
                     MaterialPageRoute(builder: (context) => DetailPage(
                         filteredNames[index].flag??"")),
                   );
                 },
                 child: Hero(
                   tag: "profile-image",
                   child: SvgPicture.network(filteredNames[index].flag??
                       "https://upload.wikimedia.org/wikipedia/commons/f/f9/Flag_of_Bangladesh.svg",
                     width:80,
                     height:50,),
                 ),
               ),
             ),
           ),
           Expanded(
             flex:2,
             child: Column(
               crossAxisAlignment:CrossAxisAlignment.start,
               children: [
                 Text(filteredNames[index].name??"",maxLines:2,softWrap:true,),
                 Text(filteredNames[index].currency??""),
                 Text(filteredNames[index].dialCode??""),

               ],
             ),
           )
         ],
       );
      }),
    );
  }
}

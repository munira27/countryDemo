import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class DetailPage extends StatefulWidget {
  String? flag;
   DetailPage(this.flag,);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Hero(
          tag: "profile-image",
          child: Container(
            width: double.infinity,
            height: 400.0,
            alignment: Alignment.topCenter,
            child: SvgPicture.network(widget.flag!,
                  width:MediaQuery.of(context).size.width,
                  height:MediaQuery.of(context).size.height,)),
          ),
        );
  }
}

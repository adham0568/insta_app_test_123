import 'package:flutter/material.dart';
import 'package:instaapp/Pages/responsive/web.dart';
import 'package:provider/provider.dart';

import '../../Provider/GetDataFromeDataBase.dart';
import 'mobile.dart';

class Responsive extends StatefulWidget {
  const Responsive({Key? key}) : super(key: key);

  @override
  State<Responsive> createState() => _ResponsiveState();
}

class _ResponsiveState extends State<Responsive> {

  getDataFromDB() async {
    GetDataBase userProvider = Provider.of(context, listen: false);
    await userProvider.refreshUser();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDataFromDB();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (BuildContext, BoxConstraints) {
      return BoxConstraints.maxWidth<600? MobileSecreen():WebScreen();
    },);
  }
}

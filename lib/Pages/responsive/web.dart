import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../Modles/colors.dart';
import '../screens/add.dart';
import '../screens/favorite.dart';
import '../screens/home.dart';
import '../screens/person.dart';
import '../screens/search.dart';
import 'mobile.dart';

class WebScreen extends StatefulWidget {
  const WebScreen({Key? key}) : super(key: key);

  @override
  State<WebScreen> createState() => _WebScreenState();
}
final PageController _pageControllerweb = PageController();
int adham=0;
class _WebScreenState extends State<WebScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      appBar: AppBar(
      title: SvgPicture.asset('assets/svg_image/instagram.svg',color: Colors.white,),
        actions: [
          IconButton(onPressed: (){_pageControllerweb.jumpToPage(0);}, icon: Icon(Icons.home,color: adham==0?primaryColor:NotselectedPage,)),
          IconButton(onPressed: (){_pageControllerweb.jumpToPage(1);}, icon: Icon(Icons.search_rounded,color:adham==1?primaryColor:NotselectedPage,)),
          IconButton(onPressed: (){_pageControllerweb.jumpToPage(2);}, icon: Icon(Icons.camera_alt_outlined,color: adham==2?primaryColor:NotselectedPage,)),
          IconButton(onPressed: (){_pageControllerweb.jumpToPage(3);}, icon: Icon(Icons.message_sharp,color: adham==3?primaryColor:NotselectedPage,)),
          IconButton(onPressed: (){_pageControllerweb.jumpToPage(4);}, icon: Icon(Icons.account_circle,color: adham==4?primaryColor:NotselectedPage,)),

        ],
      ),
      body: PageView(
        controller: _pageControllerweb,
        onPageChanged: (index){
          setState(() {
            adham=index;
          });
        },
        //physics: NeverScrollableScrollPhysics(),
        children: [
          HomePage(),
          SearchSecreen(),
          AddPage(),
          FavoritePage(),
          ProfilePage(UIDd: FirebaseAuth.instance.currentUser!.uid),
        ],

      ),
    );
  }
}

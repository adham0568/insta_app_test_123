import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instaapp/Pages/screens/add.dart';
import 'package:instaapp/Pages/screens/favorite.dart';
import 'package:instaapp/Pages/screens/home.dart';
import 'package:instaapp/Pages/screens/person.dart';
import 'package:instaapp/Pages/screens/search.dart';

import '../Modles/colors.dart';

class MobileSecreen extends StatefulWidget {
  const MobileSecreen({Key? key}) : super(key: key);

  @override
  State<MobileSecreen> createState() => _MobileSecreenState();
}
Color selectedPage=primaryColor;
Color NotselectedPage=secondaryColor;
final PageController _pageController = PageController();


class _MobileSecreenState extends State<MobileSecreen> {
  int adham=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      bottomNavigationBar: CupertinoTabBar(
        onTap: (index){

          _pageController.jumpToPage(index);
        },
        backgroundColor: mobileBackgroundColor,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home,color: adham==0?primaryColor:NotselectedPage,),label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.search_rounded,color: adham==1?primaryColor:NotselectedPage,),label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.add_circle,color: adham==2?primaryColor:NotselectedPage,),label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.favorite,color: adham==3?primaryColor:NotselectedPage,),label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.person,color: adham==4?primaryColor:NotselectedPage,),label: ''),
        ],
      ),
        body: PageView(
          controller: _pageController,
        onPageChanged: (index){
          setState(() {
            if(index==0){adham=0;}
            else{adham=index;}
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
/*
*
* BottomNavigationBar(items: [
        BottomNavigationBarItem(icon: Icon(Icons.home),label: ''),
        BottomNavigationBarItem(icon: Icon(Icons.account_circle),label: ''),
      ],),
      * */
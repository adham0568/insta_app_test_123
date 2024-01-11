
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:instaapp/Pages/Modles/LikesData.dart';
import 'package:instaapp/Pages/responsive/responsive.dart';
import 'package:instaapp/Pages/screens/home.dart';
import 'package:instaapp/Provider/GetDataFromeDataBase.dart';
import 'package:provider/provider.dart';

import 'Pages/Modles/snack.dart';
import 'Pages/athonticationPages/loginpage.dart';
import 'Pages/athonticationPages/singuppage.dart';
import 'Pages/screens/CommentPage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyD5SLuGhAbY9SI42DBTJDTRuUx28giif3M",
            authDomain: "instaapp-1a4f0.firebaseapp.com",
            projectId: "instaapp-1a4f0",
            storageBucket: "instaapp-1a4f0.appspot.com",
            messagingSenderId: "749612877884",
            appId: "1:749612877884:web:124ec529389fa977df9b39"));
  } else {
    await Firebase.initializeApp();
  }
  runApp(const MyApp());
}


class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) {return GetDataBase();}),
      ],
      child: MaterialApp(
        theme: ThemeData.dark(),
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {return Center(child: CircularProgressIndicator(color: Colors.white,));}
            else if (snapshot.hasError) {return showSnackBar(context: context,text: "Something went wrong");}
            else if (snapshot.hasData) {return Responsive();}
            else { return LogInPage();}
          },
        ),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

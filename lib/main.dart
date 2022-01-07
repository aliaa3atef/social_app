import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:socail/layout/socialAppHome/socialHome.dart';
import 'package:socail/modules/socialLogin/socialLoginScreen.dart';
import 'package:socail/shared/bloc_observe/bloc_observe.dart';
import 'package:socail/shared/components/constants.dart';
import 'package:socail/shared/network/local/awesomeNotification.dart';
import 'package:socail/shared/network/local/fcm.dart';
import 'package:socail/shared/network/local/cashedHelper.dart';
import 'package:socail/shared/network/remote/DioHelper.dart';
import 'package:socail/shared/styles/colors.dart';


import 'layout/socialAppHome/socialCubit/cubit.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CashedHelper.init();

  FCM.init();
  AwesomeNotification.init();

  uId = CashedHelper.saveData(key: 'uId');

  Widget screen ;

  if(uId != null )  screen = SocialHome();

  else screen = SocialLoginScreen();


  runApp(MyApp(screen));
}

class MyApp extends StatelessWidget {

  final Widget screen ;

  const MyApp( this.screen) ;

  @override
  Widget build(BuildContext context) {
    return  BlocProvider(create: (context) => SocialCubit()..getUserData()..getPosts(),
      child: MaterialApp(
        theme: ThemeData(
          textTheme: TextTheme(
            bodyText1: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            bodyText2: TextStyle(
              color: Colors.black,
              fontSize: 16,
            ),
          ),
          dividerTheme: DividerThemeData(
            color: colorApp,
            thickness: 1,
          ),
          primarySwatch: colorApp,
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.white,
            elevation: 0,
            iconTheme: IconThemeData(color: Colors.black),
            titleTextStyle: TextStyle(color: Colors.black, fontSize: 25,),
            backwardsCompatibility: false,
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: Colors.white,
              statusBarIconBrightness: Brightness.dark,
            ),
          ),
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
              selectedItemColor: colorApp,
              unselectedItemColor: Colors.black,
              type: BottomNavigationBarType.fixed,
              elevation: 50,
              backgroundColor: Colors.white
          ),
        ),
        darkTheme: ThemeData(
          textTheme: TextTheme(
            bodyText1: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            bodyText2: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
          dividerTheme: DividerThemeData(
            color: colorApp,
            thickness: 1,
          ),
          primarySwatch: colorApp,
          scaffoldBackgroundColor: HexColor('33312b'),
          appBarTheme: AppBarTheme(
            backgroundColor: HexColor('33312b'),
            elevation: 0,
            actionsIconTheme: IconThemeData(color: colorApp),
            iconTheme: IconThemeData(color: Colors.white),
            titleTextStyle: TextStyle(color: Colors.white, fontSize: 25),
            backwardsCompatibility: false,
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: Colors.white,
              statusBarIconBrightness: Brightness.light,
            ),
          ),
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
            selectedItemColor: colorApp,
            unselectedItemColor: Colors.grey,
            type: BottomNavigationBarType.fixed,
            elevation: 50,
            backgroundColor: HexColor('33312b'),
          ),
        ),
        themeMode: ThemeMode.light,
        home: screen,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

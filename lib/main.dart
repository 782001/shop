
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/network/local/cashhelper.dart';
import 'package:shop/network/remote/dio_helper.dart';
import 'package:shop/shared/components.dart';

import 'bloc_observer.dart';
import 'bording_page.dart';
import 'all_login_cubit/login.dart';

import 'homescreen/homescreen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CashHelper.init();
  Widget widget;
 bool?    onBording=CashHelper.GetBoolData(key: 'onBording');
  token = CashHelper.GetData(key: 'token');
  print('token:$token');

  BlocOverrides.runZoned(
        () {
          if(onBording!=null){
            if(token!=null){
              widget=HomeLayOut();
            }else{
              widget=LoginScreen();
            }
          }else{
            widget= const BordingScreen();

          }
      runApp(MyApp(
          widget
      ));
    },
    blocObserver: MyBlocObserver(),
  );


}

class MyApp extends StatelessWidget {
final Widget StartWidget;

   const MyApp( this.StartWidget);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      theme:ThemeData( scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          iconTheme:IconThemeData(
            color: Colors.black,
            size: 30,
          ),
          elevation: 0,
          color: Colors.white,
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.white,
            statusBarBrightness: Brightness.light,
            statusBarIconBrightness:  Brightness.dark,
          ),
        ),
        bottomNavigationBarTheme:BottomNavigationBarThemeData(
          selectedItemColor: DefaultColor,
          unselectedItemColor: Colors.grey,
            type:BottomNavigationBarType.fixed
        ) ,

        textTheme: const TextTheme(
            bodyText1: TextStyle(
                color: Colors.black,
                fontSize: 30,
                fontWeight: FontWeight.bold
            )
        ),
        primarySwatch: Colors.indigo,
      ),
      debugShowCheckedModeBanner: false,
      home:StartWidget
    );
  }
}


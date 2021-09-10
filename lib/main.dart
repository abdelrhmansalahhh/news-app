import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/new_app/cubit/cubit_mode.dart';
import 'package:news_app/network/remote/dio_helper.dart';
import 'package:news_app/shared/styles/colors.dart';
import 'layout/new_app/cubit/cubit.dart';
import 'layout/new_app/cubit/states.dart';
 import 'package:hexcolor/hexcolor.dart';

 import 'modules/shop_app/on_boarding/on_boarding_screen.dart';
import 'network/local/cach_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();  
   DioHelper.init();
   await CacheHelper.init();  
   bool isDark = CacheHelper.gettBoolean(key: 'isDark');

  runApp(MyApp(isDark));
}

class MyApp extends StatelessWidget {
  final bool isDark;
  MyApp(this.isDark); 
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
   return MultiBlocProvider(
      providers:
      [
        BlocProvider(
          create: (context) => NewsCubit()
            ..getBusiness()
            ..getSports()
            ..getScience(),
        ),
        BlocProvider(
          create: (BuildContext context) => ModeCubit()
            ..changeAppMode(
              fromShared: isDark,
            ),
        ),
      ],
      
       child: BlocConsumer<ModeCubit, NewsStates>(
        listener: (context, state) {},
        builder: (context, state)
        {
      
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
                     primarySwatch:defaultColor,

          scaffoldBackgroundColor: Colors.white,
          appBarTheme: AppBarTheme(
                 backwardsCompatibility: false,
                systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarColor: Colors.white,
                    statusBarIconBrightness: Brightness.dark,
                ),
                       backgroundColor: Colors.white,
                           elevation: 0.0,
                      titleTextStyle: TextStyle(fontSize: 20,fontWeight:FontWeight.bold,color: Colors.black),
                      iconTheme: IconThemeData(color: Colors.black),


          ),
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
              type: BottomNavigationBarType.fixed, 
            selectedItemColor: Colors.deepOrange,
            unselectedItemColor: Colors.grey,
            elevation: 20,
            backgroundColor:Colors.white,
          ),
 
           floatingActionButtonTheme: FloatingActionButtonThemeData(
            ),
              textTheme: TextTheme(
            bodyText1: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.black ,
            ),
          ),
        ),
        darkTheme:
           ThemeData(
             primarySwatch: defaultColor,
          scaffoldBackgroundColor: HexColor('333937'),
          appBarTheme: AppBarTheme(
                 backwardsCompatibility: false,
                systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarColor:HexColor('333937'),
                    statusBarIconBrightness: Brightness.light,
                ),
                       backgroundColor: HexColor('333937'),
                           elevation: 0.0,
                      titleTextStyle: TextStyle(fontSize: 20,fontWeight:FontWeight.bold,color: Colors.white),
                      iconTheme: IconThemeData(color: Colors.white),


          ),
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
            type: BottomNavigationBarType.fixed, 
            selectedItemColor: Colors.deepOrange,
            unselectedItemColor: Colors.grey,
            elevation: 20,
            backgroundColor: HexColor('333937'),
          ),
          textTheme: TextTheme(
            bodyText1: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.white ,
            ),
          ),
 
           floatingActionButtonTheme: FloatingActionButtonThemeData(
            ),
        ),
         
        themeMode: ModeCubit.get(context).isDark ?ThemeMode.dark:ThemeMode.light,
        home:NewsLayout() ,
      );
  }
      ),
   );
   
      
    
 }
  }
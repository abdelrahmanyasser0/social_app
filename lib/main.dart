import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app_firebase/a_layer_data/cacheHelper.dart';
import 'package:social_app_firebase/b_layer_bloc/layout_cubit/social_cubit.dart';
import 'package:social_app_firebase/b_layer_bloc/layout_cubit/social_state.dart';
import 'package:social_app_firebase/c_layer_ui/moduls/login.dart';
import 'package:social_app_firebase/z_shared/constants.dart';
import 'package:social_app_firebase/z_shared/themes.dart';
import 'c_layer_ui/moduls/layout_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await CacheHelper.init();
  uId=CacheHelper.getAllData(key: 'uId');
   Widget widget;
   if(uId !=null){
     widget =const AppLayoutPage();
   }else
     {
       widget=LogingScreen();
     }

  Widget startWidget =widget;
  runApp( MyApp(startWidget ));
}

class MyApp extends StatelessWidget {
  final Widget startWidget;
   MyApp( this.startWidget,{Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create:(BuildContext context) => HomePageCubit()..getUserData()..getAllPosts()..getAllUsers()
        ),
      ],
      child: BlocConsumer<HomePageCubit,HomePageStates>(
        listener: (context, state) {},
        builder:(context, state) {
         return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightMode,
            darkTheme: darkMode,
            home:LogingScreen(),
            themeMode: ThemeMode.light,

          );

        }),
    );
  }
}



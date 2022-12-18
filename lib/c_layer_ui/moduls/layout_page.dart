import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app_firebase/b_layer_bloc/layout_cubit/social_cubit.dart';
import 'package:social_app_firebase/b_layer_bloc/layout_cubit/social_state.dart';

import '../../z_shared/styles/icons.dart';

class AppLayoutPage extends StatelessWidget {
  const AppLayoutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomePageCubit,HomePageStates>(
      listener:(context, state){},
      builder: (context, state) {
        HomePageCubit cubit=HomePageCubit.get(context);
        return  Scaffold(
          appBar: AppBar(
            title: Text(cubit.title[cubit.currentIndex]),
            actions: const [
              Icon(IconBroken.Notification),
              SizedBox(width:20,),
              Icon(IconBroken.Search),
              SizedBox(width: 15,)
            ],
          ),

          body:cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            onTap: (index){
              cubit.BottomNavBar(index,context);
            },
            items: const [
              BottomNavigationBarItem(icon:Icon(IconBroken.Home),label: 'home'),
              BottomNavigationBarItem(icon:Icon(IconBroken.Chat),label: 'chat'),
              BottomNavigationBarItem(icon:Icon(IconBroken.User),label: 'post'),
              BottomNavigationBarItem(icon:Icon(IconBroken.Setting),label: 'settings'),

            ],
          ),
        );
      });
  }
}

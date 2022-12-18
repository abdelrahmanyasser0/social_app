import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app_firebase/b_layer_bloc/layout_cubit/social_cubit.dart';
import 'package:social_app_firebase/b_layer_bloc/layout_cubit/social_state.dart';
import 'package:social_app_firebase/c_layer_ui/moduls/edit_profile.dart';
import 'package:social_app_firebase/z_shared/componants.dart';
import 'package:social_app_firebase/z_shared/styles/icons.dart';

class Setting extends StatelessWidget {
  const Setting ({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomePageCubit,HomePageStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var userModel = HomePageCubit.get(context).model;
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Container(
                  height:212,
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                          height: 170,
                          width: double.infinity,
                          decoration:  BoxDecoration(
                              borderRadius: const BorderRadius.only(topRight: Radius.circular(5) ,topLeft: Radius.circular(5)  ),
                              image:  DecorationImage(
                                  image:  NetworkImage(
                                    '${userModel!.cover}'
                                  ),fit: BoxFit.cover
                              )
                          ),

                        ),
                      ),
                      Align(
                          alignment: Alignment.bottomCenter,
                          child:CircleAvatar(
                            radius: 58,
                            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                            child:   CircleAvatar(
                              radius: 55,
                              backgroundImage: NetworkImage(
                                '${userModel.image}'
                              ),
                            ),
                          )
                      )
                    ],
                  ),
                ),
                Text('${userModel.name}',style: Theme.of(context).textTheme.bodyText1,),
                Text('${userModel.bio}',style: Theme.of(context).textTheme.labelMedium,),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: (){},
                        child: Column(
                          children: [
                            Text('100',style: Theme.of(context).textTheme.bodyText1),
                            Text('post',style: Theme.of(context).textTheme.labelMedium),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: (){},
                        child: Column(
                          children: [
                            Text('350',style: Theme.of(context).textTheme.bodyText1),
                            Text('photo',style: Theme.of(context).textTheme.labelMedium),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: (){},
                        child: Column(
                          children: [
                            Text('1k',style: Theme.of(context).textTheme.bodyText1),
                            Text('followers',style: Theme.of(context).textTheme.labelMedium),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: (){},
                        child: Column(
                          children: [
                            Text('420',style: Theme.of(context).textTheme.bodyText1),
                            Text('following',style: Theme.of(context).textTheme.labelMedium),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(child: OutlinedButton(onPressed: (){}, child: const Text('Add Photo'))),
                    const SizedBox(width: 3),
                    OutlinedButton(onPressed: (){
                      navigatorPush(context: context, widget: EditProfile());
                    }, child:const Icon(IconBroken.Edit))
                  ],
                )

              ],
            ),
          ),
        );
      },

    );
  }
}
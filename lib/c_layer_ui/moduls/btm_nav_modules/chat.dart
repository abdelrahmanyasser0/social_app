import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app_firebase/b_layer_bloc/layout_cubit/social_cubit.dart';
import 'package:social_app_firebase/b_layer_bloc/layout_cubit/social_state.dart';
import 'package:social_app_firebase/c_layer_ui/moduls/chat_details.dart';
import 'package:social_app_firebase/z_shared/componants.dart';

import '../../../models/creat_user.dart';

class Chats extends StatelessWidget {
  const Chats ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<HomePageCubit,HomePageStates>(
      listener: (context, state) {},
       builder: ((context, state) {
         var cubit =HomePageCubit.get(context);
         return ConditionalBuilder(
             condition: cubit.users.length>0,
             builder: (context)=>
                Padding(
                 padding: const EdgeInsets.all(15),
                 child: ListView.separated(
                     itemBuilder:(context,index)=> buildListItem(cubit.users[index], context),
                     separatorBuilder: (context,index)=>const SizedBox(height: 7,),
                     itemCount: cubit.users.length
                 ),
               ),

             fallback: (context)=>const Center(child:CircularProgressIndicator())
         );
       }),

    );
  }


  Widget buildListItem(SocialCreateUser model,context){
    return  InkWell(
      onTap: (){
        navigatorPush(context: context, widget: ChatsDetails(
          userModel: model,
        ));
      },
      child: Row(
        children: [
          CircleAvatar(
            radius:(25) ,
            backgroundImage: NetworkImage('${model.image}'),
          ),
          const SizedBox(width: 8,),
          Text('${model.name}',style:const TextStyle(fontSize: 14,fontWeight: FontWeight.bold))
        ],
      ),
    );
  }

}
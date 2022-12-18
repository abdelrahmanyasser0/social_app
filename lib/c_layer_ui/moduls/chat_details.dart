import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app_firebase/b_layer_bloc/layout_cubit/social_cubit.dart';
import 'package:social_app_firebase/b_layer_bloc/layout_cubit/social_state.dart';
import 'package:social_app_firebase/models/messages.dart';
import 'package:social_app_firebase/z_shared/styles/icons.dart';

import '../../models/creat_user.dart';

class ChatsDetails extends StatelessWidget {
SocialCreateUser? userModel;
ChatsDetails({
  this.userModel
});

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        HomePageCubit.get(context).getMessages(recivedId: userModel!.uId);

        return BlocConsumer<HomePageCubit, HomePageStates>(
            listener: (context, state) {},
            builder: (context, state) {
              var textController = TextEditingController();
              var cubit = HomePageCubit.get(context);

              return Scaffold(
                appBar: AppBar(
                  title: Row(
                    children: [
                      CircleAvatar(
                          radius: (18),
                          backgroundImage:
                          NetworkImage(
                              '${userModel!.image}'
                          )),
                      const SizedBox(width: 7,),
                      Text('${userModel!.name}', style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.bold)),
                    ],
                  )
                  ,
                ),
                body: ConditionalBuilder(
                  condition: cubit.messages.isNotEmpty,
                  builder: (context)=>Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      children: [
                        Expanded(
                          child: ListView.separated(
                              itemBuilder:(context,index){
                                var message =HomePageCubit.get(context).messages[index];

                                if(cubit.model!.uId==message.sederId)
                                  return  buildMyMessage(message);
                                return buildRecivedMessage(message);

                              },
                              separatorBuilder:(context,index)=> const SizedBox(height: 15,),
                              itemCount:cubit.messages.length
                          ),
                        ),
                        Container(
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                    color: Colors.grey.shade300,
                                    width: 1
                                )
                            ),
                            child:textFormFiled(context, textController)
                        )
                      ],
                    ),
                  ),
                  fallback: (context)=>const Center(child: CircularProgressIndicator()),
                ),
              );
            }
        );
      }
    );
  }
  Widget buildMyMessage(ChatModel model){
    return Align(
      alignment: AlignmentDirectional.centerEnd,
      child: Container(
        padding: const EdgeInsets.symmetric(
            vertical: 5,
            horizontal: 5
        ),
        decoration:  BoxDecoration(
            color: Colors.blue.shade100,
            borderRadius: const BorderRadiusDirectional.only(
              topEnd: Radius.circular(10),
              topStart:Radius.circular(10),
              bottomStart: Radius.circular(10),

            )
        ),
        child: Text('${model.text}'),
      ),
    );
  }

Widget buildRecivedMessage(ChatModel model){
  return Align(
    alignment: AlignmentDirectional.centerStart,
    child: Container(
      padding: const EdgeInsets.symmetric(
          vertical: 5,
          horizontal: 5
      ),
      decoration:  BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: const BorderRadiusDirectional.only(
            topEnd: Radius.circular(10),
            topStart:Radius.circular(10),
            bottomEnd: Radius.circular(10),

          )
      ),
      child: Text('${model.text}'),
    ),
  );
}

Widget textFormFiled(context,controller){
  return Padding(
    padding: const EdgeInsets.only(left: 5),
    child: Row(
      children: [
        Expanded(
          child: TextFormField(
            controller: controller,
            decoration: const InputDecoration(
              hintText: 'type your message here',
              border: InputBorder.none,
            ),
          ),
        ),
        Container(
          color: Colors.blue,
          child: IconButton(
            onPressed: () {
              HomePageCubit.get(context).sendMessage(reciverId: userModel!.uId,
                  text: controller.text,
                  dateTime: DateTime.now().toString());
            },
            icon: const Icon(
              IconBroken.Send, color: Colors.white,),
          ),
        )

      ],
    ),
  );
}
}

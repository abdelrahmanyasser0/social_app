import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app_firebase/b_layer_bloc/layout_cubit/social_state.dart';
import 'package:social_app_firebase/models/new_post.dart';
import 'package:social_app_firebase/z_shared/styles/icons.dart';

import '../../b_layer_bloc/layout_cubit/social_cubit.dart';

class Comments extends StatelessWidget {
  var commentController = TextEditingController();

  Comments({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomePageCubit, HomePageStates>(
      listener: (context, state) {},
      builder: ((context, state,) {
        var cubit = HomePageCubit.get(context);
        return Scaffold(
          appBar: AppBar(),
          body: ConditionalBuilder(
            condition: cubit.comments.isNotEmpty,
            builder: (context)=>Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Most revelant', style: Theme
                      .of(context)
                      .textTheme
                      .labelSmall),
                  Expanded(
                    child: ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) =>
                          Column(
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                    radius: 25,
                                    backgroundImage: NetworkImage(
                                        '${cubit.model!.image}'),
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment
                                          .start,
                                      children: [
                                        Card(
                                          child: Padding(
                                            padding: const EdgeInsets.all(10),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment
                                                  .start,
                                              children: [
                                                Text(
                                                  '${cubit.model!.name}',
                                                  style: Theme
                                                      .of(context)
                                                      .textTheme
                                                      .subtitle1,
                                                ),
                                                const SizedBox(
                                                  height: 3,
                                                ),
                                                Text(
                                                  '${cubit.comments[index].text}',
                                                  overflow: TextOverflow.ellipsis,
                                                  maxLines: 3,
                                                  style: Theme
                                                      .of(context)
                                                      .textTheme
                                                      .bodyText2,
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Text('10m', style: Theme
                                                .of(context)
                                                .textTheme
                                                .labelMedium!
                                                .copyWith(
                                                fontWeight: FontWeight.bold),),
                                            const SizedBox(width: 10,),
                                            Text('like', style: Theme
                                                .of(context)
                                                .textTheme
                                                .labelMedium!
                                                .copyWith(
                                                fontWeight: FontWeight.bold),),
                                            const SizedBox(width: 10,),

                                            Text('replay', style: Theme
                                                .of(context)
                                                .textTheme
                                                .labelMedium!
                                                .copyWith(
                                                fontWeight: FontWeight.bold),)

                                          ],
                                        )
                                      ],
                                    ),
                                  ),

                                ],
                              ),

                            ],
                          ),
                      separatorBuilder: (context, index) =>
                      const SizedBox(height: 10,),
                      itemCount: cubit.comments.length,
                    ),
                  ),
                  Container(
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.grey.shade300,
                              width: 1
                          )
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: commentController,
                                decoration: const InputDecoration(
                                  hintText: 'write a comment',
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                            Container(
                              color: Colors.blue,
                              child: IconButton(
                                onPressed: () {
                                  HomePageCubit.get(context).uploadComments(
                                      postId:HomePageCubit.get(context).postId[1],
                                      text: commentController.text, dateTime: DateTime.now().toString());
                                },
                                icon: const Icon(
                                  Icons.send, color: Colors.white,),
                              ),
                            )

                          ],
                        ),
                      )
                  )

                ],
              ),
            ),
            fallback: (context)=> const Center(child:  Text('no comments yet')),
          ),
        );
      }),
    );

  }

  Widget textFormFiled(context, controller) {
    return Padding(
      padding: const EdgeInsets.only(left: 5),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              controller: controller,
              decoration: const InputDecoration(
                hintText: 'write a comment',
                border: InputBorder.none,
              ),
            ),
          ),
          Container(
            color: Colors.blue,
            child: IconButton(
              onPressed: () {
                HomePageCubit.get(context).uploadComments(
                  postId:HomePageCubit.get(context).postId[0],
                    text: controller, dateTime: DateTime.now().toString());
              },
              icon: const Icon(
                Icons.send, color: Colors.white,),
            ),
          )

        ],
      ),
    );
  }
}

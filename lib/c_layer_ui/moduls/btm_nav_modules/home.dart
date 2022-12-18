import 'dart:ui';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app_firebase/b_layer_bloc/layout_cubit/social_cubit.dart';
import 'package:social_app_firebase/b_layer_bloc/layout_cubit/social_state.dart';
import 'package:social_app_firebase/c_layer_ui/moduls/comments.dart';
import 'package:social_app_firebase/models/new_post.dart';
import 'package:social_app_firebase/z_shared/componants.dart';
import '../../../z_shared/styles/icons.dart';

class Homepage extends StatelessWidget {
  const Homepage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomePageCubit, HomePageStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = HomePageCubit.get(context);
          return Scaffold(
            body: ConditionalBuilder(
              condition:cubit.posts.length>1 &&cubit.model!=null,
              builder: (context)=>SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Card(
                      elevation: 8,
                      margin: const EdgeInsets.all(10),
                      child: Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          const Image(
                            fit: BoxFit.cover,
                            height: 250,
                            width: double.infinity,
                            image: AssetImage('assets/images/cover.jpg'),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'communicate with your friends',
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1!
                                  .copyWith(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) => BuildCardItem(cubit.posts[index],context,index),
                      separatorBuilder: (context, index) => const SizedBox(
                        height: 10,
                      ),
                      itemCount: cubit.posts.length,
                    ),
                    const SizedBox(
                      height: 10,
                    )
                  ],
                ),
              ),
              fallback: (context)=>const Center(child: CircularProgressIndicator()),
            ),
          );
        });
  }

  Widget BuildCardItem(CreatePost postModel,context,index) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundImage: NetworkImage('${postModel.image}'),
                ),
                const SizedBox(
                  width: 3,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          '${postModel.name}',
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                        const SizedBox(
                          width: 6,
                        ),
                        const Icon(
                          CupertinoIcons.check_mark_circled_solid,
                          color: Colors.blue,
                          size: 20,
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          '${postModel.dateTime}',
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                        SizedBox(width: 50,),
                        const Icon(CupertinoIcons.ellipsis)
                      ],
                    )
                  ],
                )
              ],
            ),
            const SizedBox(
              height: 25,
            ),
            Text(
              '${postModel.text}',
              style: Theme.of(context)
                  .textTheme
                  .subtitle1!
                  .copyWith(fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 10,
            ),
            Wrap(
              spacing: (4),
              children: [
                Text(
                  '#flutter',
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1!
                      .copyWith(color: Colors.blue),
                ),
                Text(
                  '#developer',
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1!
                      .copyWith(color: Colors.blue),
                ),
                Text(
                  '#dart',
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1!
                      .copyWith(color: Colors.blue),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
              if(postModel.postImage!='')
              Image(
                height: 220,
                width: double.infinity,
                image: NetworkImage('${postModel.postImage}')),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                    child: InkWell(
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: Row(
                      children: [
                        Text(
                          ' ${HomePageCubit.get(context).likes[index]}',
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                        const Icon(
                          IconBroken.Heart,
                          color: Colors.red,
                        )
                      ],
                    ),
                  ),
                )),
                Expanded(
                    child: InkWell(
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'comment',
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                      ],
                    ),
                  ),
                ))
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              width: double.infinity,
              height: 1,
              color: Colors.grey.shade300,
            ),

            Row(
              children: [
                  Expanded(
                    child: TextButton(
                        onPressed: () {
                          HomePageCubit.get(context).uploadLikes(
                              HomePageCubit.get(context).postId[index]);
                        },
                        child: Row(
                            children: const [
                          Icon(IconBroken.Heart,color: Colors.grey,),
                          SizedBox(width: 3),
                          Text('like',style: TextStyle(color: Colors.grey),)
                        ])),
                  ),
                  Expanded(
                    child:TextButton(onPressed: () {
                      navigatorPush(context: context, widget:  Comments());
                      HomePageCubit.get(context).getComments(postId: HomePageCubit.get(context).postId[index]);

                    },
                      child: Row(children: const [
                        Icon(Icons.comment_sharp,color: Colors.grey),
                        SizedBox(width: 3),
                        Text('comment',style: TextStyle(color: Colors.grey))
                      ])),
                  ),
                  const SizedBox(width: 20,),
                  TextButton(onPressed: () {},
                      child: Row(children: const [
                        Icon(CupertinoIcons.arrowshape_turn_up_right,color: Colors.grey,),
                        SizedBox(
                          width: 3,
                        ),
                        Text('share',style: TextStyle(color: Colors.grey))
                      ])),
                ],
                ),

              ],
            )

        ),

    );
  }
}
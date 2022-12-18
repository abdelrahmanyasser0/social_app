import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app_firebase/b_layer_bloc/layout_cubit/social_cubit.dart';
import 'package:social_app_firebase/b_layer_bloc/layout_cubit/social_state.dart';
import 'package:social_app_firebase/c_layer_ui/moduls/layout_page.dart';
import 'package:social_app_firebase/z_shared/componants.dart';
import 'package:social_app_firebase/z_shared/styles/icons.dart';

class Post extends StatelessWidget {
  const Post ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomePageCubit,HomePageStates>(
    listener: (context,state){},
    builder: ((context, state) {
      var cubit =HomePageCubit.get(context);
      var textController=TextEditingController();
      return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                  onPressed: () {
                    navigatorPush(
                        context: context, widget: const AppLayoutPage());
                  },
                  icon: const Icon(IconBroken.Arrow___Left_2)),
              title: Text('Create post',
                  style: Theme.of(context).textTheme.bodyText1),
              actions: [
                TextButton(onPressed: (){
                  if(cubit.postImage==null){
                    cubit.createPost(text: textController.text, dateTime:DateTime.now().toString());
                  }else{
                    cubit.uploadPostImage(text: textController.text, dateTime: DateTime.now().toString());
                  }
                }, child: const Text('post'))
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Row(
                    children: [
                      const CircleAvatar(
                        radius: 25,
                        backgroundImage: AssetImage('assets/images/user.jpg'),
                      ),
                      const SizedBox(
                        width: 7,
                      ),
                       Text(
                         'Abdelrahman Yasser',
                         style: Theme.of(context).textTheme.subtitle1,
                       ),
                       const SizedBox(
                         width: 6,
                       ),

                    ],
                  ),
                  const SizedBox(height: 10,),
                  Expanded(
                    child: Column(
                      children: [
                        TextFormField(
                          style: Theme.of(context).textTheme.bodyText2,
                          controller: textController,
                          decoration:  InputDecoration(
                            hintStyle: Theme.of(context).textTheme.labelMedium,
                            hintText: 'what is in your mind ...',
                            border: InputBorder.none
                          ),
                        ),
                        const SizedBox(height: 10),
                        if(cubit.postImage!= null)
                        Stack(
                          children: [
                            Container(
                              height: 170,
                              width: double.infinity,
                              decoration:   BoxDecoration(
                                  borderRadius:  const BorderRadius.only(topRight: Radius.circular(5) ,topLeft: Radius.circular(5)  ),
                                  image:  DecorationImage(
                                      image: FileImage(cubit.postImage!),
                                      fit: BoxFit.cover
                                  )
                              ),

                            ),
                            Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: Align(
                                  alignment: Alignment.topRight,
                                  child: CircleAvatar(
                                      radius: 16,
                                      child: IconButton(
                                          onPressed: () {
                                           cubit.removePostImage();
                                          },
                                          icon: const Icon(Icons.close,size: 18,)))),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextButton(
                          onPressed: () {
                            HomePageCubit.get(context).getPostImage();
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [Icon(IconBroken.Image), Text('add photo')],
                          ),
                        ),
                      ),
                      Expanded(
                        child: TextButton(
                          onPressed: () {},
                          child: const Center(child: Text('# tag')),
                        ),
                      ),
                    ],
                  )

                ],
              ),
            ),
          );
        }));
  }
}

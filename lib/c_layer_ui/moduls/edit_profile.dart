import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app_firebase/b_layer_bloc/layout_cubit/social_cubit.dart';
import 'package:social_app_firebase/b_layer_bloc/layout_cubit/social_state.dart';
import 'package:social_app_firebase/z_shared/componants.dart';

import '../../z_shared/styles/icons.dart';
import 'layout_page.dart';

class EditProfile extends StatelessWidget {
  var bioController=TextEditingController();
  var nameController=TextEditingController();
  var phoneController=TextEditingController();


  EditProfile({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomePageCubit,HomePageStates>(
      listener: (context, state){

    },
        builder: (context, state) {
        var userModel=HomePageCubit.get(context).model!;
        var profileImage=HomePageCubit.get(context).profileImage;
        var coverImage=HomePageCubit.get(context).coverImage;

        bioController.text=userModel.bio!;
         nameController.text=userModel.name!;
         phoneController.text=userModel.phone!;

        return Scaffold(
          appBar: AppBar(
              leading: IconButton(
                  onPressed: () {
                    navigatorPush(
                        context: context, widget: const AppLayoutPage());
                  },
                  icon: const Icon(IconBroken.Arrow___Left_2)),
              titleSpacing: 5,
              title: Text('Edit Profile',
                  style: Theme.of(context).textTheme.bodyText1),
              actions: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextButton(
                      onPressed: () {
                        HomePageCubit.get(context).updateUser(
                            name: nameController.text,
                            bio: bioController.text,
                            phone: phoneController.text);

                      }, child: const Text('Update')
                  ),
                )
              ],

            ),
            body: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                if (state is UpdateDataLoading)
                const LinearProgressIndicator(),
                Container(
                  height:212,
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.topCenter,
                        child: Stack(
                          children: [
                            Container(
                              height: 170,
                              width: double.infinity,
                              decoration:   BoxDecoration(
                                  borderRadius:  const BorderRadius.only(topRight: Radius.circular(5) ,topLeft: Radius.circular(5)  ),
                                  image:  DecorationImage(
                                      image:  (coverImage==null?NetworkImage(userModel.cover!):FileImage(coverImage))as ImageProvider,
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
                                                HomePageCubit.get(context).getCoverImage();
                                              },
                                              icon: const Icon(IconBroken.Camera,size: 18,)))),
                                )
                              ],
                        )
                      ),
                      Align(
                          alignment: Alignment.bottomCenter,
                          child: Stack(
                            children: [
                              CircleAvatar(
                                radius: 58,
                                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                                child:  CircleAvatar(
                                  radius: 55,
                                  backgroundImage:(
                                      profileImage==null?NetworkImage(userModel.image!):FileImage(profileImage))as ImageProvider
                                ),
                              ),
                              Positioned(
                                bottom: 5,
                                right: 5,
                                child: CircleAvatar(
                                    radius: 16,
                                    child: Center(
                                      child: IconButton(
                                          onPressed: () {
                                            HomePageCubit.get(context).getProfileImage();
                                          },
                                          icon: const Icon(IconBroken.Camera,size: 18,)),
                                    )),
                              )

                            ],
                          ),
                      )
                    ],
                  ),
                ),
                 Row(
                   children: [
                     MaterialButton(
                       onPressed: () {
                         HomePageCubit.get(context).uploadCoverImage();
                       },
                       color: Colors.blue,
                       child: Text('upload cover',
                           style: Theme.of(context)
                               .textTheme
                               .subtitle1!
                               .copyWith(color: Colors.white)),
                     ),
                     const SizedBox(width:50),
                     MaterialButton(
                       onPressed: () {
                         HomePageCubit.get(context).uploadProfileImage();
                       },
                       color: Colors.blue,
                       child: Text('upload profile',
                           style: Theme.of(context)
                               .textTheme
                               .subtitle1!
                               .copyWith(color: Colors.white)),
                     ),

                   ],
                 ),
                  const SizedBox(height: 20),
                defaultTextForm(controller:nameController , label:'name', border: const OutlineInputBorder(), inputType: TextInputType.text),
                const SizedBox(height: 7),
                defaultTextForm(controller:phoneController , label:'phone', border: const OutlineInputBorder(), inputType: TextInputType.text),
                const SizedBox(height: 7),
                defaultTextForm(controller:bioController , label:'bio', border: const OutlineInputBorder(), inputType: TextInputType.text),
                const SizedBox(height: 7),
              ],
            ),
          ),
        );
        });

  }
}

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app_firebase/b_layer_bloc/register/register_states.dart';

import '../../models/creat_user.dart';
class SocialRegisterCubit extends Cubit<SocialRegisterStates>
{
  SocialRegisterCubit():super(SocialRegisterInitialState());
  static  SocialRegisterCubit get(context)=>BlocProvider.of(context);



  void userRegister({
    required String name,
    required String email,
    required String password,
    required String phone,

  })
  {
    emit(SocialRegisterLoadingState());
    FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email, password: password
    ).then((value)
    {
      createUser(
          name: name,
          email: email,
          uId: value.user!.uid,
          phone: phone,

      );

    }).catchError((error)
    {
      emit(SocialRegisterErrorState(error.toString()));
    });
  }

  void createUser({
    required String name,
    required String email,
    required String uId,
    required String phone,
  })
  {
    SocialCreateUser? model=SocialCreateUser(
        name: name,
        email: email,
        phone: phone,
        uId: uId,
        bio:'write bio',
        image: 'https://images.pexels.com/photos/1264210/pexels-photo-1264210.jpeg?auto=compress&cs=tinysrgb&w=600',
        cover: 'https://images.pexels.com/photos/91227/pexels-photo-91227.jpeg?auto=compress&cs=tinysrgb&w=600'
    );
    emit(CreateUserLoadingState());
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(model.toMap()).
    then((value)
    {

      emit(CreateUserSuccessState());
    }).catchError((error)
    {
      emit(CreateUserErrorState(error.toString()));
    });
  }



  IconData suffix=Icons.visibility_outlined;
  bool isPassword=true;

  void changIconRegister()
  {
    suffix=isPassword?Icons.visibility_outlined:Icons.visibility_off_outlined;
    isPassword=!isPassword;
    emit(SocialRegisterChangePasswordVisibilityState());
  }


}
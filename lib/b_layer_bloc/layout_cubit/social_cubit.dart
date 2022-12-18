import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app_firebase/b_layer_bloc/layout_cubit/social_state.dart';
import 'package:social_app_firebase/c_layer_ui/moduls/btm_nav_modules/chat.dart';
import 'package:social_app_firebase/c_layer_ui/moduls/btm_nav_modules/home.dart';
import 'package:social_app_firebase/c_layer_ui/moduls/btm_nav_modules/post.dart';
import 'package:social_app_firebase/c_layer_ui/moduls/btm_nav_modules/settings.dart';
import 'package:social_app_firebase/models/comment.dart';
import 'package:social_app_firebase/models/messages.dart';
import 'package:social_app_firebase/models/new_post.dart';
import 'package:social_app_firebase/z_shared/componants.dart';
import 'package:firebase_storage/firebase_storage.dart'as firebase_storage;
import '../../models/creat_user.dart';
import '../../z_shared/constants.dart';

class HomePageCubit extends Cubit<HomePageStates> {
  HomePageCubit() :super(HomePageIntial());

  static HomePageCubit get(context) => BlocProvider.of(context);


  SocialCreateUser? model;

  void getUserData() {
    emit(GetUserLoading());
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .get()
        .then((value) {
      model = SocialCreateUser.fromJson(value.data()!);
      emit(GetUserSuccess());
    }).catchError((error) {
      print(error.toString());
      emit(GetUserError());
    });
  }

  var currentIndex = 0;

  void BottomNavBar(index, context) {
    if (index==1){
      getAllUsers();
    }
    if (index == 2) {
      navigatorPush(context: context, widget: Post());
    } else {
      currentIndex = index;
      emit(BtmNAV());
    }
  }

  List<Widget>screens = [
      Homepage(),
    const Chats(),
    const Post(),
    const Setting(),
  ];
  List<String>title = [
    'Home',
    'Chats',
    'Post',
    'Settings',
  ];


  File? profileImage;
  var picker = ImagePicker();
  Future<void> getProfileImage() async {
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      profileImage = File(pickedImage.path);
      emit(PickProfileImageSuccess());
    } else {
      print('no photo');
      emit(PickCoverImageError());
    }
  }


  File? coverImage;
  Future<void> getCoverImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      coverImage = File(pickedFile.path);
      emit(PickCoverImageSuccess());
    } else {
      print('a7a');
      emit(PickCoverImageError());
    }
  }



  void uploadProfileImage(){
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!).then((value) {
          value.ref.getDownloadURL().then((value) {
            updateUser(image: value);
            emit(UploadProfileImageSuccess());
          }).catchError((error){
            emit(UploadProfileImageError());
            print(error.toString());
          });
    }).catchError((error){
      emit(UploadProfileImageError());
      print(error.toString());
    });
  }

  void uploadCoverImage(){
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(coverImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        updateUser(cover: value);
        emit(UploadCoverImageSuccess());
      }).catchError((error){
        emit(UploadCoverImageError());
      });
    }).catchError((error){
      emit(UploadCoverImageError());
    });
  }

    void updateUser({
        String? name,
        String? bio,
        String? phone,
        String? image,
        String? cover
    }){
      emit(UpdateDataLoading());
    // updateUserImages();
      SocialCreateUser? modelUpdated=SocialCreateUser(
          name: name??model!.name,
          email: model!.email,
          phone: phone??model!.phone,
          uId:model!.uId,
          bio:bio??model!.bio,
          image:image?? model!.image,
          cover: cover??model!.cover
      );
      FirebaseFirestore.instance
          .collection('users')
          .doc(model!.uId)
          .update(modelUpdated.toMap())
          .then((value) {
        getUserData();

      })
          .catchError((error) {
        emit(UpdateDataImageError());
        print(error.toString());
      });


  }

  File? postImage;
  Future<void> getPostImage() async {
    final pickedImagePost = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImagePost != null) {
      postImage = File(pickedImagePost.path);
      emit(UploadPostImageSuccess());
    } else {
      print('no photo');
      emit(UploadPostImageError());
    }
  }
    void removePostImage(){
      postImage=null;
      emit(RemovePostImage());

  }

  void uploadPostImage({
  required String text,
    required String dateTime,
  }){
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(postImage!.path).pathSegments.last}')
        .putFile(postImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        createPost(text: text, dateTime: dateTime,image: value);
        emit(UploadPostImageSuccess());
      }).catchError((error){
        emit(UploadPostImageError());
      });
    }).catchError((error){
      emit(UploadPostImageError());
    });
  }

  void createPost({
    required String text,
    required String dateTime,
    String? image,
  }){
    emit(CreatePostLoading());
    // updateUserImages();
    CreatePost? postModel=CreatePost(
        name:model!.name,
        uId:model!.uId,
        image:model!.image,
        text: text,
        dateTime: dateTime,
        postImage: image??'',
    );
    FirebaseFirestore.instance
        .collection('posts')
        .add(postModel.toMap())
        .then((value) {
          emit(CreatePostSuccess());

    })
        .catchError((error) {
      emit(CreatePostError());
      print(error.toString());
    });


  }

  List<CreatePost> posts=[];
  List<String> postId =[];
  List<int>likes =[];

  void getAllPosts() {
    FirebaseFirestore.instance
        .collection('posts')
        .get()
        .then((value){
          value.docs.forEach((element) {
        element.reference.collection('Likes').get().then((value) {
          likes.add(value.docs.length);
        });
        postId.add(element.id);
            posts.add(CreatePost.fromJson(element.data()));
          });
      GetPostsSuccess();
    })
        .catchError((error) {
      emit(GetPostsError());
      print(error.toString());
    });
  }

  void uploadLikes(String postingId){
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postingId)
        .collection('Likes')
        .doc(model!.uId)
        .set({
      'Likes':true
    })
        .then((value) {
          emit(UploadLikeSuccess());
    })
        .catchError((error){
          emit(UploadLikeError());
      print(error.toString());
    });
  }

  List<CommentsModel> comments=[];
  void getComments ({
  required String postId,
}){
    FirebaseFirestore
    .instance
        .collection('posts')
        .doc(postId)
        .collection('comments').orderBy('dateTime')
        .get()
        .then((value) {
          comments=[];
          value.docs.forEach((element) {
            comments.add(CommentsModel.fromJson(element.data()));
            emit(GetCommentsSuccess());
          });
    }).catchError((error){
      emit(GetCommentsError());
    });

  }


  void uploadComments({
    required String? postId,
    required String? text,
    required String dateTime,
  }){
    CommentsModel commentsModel =CommentsModel(
      postId: postId,
      text: text,
      dateTime: dateTime
    );
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .add(commentsModel.toMap())
        .then((value) {
      emit(UploadCommentsSuccess());
    })
        .catchError((error){
      emit(UploadCommentsError());
      print(error.toString());
    });
  }

List<SocialCreateUser>users=[];

  void getAllUsers() {
    users=[];
    emit(GetAllUserChatLoading());
    FirebaseFirestore.instance
        .collection('users')
        .get()
        .then((value){
      value.docs.forEach((element) {
        if(element.data()['uId'] != model!.uId)
        users.add(SocialCreateUser.fromJson(element.data()));
      });
      emit(GetAllUserChatSuccess());


    })
        .catchError((error) {
      emit(GetAllUserChatError());
      print(error.toString());
    });
  }


  void sendMessage({
  required String? reciverId,
  required String? text,
  required String dateTime,
  }){

    ChatModel chatModel=ChatModel(
      reciverId: reciverId,
      sederId: model!.uId,
      dateTime: dateTime,
      text: text
    );
    FirebaseFirestore
        .instance
        .collection('users')
        .doc(model!.uId)
        .collection('chats')
        .doc(reciverId)
        .collection('message')
        .add(chatModel.toMap())
        .then((value){
          emit(SendMessageSuccess());
    })
        .catchError((error){
      emit(SendMessageError());
    });

    FirebaseFirestore
        .instance
        .collection('users')
        .doc(reciverId)
        .collection('chats')
        .doc(model!.uId)
        .collection('message')
        .add(chatModel.toMap())
        .then((value){
      emit(RecivedMessageSuccess());
    })
        .catchError((error){
      emit(RecivedMessageError());
    });

  }
List<ChatModel> messages=[];
  void getMessages({
  required String? recivedId
})
  {
    FirebaseFirestore.instance
        .collection('users')
        .doc(model!.uId)
        .collection('chats')
        .doc(recivedId)
        .collection('message')
    .orderBy('dateTime')
        .snapshots()
        .listen((event)
    {
          messages=[];
          event.docs.forEach((element) {
            messages.add(ChatModel.fromJson(element.data()));
          });
          print(messages[0]..toString());
          emit(GetMessageSuccess());
    });
    
  }


}
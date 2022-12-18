import 'package:social_app_firebase/models/creat_user.dart';

abstract class HomePageStates{}
class HomePageIntial extends HomePageStates{}

class HomePageLoading extends HomePageStates{}
class HomePageSuccess extends HomePageStates{}
class HomePageError extends HomePageStates{}

class GetUserLoading extends HomePageStates{}
class GetUserSuccess extends HomePageStates{}
class GetUserError extends HomePageStates{}

class PickProfileImageSuccess extends HomePageStates{}
class PickProfileImageError extends HomePageStates{}

class PickCoverImageSuccess extends HomePageStates{}
class PickCoverImageError extends HomePageStates{}

class UploadProfileImageSuccess extends HomePageStates{}
class UploadProfileImageError extends HomePageStates{}

class UploadCoverImageSuccess extends HomePageStates{}
class UploadCoverImageError extends HomePageStates{}

class UpdateDataLoading extends HomePageStates{}
class UpdateDataImageError extends HomePageStates{}


class UploadPostImageSuccess extends HomePageStates{}
class UploadPostImageError extends HomePageStates{}

class CreatePostSuccess extends HomePageStates{}
class CreatePostError extends HomePageStates{}
class CreatePostLoading extends HomePageStates{}

class RemovePostImage extends HomePageStates{}

class GetPostsLoading extends HomePageStates{}
class GetPostsSuccess extends HomePageStates{}
class GetPostsError extends HomePageStates{}

class UploadLikeSuccess extends HomePageStates{}
class UploadLikeError extends HomePageStates{}

class UploadCommentsSuccess extends HomePageStates{}
class UploadCommentsError extends HomePageStates{}
class GetCommentsSuccess extends HomePageStates{}
class GetCommentsError extends HomePageStates{}

class GetAllUserChatLoading extends HomePageStates{}
class GetAllUserChatSuccess extends HomePageStates{}
class GetAllUserChatError extends HomePageStates{}

class SendMessageSuccess extends HomePageStates{}
class SendMessageError extends HomePageStates{}
class RecivedMessageSuccess extends HomePageStates{}
class RecivedMessageError extends HomePageStates{}

class GetMessageSuccess extends HomePageStates{}


class BtmNAV extends HomePageStates{}


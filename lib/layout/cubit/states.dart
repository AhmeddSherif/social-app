abstract class SocialStates {}

class InitialState extends SocialStates {}

class GetUserLoadingState extends SocialStates {}

class GetUserSuccessState extends SocialStates {}

class GetUserErrorState extends SocialStates {
  final String error;

  GetUserErrorState(this.error);
}

class ChangeBottomNavBarState extends SocialStates {}

class ProfileImagePickedSuccessState extends SocialStates {}

class ProfileImagePickedErrorState extends SocialStates {}

class CoverImagePickedSuccessState extends SocialStates {}

class CoverImagePickedErrorState extends SocialStates {}

class UploadProfileImageSuccessState extends SocialStates {}

class UploadProfileImageErrorState extends SocialStates {}

class UploadCoverImageSuccessState extends SocialStates {}

class UploadCoverImageErrorState extends SocialStates {}

class UpdateUserLoadingState extends SocialStates {}

class UpdateUserErrorState extends SocialStates {}

//post states

//creating post states

class CreatePostLoadingState extends SocialStates {}

class CreatePostSuccessState extends SocialStates {}

class CreatePostErrorState extends SocialStates {}

//getting post states

class GetPostsLoadingState extends SocialStates {}

class GetPostsSuccessState extends SocialStates {}

class GetPostsErrorState extends SocialStates {
  final String error;

  GetPostsErrorState(this.error);
}

class GetAllUsersLoadingState extends SocialStates {}

class GetAllUsersSuccessState extends SocialStates {}

class GetAllUsersErrorState extends SocialStates {
  final String error;

  GetAllUsersErrorState(this.error);
}

//getting post states

class LikePostSuccessState extends SocialStates {}

class ChangeLikePostSuccessState extends SocialStates {}

class LikePostErrorState extends SocialStates {
  final String error;

  LikePostErrorState(this.error);
}

class UnLikePostSuccessState extends SocialStates {}

class UnLikePostErrorState extends SocialStates {
  final String error;

  UnLikePostErrorState(this.error);
}

//picking and removing post image states

class PostImagePickedSuccessState extends SocialStates {}

class PostImagePickedErrorState extends SocialStates {}

class RemovePostImageState extends SocialStates {}

//picking and removing post video states

class PostVideoPickedSuccessState extends SocialStates {}

class PostVideoPickedErrorState extends SocialStates {}

class RemovePostVideoState extends SocialStates {}

//pausing and playing post video states

class PlayPostVideoState extends SocialStates {}

class PausePostVideoState extends SocialStates {}

class ChangeNameVisibilityState extends SocialStates {}

class SendMessageSuccessState extends SocialStates {}

class SendMessageErrorState extends SocialStates {}

class GetMessageSuccessState extends SocialStates {}

class GetMessageErrorState extends SocialStates {}

class DeleteMessageSuccessState extends SocialStates {}

class DeleteMessageErrorState extends SocialStates {}

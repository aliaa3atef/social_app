abstract class SocialCubitStates {}

class SocialCubitInitialState extends SocialCubitStates {}

class SocialGetUserLoadingState extends SocialCubitStates {}

class SocialGetUserSuccessState extends SocialCubitStates {}

class SocialGetUserErrorState extends SocialCubitStates {
  final String error;

  SocialGetUserErrorState(this.error);
}

class SocialPostState extends SocialCubitStates {}

class SocialChangeBottomNavState extends SocialCubitStates {}

class SocialSelectProfileImageSuccessState extends SocialCubitStates {}

class SocialSelectProfileImageErrorState extends SocialCubitStates {}

class SocialSelectCoverImageSuccessState extends SocialCubitStates {}

class SocialSelectCoverImageErrorState extends SocialCubitStates {}

class SocialUploadProfileImageLoadingState extends SocialCubitStates {}

class SocialUploadCoverImageLoadingState extends SocialCubitStates {}

class SocialUploadProfileImageSuccessState extends SocialCubitStates {}

class SocialUploadProfileImageErrorState extends SocialCubitStates {}

class SocialUploadCoverImageSuccessState extends SocialCubitStates {}

class SocialUploadCoverImageErrorState extends SocialCubitStates {}

class SocialUpdateCoverLoadingState extends SocialCubitStates {}

class SocialUpdateProfileLoadingState extends SocialCubitStates {}

class SocialUpdateCoverErrorState extends SocialCubitStates {}

class SocialUpdateProfileErrorState extends SocialCubitStates {}

class SocialUploadUserDataLoadingState extends SocialCubitStates {}

class SocialUploadUserDataErrorState extends SocialCubitStates {}

class SocialSelectPostImageSuccessState extends SocialCubitStates {}

class SocialSelectPostImageErrorState extends SocialCubitStates {}

class SocialUploadPostImageSuccessState extends SocialCubitStates {}

class SocialUploadPostImageErrorState extends SocialCubitStates {}

class SocialUploadPostLoadingState extends SocialCubitStates {}

class SocialUploadPostSuccessState extends SocialCubitStates {}

class SocialUploadPostErrorState extends SocialCubitStates {}

class SocialDeletePostImageState extends SocialCubitStates {}

class SocialGetPostsLoadingState extends SocialCubitStates {}

class SocialGetPostsSuccessState extends SocialCubitStates {}

class SocialGetPostsErrorState extends SocialCubitStates {
  final String error;

  SocialGetPostsErrorState(this.error);
}

class SocialLikePostSuccessState extends SocialCubitStates {}

class SocialLikePostErrorState extends SocialCubitStates {
  final String error;

  SocialLikePostErrorState(this.error);
}

class SocialGetAllUsersLoadingState extends SocialCubitStates {}

class SocialGetAllUsersSuccessState extends SocialCubitStates {}

class SocialGetAllUsersErrorState extends SocialCubitStates {
  final String error;

  SocialGetAllUsersErrorState(this.error);
}

class SocialSendMessagesSuccessState extends SocialCubitStates {}

class SocialSendMessagesErrorState extends SocialCubitStates {
  final String error;

  SocialSendMessagesErrorState(this.error);
}

class SocialReceiveMessagesSuccessState extends SocialCubitStates {}

class SocialSendNotificationSuccessState extends SocialCubitStates {}

class SocialSendNotificationErrorState extends SocialCubitStates {
  final String error;

  SocialSendNotificationErrorState(this.error);
}

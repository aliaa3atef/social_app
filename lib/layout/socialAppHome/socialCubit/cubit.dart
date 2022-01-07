import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:socail/layout/socialAppHome/socialCubit/states.dart';
import 'package:socail/models/chatModel/chatModel.dart';
import 'package:socail/models/notificationModel/notifictaionModel.dart';
import 'package:socail/models/postModel/postModel.dart';
import 'package:socail/models/socialUserModel/socialUserModel.dart';
import 'package:socail/modules/chats/chatsScreen.dart';
import 'package:socail/modules/feeds/feedsScreen.dart';
import 'package:socail/modules/newPost/postScreen.dart';
import 'package:socail/modules/settings/settingsScreen.dart';
import 'package:socail/modules/users/usersScreen.dart';
import 'package:socail/shared/components/components.dart';
import 'package:socail/shared/components/constants.dart';
import 'package:socail/shared/network/remote/DioHelper.dart';

class SocialCubit extends Cubit<SocialCubitStates> {
  SocialCubit() : super(SocialCubitInitialState());

  static SocialCubit get(context) => BlocProvider.of(context);

  SocialUserModel model;

  void getUserData() {
    emit(SocialGetUserLoadingState());

    print('id = $uId');
    FirebaseFirestore.instance.collection('Users').doc(uId).get().then((value) {
      model = SocialUserModel.fromJson(value.data());
      print(model.toMap());
      emit(SocialGetUserSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SocialGetUserErrorState(error.toString()));
    });
  }

  List<Widget> screens = [
    FeedsScreen(),
    ChatsScreen(),
    PostScreen(),
    SettingsScreen(),
  ];

  List<String> titles = ['Home', 'Chats', 'Post', 'Users', 'Settings'];

  int current_index = 0;

  void changeBottomNavIndex(int index) {
    if (index == 1) getAllUsers();

    if (index == 2)
      emit(SocialPostState());
    else {
      current_index = index;
      emit(SocialChangeBottomNavState());
    }
  }

  File profileImage;

  var picker = ImagePicker();

  Future<void> selectProfileImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (PickedFile != null) {
      profileImage = File(pickedFile.path);
      uploadProfileImage();
      emit(SocialSelectProfileImageSuccessState());
    } else {
      print('No Image Selected');
      emit(SocialSelectProfileImageErrorState());
    }
  }

  File coverImage;

  Future<void> selectCoverImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (PickedFile != null) {
      coverImage = File(pickedFile.path);
      uploadCoverImage();
      emit(SocialSelectCoverImageSuccessState());
    } else {
      print('No Image Selected');
      emit(SocialSelectCoverImageErrorState());
    }
  }

  void uploadProfileImage() {
    emit(SocialUploadProfileImageLoadingState());

    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/profile/${Uri.file(profileImage.path).pathSegments.last}')
        .putFile(profileImage)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        emit(SocialUploadProfileImageSuccessState());
        updateProfile(profileURL: value);
      }).catchError((error) {
        emit(SocialUploadProfileImageErrorState());
      });
    }).catchError((error) {
      emit(SocialUploadProfileImageErrorState());
    });
  }

  void uploadCoverImage() {
    emit(SocialUploadCoverImageLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/cover/${Uri.file(coverImage.path).pathSegments.last}')
        .putFile(coverImage)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        emit(SocialUploadCoverImageSuccessState());
        updateCover(coverURL: value);
      }).catchError((error) {
        emit(SocialUploadCoverImageErrorState());
      });
    }).catchError((error) {
      emit(SocialUploadCoverImageErrorState());
    });
  }

  void updateCover({@required String coverURL}) {
    emit(SocialUpdateCoverLoadingState());

    SocialUserModel userModel = SocialUserModel(
      name: model.name,
      bio: model.bio,
      image: model.image,
      cover: coverURL,
      phone: model.phone,
      email: model.email,
      uid: model.uid,
    );
    FirebaseFirestore.instance
        .collection('Users')
        .doc(uId)
        .update(userModel.toMap())
        .then((value) {
      getUserData();
    }).catchError((error) {
      emit(SocialUpdateCoverErrorState());
    });
  }

  void updateProfile({@required String profileURL}) {
    emit(SocialUpdateProfileLoadingState());

    SocialUserModel userModel = SocialUserModel(
      name: model.name,
      bio: model.bio,
      image: profileURL,
      cover: model.cover,
      phone: model.phone,
      email: model.email,
      uid: model.uid,
    );
    FirebaseFirestore.instance
        .collection('Users')
        .doc(uId)
        .update(userModel.toMap())
        .then((value) {
      getUserData();
    }).catchError((error) {
      emit(SocialUpdateCoverErrorState());
    });
  }

  void updateUserDataInFireBase({
    @required String name,
    @required String bio,
  }) {
    emit(SocialUploadUserDataLoadingState());

    SocialUserModel userModel = SocialUserModel(
      name: name,
      bio: bio,
      image: model.image,
      cover: model.cover,
      phone: model.phone,
      email: model.email,
      uid: model.uid,
    );
    FirebaseFirestore.instance
        .collection('Users')
        .doc(uId)
        .update(userModel.toMap())
        .then((value) {
      getUserData();
    }).catchError((error) {
      emit(SocialUploadUserDataErrorState());
    });
  }

  File postImage;

  Future<void> selectPostImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (PickedFile != null) {
      postImage = File(pickedFile.path);
      emit(SocialSelectPostImageSuccessState());
    } else {
      print('No Image Selected');
      emit(SocialSelectPostImageErrorState());
    }
  }

  void uploadPostImage({
    @required String date,
    @required String post,
  }) {
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(postImage.path).pathSegments.last}')
        .putFile(postImage)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        createPost(date: date, post: post, postImage: value);
        emit(SocialUploadPostImageSuccessState());
      }).catchError((error) {
        emit(SocialUploadPostImageErrorState());
      });
    }).catchError((error) {
      emit(SocialUploadPostImageErrorState());
    });
  }

  void createPost({
    @required String date,
    @required String post,
    String postImage,
  }) {
    emit(SocialUploadPostLoadingState());

    PostModel userModel = PostModel(
      name: model.name,
      image: model.image,
      date: date,
      uid: model.uid,
      post: post,
      postImage: postImage ?? '',
    );
    FirebaseFirestore.instance
        .collection('Posts')
        .add(userModel.toMap())
        .then((value) {
      emit(SocialUploadPostSuccessState());
    }).catchError((error) {
      emit(SocialUploadPostErrorState());
    });
  }

  void removePostImage() {
    postImage = null;
    emit(SocialDeletePostImageState());
  }

  List<PostModel> post = [];
  List<String> postId = [];
  List<int> likes = [];

  void getPosts() {
    emit(SocialGetPostsLoadingState());

    FirebaseFirestore.instance.collection('Posts').get().then((value) {
      value.docs.forEach((element) {
        element.reference.collection('Likes').snapshots().listen((value) {
          likes.add(value.docs.length);
          postId.add(element.id);
          post.add(PostModel.fromJson(element.data()));
        });
      });
      emit(SocialGetPostsSuccessState());
    }).catchError((error) {
      emit(SocialGetPostsErrorState(error.toString()));
    });
  }

  void likePost(postId) {
    FirebaseFirestore.instance
        .collection('Posts')
        .doc(postId)
        .collection('Likes')
        .doc(model.uid)
        .set({
      'likes': true,
    }).then((value) {
      emit(SocialLikePostSuccessState());
    }).catchError((error) {
      emit(SocialLikePostErrorState(error.toString()));
    });
  }

  List<SocialUserModel> users = [];

  void getAllUsers() {
    emit(SocialGetAllUsersLoadingState());

    if (users.length == 0)
      FirebaseFirestore.instance.collection('Users').snapshots().listen((value) {
        value.docs.forEach((element) {
          if (element.data()['uid'] != model.uid)
            users.add(SocialUserModel.fromJson(element.data()));
        });
        emit(SocialGetAllUsersSuccessState());
      });
  }

  ChatModel chatModel;

  void sendMessages({
    @required String msg,
    @required String date,
    @required String receiverId,
    String image
  }) {
    chatModel = ChatModel(
      date: date,
      message: msg,
      receiverId: receiverId,
      senderId: model.uid,
    );
    FirebaseFirestore.instance
        .collection('Users')
        .doc(model.uid)
        .collection('Chats')
        .doc(chatModel.receiverId)
        .collection('Messages')
        .add(chatModel.toMap())
        .then((value) {
      sendNotification(
          deviceToken: deviceToken,
          title: "You Have a message from ${model.name}",
          body: msg);
      emit(SocialSendMessagesSuccessState());
    }).catchError((error) {
      emit(SocialSendMessagesErrorState(error.toString()));
    });

    FirebaseFirestore.instance
        .collection('Users')
        .doc(chatModel.receiverId)
        .collection('Chats')
        .doc(model.uid)
        .collection('Messages')
        .add(chatModel.toMap())
        .then((value) {
      emit(SocialSendMessagesSuccessState());
    }).catchError((error) {
      emit(SocialSendMessagesErrorState(error.toString()));
    });
  }


  List<ChatModel> messages = [];

  void receiveMessages({@required String receiverId}) {
    FirebaseFirestore.instance
        .collection('Users')
        .doc(model.uid)
        .collection('Chats')
        .doc(receiverId)
        .collection('Messages')
        .orderBy('date')
        .snapshots()
        .listen((event) {
      messages = [];
      event.docs.forEach((element) {
        messages.add(ChatModel.fromJson(element.data()));
      });
      emit(SocialReceiveMessagesSuccessState());
    });
  }

  NotificationModel notificationModel;

  void sendNotification({
    @required String deviceToken,
    @required String title,
     String body,
  }) {
    DioHelper.postData(url: 'fcm/send', data: {
      "to": deviceToken,
      "notification": {"title": title, "body": body}
    }).then((value) {
      print("data = ${value.data}");
      emit(SocialSendNotificationSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SocialSendNotificationErrorState(error.toString()));
    });
  }

  void firebaseSignOut(context, screen) {
    FirebaseAuth.instance
        .signOut()
        .then((value) => navigateTo(context: context, screen: screen));
  }

}

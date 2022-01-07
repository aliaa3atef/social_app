import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socail/models/socialUserModel/socialUserModel.dart';
import 'package:socail/modules/socialRegister/socialResgisterCubit/state.dart';


class SocialRegisterCubit extends Cubit<SocialRegisterStates> {
  SocialRegisterCubit() : super(SocialRegisterInitialState());

  static SocialRegisterCubit get(context) => BlocProvider.of(context);

  bool isPassword = true;
  var suffix = Icons.visibility;

  void changeVisibilityIcon() {
    isPassword = !isPassword;
    suffix = isPassword ? Icons.visibility : Icons.visibility_off;

    emit(SocialLogChangeVisibilityIconState());
  }

  void register({
    @required String name,
    @required String email,
    @required String password,
    @required String cover,
    @required String image,
    @required String bio,
    @required String phone,
  }) {
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      print(value.user.uid);
      createUser(
          name: name,
          email: email,
          phone: phone,
          cover: cover,
          image: image,
          bio: bio,
          uID: value.user.uid);
    }).catchError((error) {
      print(error.toString());
      emit(SocialRegisterErrorState(error.toString()));
    });
  }

  void createUser({
    @required String name,
    @required String email,
    @required String phone,
    @required String cover,
    @required String image,
    @required String bio,
    @required String uID,
  }) {
    SocialUserModel socialUserModel = SocialUserModel(
        name: name,
        email: email,
        phone: phone,
        cover: cover,
        image: image,
        bio: bio,
        uid: uID);

    FirebaseFirestore.instance
        .collection('Users')
        .doc(uID)
        .set(socialUserModel.toMap())
        .then((value) {
      emit(SocialCreateUserSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SocialCreateUserErrorState(error.toString()));
    });
  }
}

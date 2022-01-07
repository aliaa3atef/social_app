import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socail/modules/socialLogin/socialLoginCubit/state.dart';

class SocialLoginCubit extends Cubit<SocialLoginStates> {
  SocialLoginCubit() : super(SocialLoginInitialState());

  static SocialLoginCubit get(context) => BlocProvider.of(context);

  bool isPassword = true;
  var suffix = Icons.visibility;


  void changeVisibilityIcon() {

    isPassword = !isPassword;
    suffix = isPassword
        ? Icons.visibility
        : Icons.visibility_off ;

    emit(SocialLogChangeVisibilityIconState());
  }


  void login({@required String email, @required String password}) {

    emit(SocialLoginLoadingState());

    FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password).then((value){
          print(value.user.uid);
          emit(SocialLoginSuccessState(value.user.uid));
    }).catchError((error){
      emit(SocialLoginErrorState(error.toString()));
    });


  }

}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socail/layout/socialAppHome/socialCubit/cubit.dart';
import 'package:socail/layout/socialAppHome/socialCubit/states.dart';
import 'package:socail/modules/newPost/postScreen.dart';
import 'package:socail/modules/socialLogin/socialLoginScreen.dart';
import 'package:socail/shared/components/components.dart';
import 'package:socail/shared/styles/icon_broken.dart';


class SocialHome extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit , SocialCubitStates>(
        builder: (context , state){
          var cubit = SocialCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Text(cubit.titles[cubit.current_index]),
              actions: [
                  IconButton(icon: Icon(IconBroken.Notification), onPressed: (){}),
                  IconButton(icon: Icon(IconBroken.Logout), onPressed: (){
                    cubit.firebaseSignOut(context , SocialLoginScreen());
                  }),
              ],
            ),
            body: cubit.screens[cubit.current_index],
            bottomNavigationBar: BottomNavigationBar(
              items: [
                BottomNavigationBarItem(icon: Icon(IconBroken.Home) , label: "Home"),
                BottomNavigationBarItem(icon: Icon(IconBroken.Chat) , label: "Chats"),
                BottomNavigationBarItem(icon: Icon(IconBroken.Paper_Download) , label: "Post"),
               // BottomNavigationBarItem(icon: Icon(IconBroken.Location) , label: "Users"),
                BottomNavigationBarItem(icon: Icon(IconBroken.Setting) , label: "Settings"),
              ],
              currentIndex: cubit.current_index,
              onTap: (index)=> cubit.changeBottomNavIndex(index),
            ),

          );
        },
        listener: (context , state){
          if(state is SocialPostState)
            navigateTo(context: context, screen: PostScreen());
        }
    );
  }
}

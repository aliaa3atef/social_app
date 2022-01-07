import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socail/layout/socialAppHome/socialCubit/cubit.dart';
import 'package:socail/layout/socialAppHome/socialCubit/states.dart';
import 'package:socail/shared/components/components.dart';
import 'package:socail/shared/styles/colors.dart';
import 'package:socail/shared/styles/icon_broken.dart';


class EditProfileScreen extends StatelessWidget {
  var nameController = TextEditingController();
  var bioController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialCubitStates>(
      builder: (context, state) {
        var cubit = SocialCubit.get(context);
        var cubitModel = SocialCubit.get(context).model;
        var profileImage = SocialCubit.get(context).profileImage;
        var coverImage = SocialCubit.get(context).coverImage;

        nameController.text = cubitModel.name;
        bioController.text = cubitModel.bio;
        return Scaffold(
          appBar: defaultAppBar(
            context: context,
            title: "Edit Profile",
            actions: [
              OutlinedButton(
                onPressed: () {
                        cubit.updateUserDataInFireBase(
                        name: nameController.text, bio: bioController.text);
                },
                child: Text('Update'),
              ),
              SizedBox(
                width: 20,
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [

                  if (state is SocialUploadProfileImageLoadingState)
                         LinearProgressIndicator(),
                  if (state is SocialUploadCoverImageLoadingState)
                        LinearProgressIndicator(),

                  Container(
                    height: 210,
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Align(
                          alignment: Alignment.topCenter,
                          child: Stack(
                            alignment: AlignmentDirectional.topEnd,
                            children: [
                              Container(
                                width: double.infinity,
                                height: 150,
                                margin: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: coverImage == null
                                          ? NetworkImage('${cubitModel.cover}')
                                          : FileImage(coverImage),
                                      fit: BoxFit.cover),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                              IconButton(
                                  icon: CircleAvatar(
                                      backgroundColor: Colors.white,
                                      radius: 25,
                                      child: Icon(
                                        IconBroken.Camera,
                                        size: 20,
                                      )),
                                  onPressed: () {
                                    cubit.selectCoverImage();
                                  }),
                            ],
                          ),
                        ),
                        Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            CircleAvatar(
                              backgroundColor: colorApp,
                              radius: 63,
                              child: CircleAvatar(
                                backgroundColor:
                                    Theme.of(context).scaffoldBackgroundColor,
                                radius: 60,
                                backgroundImage: profileImage == null
                                    ? NetworkImage('${cubitModel.image}')
                                    : FileImage(profileImage),
                              ),
                            ),
                            IconButton(
                                icon: CircleAvatar(
                                    backgroundColor: Colors.white,
                                    radius: 25,
                                    child: Icon(
                                      IconBroken.Camera,
                                      size: 20,
                                    )),
                                onPressed: () {
                                  cubit.selectProfileImage();
                                }),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  sharedTextFormField(
                    controller: nameController,
                    prefixIcon: IconBroken.User,
                    text: 'User Name',
                    validate: (String value) {
                      if (value.isEmpty) return "User Name Must Not Be Empty";
                      return null;
                    },
                    type: TextInputType.name,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  sharedTextFormField(
                    controller: bioController,
                    prefixIcon: IconBroken.Info_Circle,
                    text: 'Bio',
                    validate: (String value) {
                      if (value.isEmpty) return "Bio Must Not Be Empty";
                      return null;
                    },
                    type: TextInputType.text,
                  ),
                ],
              ),
            ),
          ),
        );
      },
      listener: (context, state) {
        if (state is SocialGetUserSuccessState)
          showToast('data updated Successfully', Colors.green, context);

        if (state is SocialUploadProfileImageSuccessState)
          showToast(
              'profile image updated Successfully', Colors.green, context);

        if (state is SocialUploadCoverImageSuccessState)
          showToast('cover image updated Successfully', Colors.green, context);
      },
    );
  }
}

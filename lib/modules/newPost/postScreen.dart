import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socail/layout/socialAppHome/socialCubit/cubit.dart';
import 'package:socail/layout/socialAppHome/socialCubit/states.dart';
import 'package:socail/shared/components/components.dart';
import 'package:socail/shared/styles/icon_broken.dart';


class PostScreen extends StatelessWidget {
  var postController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialCubitStates>(
      builder: (context, state) {
        var cubit = SocialCubit.get(context);
        var userModel = cubit.model;

        return Scaffold(
          appBar:
              defaultAppBar(context: context, title: "Create Post", actions: [
            sharedTextButton(
                onPress: () {
                  if (cubit.postImage == null) {
                    cubit.createPost(
                        date: DateTime.now().toString(),
                        post: postController.text);
                  } else
                    cubit.uploadPostImage(
                      date: DateTime.now().toString(),
                      post: postController.text,
                    );
                },
                text: 'post'),
          ]),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                if (state is SocialUploadPostLoadingState)
                  LinearProgressIndicator(),
                if (state is SocialUploadPostLoadingState)
                  SizedBox(
                    height: 5,
                  ),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: NetworkImage('${userModel.image}'),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              '${userModel.name}',
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1
                                  .copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Expanded(
                  child: TextFormField(
                    controller: postController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "What Is In Your Mind ? ... ",
                    ),
                  ),
                ),
                if (cubit.postImage != null)
                  Stack(
                    alignment: AlignmentDirectional.topEnd,
                    children: [
                      Container(
                        width: double.infinity,
                        height: 150,
                        margin: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: FileImage(cubit.postImage),
                              fit: BoxFit.cover),
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      IconButton(
                          icon: CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 25,
                              child: Icon(
                                Icons.close,
                                size: 20,
                              )),
                          onPressed: () {
                            cubit.removePostImage();
                          }),
                    ],
                  ),
                if (cubit.postImage != null)
                  SizedBox(
                    height: 30,
                  ),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          cubit.selectPostImage();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(IconBroken.Image),
                            SizedBox(
                              width: 5,
                            ),
                            Text('Add Photo'),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                        child: TextButton(
                      onPressed: () {},
                      child: Text('# Tags'),
                    )),
                  ],
                ),
              ],
            ),
          ),
        );
      },
      listener: (context, state) {},
    );
  }
}

import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socail/layout/socialAppHome/socialCubit/cubit.dart';
import 'package:socail/layout/socialAppHome/socialCubit/states.dart';
import 'package:socail/models/postModel/postModel.dart';
import 'package:socail/shared/components/components.dart';
import 'package:socail/shared/styles/colors.dart';
import 'package:socail/shared/styles/icon_broken.dart';


class FeedsScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialCubitStates>(
        listener: (context, state) {
          if(state is SocialLikePostSuccessState)
            showToast('Liked', colorApp, context);
        },
        builder: (context, state) {
          return ConditionalBuilder(
            condition: SocialCubit.get(context).post.length > 0 || SocialCubit.get(context).model != null,
            builder:(context) => SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  if(state is SocialGetPostsLoadingState )
                    LinearProgressIndicator(),

                  Card(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: Container(
                      width: double.infinity,
                      height: 200,
                      margin: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(
                                'https://media.istockphoto.com/photos/social-media-picture-id1201792304?k=20&m=1201792304&s=170667a&w=0&h=osgMKYdYqZ8WLeXOp2ztZ6y2HXznhj_S4ofNkKEW7Wk='),
                            fit: BoxFit.fill),
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) => buildPostItem(
                        context, SocialCubit.get(context).post[index], index),
                    separatorBuilder: (context, index) => SizedBox(
                      height: 10,
                    ),
                    itemCount: SocialCubit.get(context).post.length,
                  ),
                  SizedBox(
                    height: 10,
                  )
                ],
              ),
            ),
            fallback: (context)=>Center(child: CircularProgressIndicator()),
          );
        });
  }

  Widget buildPostItem(context, PostModel postModel, index) => Card(
        elevation: 5,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //image , name , date of post sender
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 25,
                        backgroundImage: NetworkImage('${postModel.image}'),
                      ),
                      SizedBox(
                        width: 10,
                      ),

                      if(SocialCubit.get(context).post.length == 0)
                        Center(child: Text("No Posts Yet" , style: TextStyle(
                          fontSize: 50 , color: Colors.grey
                        ),),),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                '${postModel.name}',
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1
                                    .copyWith(
                                      height: 1.5,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Icon(
                                Icons.check_circle_rounded,
                                color: colorApp,
                                size: 16,
                              )
                            ],
                          ),
                          Text(
                            '${postModel.date}',
                            style: Theme.of(context).textTheme.caption.copyWith(
                                  height: 1.5,
                                ),
                          ),
                        ],
                      ),
                      Spacer(),
                      IconButton(
                          icon: Icon(Icons.more_horiz), onPressed: () {}),
                    ],
                  ),

                  Divider(
                    thickness: .2,
                  ),

                  // post
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    child: Text(
                      '${postModel.post}',
                      style: Theme.of(context).textTheme.subtitle2.copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),

                  // tags
                  // Padding(
                  //   padding: const EdgeInsets.only(top: 5),
                  //   child: Container(
                  //     width: double.infinity,
                  //     child: Wrap(
                  //       children: [
                  //         Padding(
                  //           padding: const EdgeInsetsDirectional.only(end: 8.0),
                  //           child: Container(
                  //             height: 25,
                  //             child: MaterialButton(
                  //               onPressed: () {},
                  //               child: Text(
                  //                 '#flutter',
                  //                 style: Theme.of(context)
                  //                     .textTheme
                  //                     .caption
                  //                     .copyWith(
                  //                       color: colorApp,
                  //                     ),
                  //               ),
                  //               height: 20,
                  //               minWidth: 1,
                  //               padding: EdgeInsets.zero,
                  //             ),
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),

                  // post image
                  if (postModel.postImage != '')
                    Padding(
                      padding: const EdgeInsetsDirectional.only(top: 10),
                      child: Container(
                        width: double.infinity,
                        height: 180,
                        margin: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage('${postModel.postImage}'),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),

                  // likes , comment number
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      children: [
                        Expanded(child: InkWell(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Row(
                              children: [
                                Icon(
                                  IconBroken.Heart ,
                                  size: 18,
                                  color: colorApp,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "${SocialCubit.get(context).likes[index]}",
                                  style: Theme.of(context).textTheme.caption,
                                ),
                              ],
                            ),
                          ),
                          onTap: () {},
                        )),
                        Expanded(
                          child: InkWell(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Icon(
                                    IconBroken.Chat,
                                    size: 14,
                                    color: colorApp,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "0 comment",
                                    style: Theme.of(context).textTheme.caption,
                                  ),
                                ],
                              ),
                            ),
                            onTap: () {},
                          ),
                        ),
                      ],
                    ),
                  ),

                  Divider(
                    thickness: .2,
                  ),
                  // write a comment or like post or share post
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            child: Row(
                              children: [
                                CircleAvatar(
                                  radius: 25,
                                  backgroundImage: NetworkImage(
                                      '${SocialCubit.get(context).model.image}'),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'write a comment...',
                                  style: Theme.of(context).textTheme.caption,
                                ),
                              ],
                            ),
                            onTap: () {},
                          ),
                        ),
                        InkWell(
                          child: Row(
                            children: [
                              Icon(
                                IconBroken.Heart,
                                size: 16,
                                color: colorApp,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                "Like",
                                style: Theme.of(context).textTheme.caption,
                              ),
                            ],
                          ),
                          onTap: () {
                            SocialCubit.get(context).likePost(
                                SocialCubit.get(context).postId[index] );
                          },
                        ),
                        SizedBox(
                          width: 10,
                        ),

                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
}

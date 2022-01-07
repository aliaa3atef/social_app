import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socail/layout/socialAppHome/socialCubit/cubit.dart';
import 'package:socail/layout/socialAppHome/socialCubit/states.dart';
import 'package:socail/modules/editProfile/editProfileScreen.dart';
import 'package:socail/shared/components/components.dart';
import 'package:socail/shared/styles/colors.dart';
import 'package:socail/shared/styles/icon_broken.dart';


class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return BlocConsumer<SocialCubit , SocialCubitStates>
      (
        builder: (context , state){
          return  Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Container(
                  height: 210,
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                          width: double.infinity,
                          height: 150,
                          margin: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(
                                    '${SocialCubit.get(context).model.cover}'),
                                fit: BoxFit.cover),
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                      ),
                      CircleAvatar(
                        backgroundColor: colorApp,
                        radius: 63,
                        child: CircleAvatar(
                          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                          radius: 60,
                          backgroundImage: NetworkImage(
                              '${SocialCubit.get(context).model.image}'),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "${SocialCubit.get(context).model.name}",
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "${SocialCubit.get(context).model.bio}",
                  style: Theme.of(context).textTheme.caption,
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      border: Border.all(color: colorApp),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            child: Column(
                              children: [
                                Text(
                                  "130",
                                  style: Theme.of(context).textTheme.bodyText2,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "Post",
                                  style: Theme.of(context).textTheme.caption,
                                ),
                              ],
                            ),
                            onTap: (){},
                          ),
                        ),

                        Expanded(
                          child: InkWell(
                            child: Column(
                              children: [
                                Text(
                                  "100",
                                  style: Theme.of(context).textTheme.bodyText2,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "Image",
                                  style: Theme.of(context).textTheme.caption,
                                ),
                              ],
                            ),
                            onTap: (){},
                          ),
                        ),

                        Expanded(
                          child: InkWell(
                            child: Column(
                              children: [
                                Text(
                                  "10K",
                                  style: Theme.of(context).textTheme.bodyText2,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "Follwers",
                                  style: Theme.of(context).textTheme.caption,
                                ),
                              ],
                            ),
                            onTap: (){},
                          ),
                        ),

                        Expanded(
                          child: InkWell(
                            child: Column(
                              children: [
                                Text(
                                  "200",
                                  style: Theme.of(context).textTheme.bodyText2,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "Following",
                                  style: Theme.of(context).textTheme.caption,
                                ),
                              ],
                            ),
                            onTap: (){},
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                Row(
                  children: [
                    Expanded(child: OutlinedButton(onPressed: (){}, child: Text('Add Photos'))),
                    SizedBox(
                      width: 5,
                    ),
                    OutlinedButton(onPressed: (){
                      navigateTo(context: context, screen: EditProfileScreen());
                    }, child: Icon(IconBroken.Edit)),
                  ],
                ),

              ],
            ),
          );
        },
        listener: (context , state){
          if(state is! SocialGetUserLoadingState || SocialCubit.get(context).model!=null)
            return Center(child: CircularProgressIndicator());

        },
    );
  }
}

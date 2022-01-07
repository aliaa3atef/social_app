import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socail/layout/socialAppHome/socialCubit/cubit.dart';
import 'package:socail/layout/socialAppHome/socialCubit/states.dart';
import 'package:socail/models/chatModel/chatModel.dart';
import 'package:socail/models/socialUserModel/socialUserModel.dart';
import 'package:socail/shared/components/components.dart';
import 'package:socail/shared/styles/colors.dart';
import 'package:socail/shared/styles/icon_broken.dart';

class ChatDetailsScreen extends StatelessWidget {
  final SocialUserModel model;

  ChatDetailsScreen(this.model);

  final msgController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        SocialCubit.get(context).receiveMessages(receiverId: model.uid);

        return BlocConsumer<SocialCubit, SocialCubitStates>(
          listener: (context, state) {},
          builder: (context, state) => Scaffold(
            appBar: AppBar(
                /*actions: [
                  IconButton(
                    icon: Icon(
                      Icons.attachment,
                      color: colorApp,
                    ),
                    onPressed: () {
                      buildAlertDialog(context: context ,);
                    },
                  ),
                ],*/
                titleSpacing: 0,
                title: Row(
                  children: [
                    CircleAvatar(
                      radius: 25,
                      backgroundImage: NetworkImage('${model.image}'),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      '${model.name}',
                      style: Theme.of(context).textTheme.subtitle1.copyWith(
                            fontSize: 20,
                          ),
                    ),
                  ],
                )),
            body: ConditionalBuilder(
              condition: SocialCubit.get(context).messages.length >= 0,
              builder: (context) => Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.separated(
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            if (SocialCubit.get(context).model.uid ==
                                SocialCubit.get(context)
                                    .messages[index]
                                    .senderId)
                              return buildMyChatItem(context,
                                  SocialCubit.get(context).messages[index]);

                            return buildChatItem(context,
                                SocialCubit.get(context).messages[index]);
                          },
                          separatorBuilder: (context, index) => SizedBox(
                                height: 10,
                              ),
                          itemCount: SocialCubit.get(context).messages.length),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey[300]),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: msgController,
                                decoration: InputDecoration(
                                  hintText: "Type Your Message ...",
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                            OutlinedButton(
                              onPressed: () {
                                if (msgController.text != "") {
                                  SocialCubit.get(context).sendMessages(
                                    msg: msgController.text,
                                    date: DateTime.now().toString(),
                                    receiverId: model.uid,
                                  );
                                  msgController.text = "";
                                } else
                                  showToast("Enter Message", colorApp, context);
                              },
                              child: Icon(IconBroken.Send),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              fallback: (context) => Center(child: CircularProgressIndicator()),
            ),
          ),
        );
      },
    );
  }

  Widget buildChatItem(context, ChatModel model) => Align(
        alignment: AlignmentDirectional.topStart,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadiusDirectional.only(
              topStart: Radius.circular(10),
              topEnd: Radius.circular(10),
              bottomEnd: Radius.circular(10),
            ),
          ),
          child: Text(
            model.message,
            style: Theme.of(context).textTheme.bodyText2,
          ),
        ),
      );

  Widget buildMyChatItem(context, ChatModel model) => Align(
        alignment: AlignmentDirectional.centerEnd,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          decoration: BoxDecoration(
            color: colorApp.withOpacity(.3),
            borderRadius: BorderRadiusDirectional.only(
              topStart: Radius.circular(10),
              topEnd: Radius.circular(10),
              bottomStart: Radius.circular(10),
            ),
          ),
          child: Text(
            model.message,
            style: Theme.of(context).textTheme.bodyText2,
          ),
        ),
      );

/*Widget sendImage(selectedImage) {
    return Container(
      width: 160,
      height: 230,
      decoration: BoxDecoration(
        border: Border.all(color: colorApp , width: 1),
        image: DecorationImage(image: FileImage(selectedImage), fit: BoxFit.fill),
      ),
    );
  }*/

/*Future<void> buildAlertDialog({
    @required BuildContext context,
  }) {
    final AlertDialog alert = AlertDialog(
      backgroundColor: Colors.white,
      content: Container(
        height: 120,
        padding: EdgeInsets.zero,
        margin: EdgeInsets.zero,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
        child: Column(
          children: [
            Expanded(
              child: InkWell(
                onTap: () {
                  SocialCubit.get(context).selectChatImage(ImageSource.camera);
                  Navigator.pop(context);
                },
                child: Row(
                  children: [
                    Icon(IconBroken.Camera),
                    SizedBox(
                      width: 5,
                    ),
                    Text("Camera"),
                  ],
                ),
              ),
            ),
            Divider(
              color: Colors.grey[300],
            ),
            Expanded(
              child: InkWell(
                onTap: () {
                  SocialCubit.get(context).selectChatImage(ImageSource.gallery);
                  Navigator.pop(context);
                  },
                child: Row(
                  children: [
                    Icon(IconBroken.Image),
                    SizedBox(
                      width: 5,
                    ),
                    Text("Gallery"),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (_) {
          return alert;
        });
  }
*/

}

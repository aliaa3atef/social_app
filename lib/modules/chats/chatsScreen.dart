import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socail/layout/socialAppHome/socialCubit/cubit.dart';
import 'package:socail/layout/socialAppHome/socialCubit/states.dart';
import 'package:socail/models/socialUserModel/socialUserModel.dart';
import 'package:socail/modules/chat_details/chatDetailsScreen.dart';
import 'package:socail/shared/components/components.dart';

class ChatsScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialCubitStates>
      (
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: SocialCubit.get(context).users.length > 0 || SocialCubit.get(context).model != null,
          builder: (context)=> ListView.separated(itemBuilder: (context , index)=>buildChatItem(SocialCubit.get(context).users[index] , context),
              separatorBuilder: (context , index)=> SizedBox(height: 10,),
              itemCount: SocialCubit.get(context).users.length,
          ),
          fallback: (context)=> Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget buildChatItem(SocialUserModel model , context)
  {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: InkWell(
        onTap: (){
          navigateTo(context: context, screen: ChatDetailsScreen(model));
        },
        child: Row(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage(
                  '${model.image}'),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              '${model.name}',
              style: Theme.of(context)
                  .textTheme
                  .subtitle1
                  .copyWith(
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

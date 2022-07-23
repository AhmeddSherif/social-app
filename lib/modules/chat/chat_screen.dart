import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:facebook/layout/cubit/cubit.dart';
import 'package:facebook/layout/cubit/states.dart';
import 'package:facebook/modules/chat_details/chat_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/user_model.dart';
import '../../shared/functions.dart';
import '../../shared/styles/colors.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text("Chat"),
            ),
            body: ConditionalBuilder(
              condition: SocialCubit.get(context).users.isNotEmpty,
              builder: (context) => ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) => buildChatItem(
                      SocialCubit.get(context).users[index], context),
                  separatorBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32.0),
                        child: Divider(
                          color: Colors.grey.shade300,
                        ),
                      ),
                  itemCount: SocialCubit.get(context).users.length),
              fallback: (context) => Center(
                  child: Text('Nothing to show up here.',
                      style: TextStyle(
                          color: Colors.grey.shade500,
                          fontSize: 18,
                          fontFamily: 'Lato-Regular'))),
            ),
          );
        });
  }

  Widget buildChatItem(UserModel model, context) => InkWell(
        onTap: () {
          navigateTo(
              ChatDetailsScreen(
                user: model,
              ),
              context);
        },
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              CircleAvatar(
                radius: 25.0,
                backgroundImage: NetworkImage(model.image!),
              ),
              SizedBox(width: 15.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          model.name!,
                          style: TextStyle(
                            height: 1.4,
                          ),
                        ),
                        const SizedBox(width: 5.0),
                        if (model.userVerified!)
                          Column(
                            children: [
                              Icon(
                                Icons.check_circle,
                                color: blueColor,
                                size: 15.0,
                              ),
                            ],
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
}

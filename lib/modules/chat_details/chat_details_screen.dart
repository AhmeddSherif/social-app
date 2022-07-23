import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:facebook/layout/cubit/cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../layout/cubit/states.dart';
import '../../models/message_model.dart';
import '../../models/user_model.dart';
import '../../shared/styles/colors.dart';

class ChatDetailsScreen extends StatelessWidget {
  ChatDetailsScreen({Key? key, required this.user}) : super(key: key);
  final UserModel? user;
  final TextEditingController? messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        SocialCubit.get(context).getMessages(
          receiverId: user!.uId,
        );
        return BlocConsumer<SocialCubit, SocialStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                title: Row(
                  children: [
                    CircleAvatar(
                      radius: 25.0,
                      backgroundImage: NetworkImage(user!.image!),
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
                                user!.name!,
                                style: const TextStyle(
                                  height: 1.4,
                                ),
                              ),
                              const SizedBox(width: 5.0),
                              if (user!.userVerified!)
                                Icon(
                                  Icons.check_circle,
                                  color: blueColor,
                                  size: 15.0,
                                ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              body: ConditionalBuilder(
                condition: SocialCubit.get(context).messages.length > 0,
                builder: (context) {
                  return Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Container(
                      width: double.infinity,
                      height: double.infinity,
                      child: Column(
                        children: [
                          Expanded(
                            child: ListView.separated(
                              physics: const BouncingScrollPhysics(),
                              itemBuilder: (context, index) {
                                var message =
                                    SocialCubit.get(context).messages[index];
                                if (SocialCubit.get(context).user!.uId ==
                                    message.senderId) {
                                  return buildMyMessage(message, context);
                                }
                                return buildMessage(message);
                              },
                              separatorBuilder: (context, index) => SizedBox(
                                height: 15.0,
                              ),
                              itemCount:
                                  SocialCubit.get(context).messages.length,
                            ),
                          ),
                          Spacer(),
                          Row(
                            children: [
                              Expanded(
                                flex: 8,
                                child: Container(
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  decoration: BoxDecoration(
                                    color:
                                        Colors.grey.shade600.withOpacity(0.7),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(20.0),
                                    ),
                                  ),
                                  child: TextFormField(
                                    controller: messageController,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      errorBorder: InputBorder.none,
                                      disabledBorder: InputBorder.none,
                                      filled: true,
                                      fillColor:
                                          Colors.grey.shade800.withOpacity(0.5),
                                      hintText: 'Message',
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: MaterialButton(
                                  onPressed: () {
                                    SocialCubit.get(context).sendMessage(
                                        receiverId: user!.uId!,
                                        message: messageController?.text,
                                        dateTime: DateTime.now().toString());
                                  },
                                  height: 45,
                                  shape: const CircleBorder(),
                                  color: blueColor,
                                  child: Icon(
                                    Icons.send,
                                    color: Colors.grey.shade200,
                                    size: 20.0,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
                fallback: (context) {
                  return Center(
                    child: Column(
                      children: [
                        Text('Nothing to show up here.',
                            style: TextStyle(
                                color: Colors.grey.shade500,
                                fontSize: 18,
                                fontFamily: 'Lato-Regular')),
                        Spacer(),
                        Row(
                          children: [
                            Expanded(
                              flex: 8,
                              child: Container(
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade600.withOpacity(0.7),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(20.0),
                                  ),
                                ),
                                child: TextFormField(
                                  controller: messageController,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    errorBorder: InputBorder.none,
                                    disabledBorder: InputBorder.none,
                                    filled: true,
                                    fillColor:
                                        Colors.grey.shade800.withOpacity(0.5),
                                    hintText: 'Message',
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: MaterialButton(
                                onPressed: () {
                                  print("uId: ${user!.uId}");
                                  SocialCubit.get(context).sendMessage(
                                      receiverId: user!.uId,
                                      message: messageController?.text,
                                      dateTime: DateTime.now().toString());
                                },
                                height: 45,
                                shape: const CircleBorder(),
                                color: blueColor,
                                child: Icon(
                                  Icons.send,
                                  color: Colors.grey.shade200,
                                  size: 20.0,
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            );
          },
        );
      },
    );
  }

  Widget buildMessage(MessageModel model) {
    String formattedDate;
    if (DateTime.now().year.toString() ==
        model.dateTime!.split(' ')[0].split('-')[0]) {
      if (DateTime.now().day.toString() ==
          model.dateTime!.split(' ')[0].split('-')[2]) {
        formattedDate = DateFormat.jm().format(DateTime.parse(model.dateTime!));
      } else {
        formattedDate = DateFormat('h:mm a MMMM d. ')
            .format(DateTime.parse(model.dateTime!));
      }
    } else {
      formattedDate = DateFormat('MM-dd-yyyy HH:mm').format(DateTime.now());
    }
    return Align(
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade600.withOpacity(0.7),
              borderRadius: BorderRadius.all(
                Radius.circular(15.0),
              ),
            ),
            padding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
            child: Text(model.message!),
          ),
          Text(formattedDate,
              style: TextStyle(color: Colors.grey.shade500, fontSize: 12)),
        ],
      ),
    );
  }

  Widget buildMyMessage(MessageModel model, context) {
    String formattedDate =
        DateFormat('MMMM d. h:mm a').format(DateTime.parse(model.dateTime!));
    return Align(
      alignment: Alignment.centerRight,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: blueColor.withOpacity(0.7),
              borderRadius: BorderRadius.all(
                Radius.circular(15.0),
              ),
            ),
            padding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
            child: Text(model.message!),
          ),
          Text(formattedDate,
              style: TextStyle(color: Colors.grey.shade500, fontSize: 12)),
        ],
      ),
    );
  }
}

import 'package:facebook/layout/cubit/cubit.dart';
import 'package:facebook/layout/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';

import '../../models/post_model.dart';
import '../../shared/components/default_button.dart';
import '../../shared/functions.dart';
import '../../shared/styles/colors.dart';
import '../edit_profile/edit_profile_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  //final UserModel? user;

  @override
  Widget build(BuildContext context) {
    SocialCubit().getUserData();
    SocialCubit.get(context).getUserData();
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var user = SocialCubit.get(context).user;
        return SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 250,
                      child: Stack(
                        alignment: Alignment.bottomLeft,
                        children: [
                          Align(
                            alignment: Alignment.topCenter,
                            child: Container(
                              height: 200.0,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(5.0),
                                    topRight: Radius.circular(5.0),
                                  ),
                                  image: DecorationImage(
                                    image: SocialCubit.get(context)
                                                .coverImageUrl !=
                                            null
                                        ? NetworkImage(SocialCubit.get(context)
                                            .coverImageUrl!)
                                        : NetworkImage(user!.cover!),
                                    fit: BoxFit.cover,
                                  )),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 12.0),
                            child: CircleAvatar(
                              radius: 85.0,
                              backgroundColor:
                                  Theme.of(context).scaffoldBackgroundColor,
                              child: CircleAvatar(
                                radius: 80.0,
                                backgroundImage:
                                    SocialCubit.get(context).profileImageUrl !=
                                            null
                                        ? NetworkImage(SocialCubit.get(context)
                                            .profileImageUrl!)
                                        : NetworkImage(user!.image!),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                user!.name!,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(
                                      fontSize: 30.0,
                                      fontFamily: "Lato-Regular",
                                    ),
                              ),
                              const SizedBox(width: 5.0),
                              if (user.userVerified!)
                                Icon(
                                  Icons.check_circle,
                                  color: blueColor,
                                  size: 25.0,
                                ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            user.bio!,
                            style:
                                Theme.of(context).textTheme.caption!.copyWith(
                                      fontSize: 15.0,
                                    ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 5,
                            child: InkWell(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text('5.6M',
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle2!
                                          .copyWith(
                                            fontSize: 20.0,
                                          )),
                                  Text('Followers',
                                      style: Theme.of(context)
                                          .textTheme
                                          .caption!
                                          .copyWith(
                                            fontSize: 22.0,
                                          )),
                                ],
                              ),
                              onTap: () {},
                            ),
                          ),
                          Expanded(
                            flex: 5,
                            child: InkWell(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text('80',
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle2!
                                          .copyWith(
                                            fontSize: 20.0,
                                          )),
                                  Text('Following',
                                      style: Theme.of(context)
                                          .textTheme
                                          .caption!
                                          .copyWith(
                                            fontSize: 22.0,
                                          )),
                                ],
                              ),
                              onTap: () {},
                            ),
                          ),
                          Expanded(
                            flex: 5,
                            child: InkWell(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text('200',
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle2!
                                          .copyWith(
                                            fontSize: 20.0,
                                          )),
                                  Text('Friends',
                                      style: Theme.of(context)
                                          .textTheme
                                          .caption!
                                          .copyWith(
                                            fontSize: 22.0,
                                          )),
                                ],
                              ),
                              onTap: () {},
                            ),
                          ),
                          Expanded(
                            flex: 5,
                            child: InkWell(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text('512',
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle2!
                                          .copyWith(
                                            fontSize: 20.0,
                                          )),
                                  Text('Posts',
                                      style: Theme.of(context)
                                          .textTheme
                                          .caption!
                                          .copyWith(
                                            fontSize: 22.0,
                                          )),
                                ],
                              ),
                              onTap: () {},
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 6,
                          child: Container(
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: defaultButton(
                              onPressed: () {
                                navigateTo(EditProfileScreen(), context);
                              },
                              height: 50,
                              color: blueColor,
                              child: Text(
                                'Edit Profile',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(
                                      fontSize: 20.0,
                                      color: Colors.white,
                                    ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          flex: 1,
                          child: InkWell(
                            onTap: () {},
                            radius: 15,
                            child: Container(
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.0),
                                color: Colors.grey.shade600.withOpacity(0.5),
                              ),
                              height: 50.0,
                              child: const Icon(Icons.more_horiz_outlined),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: double.infinity,
                  height: 3.0,
                  color: Colors.grey.shade700,
                ),
              ),
              // Expanded(
              //   child: ListView.separated(
              //     itemBuilder: (context, index) => buildPostItem(
              //         SocialCubit.get(context).myPosts[index], context, index),
              //     separatorBuilder: (context, index) => const SizedBox(
              //       height: 15.0,
              //     ),
              //     itemCount: SocialCubit.get(context).myPosts.length,
              //   ),
              // ),
            ],
          ),
        ));
      },
    );
  }

  Widget buildPostItem(PostModel model, context, int index) {
    var user = SocialCubit.get(context).user;
    print(model.postVideo != '');
    Future<void>? initializeVideoPlayerFuture;
    VideoPlayerController? controller;
    controller = VideoPlayerController.network(
      model.postVideo!,
    );
    initializeVideoPlayerFuture = controller.initialize();

    // Use the controller to loop the video.
    controller.setLooping(true);
    controller.play();
    controller.setVolume(100);

    return Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: 10.0,
        margin: const EdgeInsets.all(8.0),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
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
                            Icon(
                              Icons.check_circle,
                              color: blueColor,
                              size: 15.0,
                            ),
                          ],
                        ),
                        Text(
                          model.dateTime!,
                          style: Theme.of(context).textTheme.caption!.copyWith(
                                height: 1.4,
                              ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 15.0),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.more_vert,
                      size: 20.0,
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  model.text!,
                  style: Theme.of(context).textTheme.subtitle1!.copyWith(
                        fontSize: 16.0,
                      ),
                ),
              ),
              if (1 == 0)
                Container(
                  width: double.infinity,
                  child: Wrap(
                    children: [
                      Container(
                        height: 25.0,
                        child: MaterialButton(
                          onPressed: () {},
                          height: 25.0,
                          minWidth: 1.0,
                          padding: EdgeInsets.zero,
                          child: const Text("#Air_Balloon",
                              style: TextStyle(color: Colors.blueAccent)),
                        ),
                      ),
                      SizedBox(width: 8.0),
                      Container(
                        height: 25.0,
                        child: MaterialButton(
                          onPressed: () {},
                          height: 25.0,
                          minWidth: 1.0,
                          padding: EdgeInsets.zero,
                          child: const Text("#Exciting",
                              style: TextStyle(color: Colors.blueAccent)),
                        ),
                      ),
                      SizedBox(width: 8.0),
                      Container(
                        height: 25.0,
                        child: MaterialButton(
                          onPressed: () {},
                          height: 25.0,
                          minWidth: 1.0,
                          padding: EdgeInsets.zero,
                          child: const Text("#Travelling",
                              style: TextStyle(color: Colors.blueAccent)),
                        ),
                      ),
                      SizedBox(width: 8.0),
                      Container(
                        height: 25.0,
                        child: MaterialButton(
                          onPressed: () {},
                          height: 25.0,
                          minWidth: 1.0,
                          padding: EdgeInsets.zero,
                          child: const Text("#New_Experience",
                              style: TextStyle(color: Colors.blueAccent)),
                        ),
                      ),
                      SizedBox(width: 8.0),
                      Container(
                        height: 25.0,
                        child: MaterialButton(
                          onPressed: () {},
                          height: 25.0,
                          minWidth: 1.0,
                          padding: EdgeInsets.zero,
                          child: const Text("#WeekEnd",
                              style: TextStyle(color: Colors.blueAccent)),
                        ),
                      ),
                      SizedBox(width: 8.0),
                      Container(
                        height: 25.0,
                        child: MaterialButton(
                          onPressed: () {},
                          height: 25.0,
                          minWidth: 1.0,
                          padding: EdgeInsets.zero,
                          child: const Text("#NewsLand",
                              style: TextStyle(color: Colors.blueAccent)),
                        ),
                      ),
                    ],
                  ),
                ),
              SizedBox(height: 10.0),
              if (model.postImage == 'a')
                Container(
                  height: 250.0,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      image: DecorationImage(
                        image: NetworkImage(model.postImage!),
                        fit: BoxFit.cover,
                      )),
                ),
              if (model.postVideo == 'a')
                Container(
                    height: 250.0,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: VideoPlayer(controller)),
              const SizedBox(height: 2.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      SocialCubit.get(context)
                          .likePost(SocialCubit.get(context).postsId[index]);
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0.5),
                      child: Column(
                        children: [
                          Text(SocialCubit.get(context).likes[index].toString(),
                              style: Theme.of(context).textTheme.subtitle1!),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.favorite,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 18.0),
                  Expanded(
                    child: Column(
                      children: [
                        Text("5K comments",
                            style: Theme.of(context).textTheme.subtitle1!),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            color: Colors.grey.shade600.withOpacity(0.5),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                CircleAvatar(
                                  radius: 18.0,
                                  backgroundImage: NetworkImage(user!.image!),
                                ),
                                SizedBox(width: 10.0),
                                Text(
                                  "Write a comment.....",
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption!
                                      .copyWith(
                                        height: 1.4,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 18.0),
                  InkWell(
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0.5),
                      child: Column(
                        children: [
                          Text("2K",
                              style: Theme.of(context).textTheme.subtitle1!),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.share,
                              color: Colors.blue,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:like_button/like_button.dart';
import 'package:video_player/video_player.dart';

import '../../layout/cubit/cubit.dart';
import '../../layout/cubit/states.dart';
import '../../models/post_model.dart';
import '../../models/user_model.dart';
import '../../shared/styles/colors.dart';

class NewsFeedScreen extends StatelessWidget {
  const NewsFeedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserModel? model;

    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: SocialCubit.get(context).posts.isNotEmpty &&
              SocialCubit.get(context).user != null,
          builder: (context) => ListView.separated(
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) => buildPostItem(
                  SocialCubit.get(context).posts[index], context, index),
              separatorBuilder: (context, index) => const SizedBox(
                    height: 10,
                  ),
              itemCount: SocialCubit.get(context).posts.length),
          fallback: (context) =>
              const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget buildPostItem(PostModel model, context, int index) {
    var likeCount = SocialCubit.get(context).likes[index];
    var isPostLiked = SocialCubit.get(context)
        .likedPosts[SocialCubit.get(context).postsId[index]];
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
              ConditionalBuilder(
                condition: model.postImage != '',
                builder: (context) => Container(
                  height: 250.0,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      image: DecorationImage(
                        image: NetworkImage(
                            model.postImage != '' ? model.postImage! : ''),
                        fit: BoxFit.cover,
                      )),
                ),
                fallback: (context) => const SizedBox(),
              ),
              ConditionalBuilder(
                condition: model.postVideo != '',
                builder: (context) => Container(
                    height: 250.0,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: VideoPlayer(controller!)),
                fallback: (context) => const SizedBox(),
              ),
              const SizedBox(height: 2.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  LikeButton(
                    countPostion: CountPostion.top,
                    likeCount: likeCount,
                    mainAxisAlignment: MainAxisAlignment.end,
                    onTap: (bool isLiked) async {
                      isLiked = !isLiked;
                      isPostLiked = !isPostLiked;
                      if (SocialCubit.get(context).likedPosts[
                          SocialCubit.get(context).postsId[index]]) {
                        likeCount--;
                        SocialCubit.get(context).unLikePost(
                            SocialCubit.get(context).postsId[index]);
                      } else {
                        likeCount++;
                        SocialCubit.get(context)
                            .likePost(SocialCubit.get(context).postsId[index]);
                      }
                      return SocialCubit.get(context)
                          .likedPosts[SocialCubit.get(context).postsId[index]];
                    },
                    isLiked: SocialCubit.get(context)
                        .likedPosts[SocialCubit.get(context).postsId[index]],
                    size: 25,
                    circleColor: const CircleColor(
                      start: Colors.red,
                      end: Colors.redAccent,
                    ),
                    bubblesColor: const BubblesColor(
                      dotPrimaryColor: Colors.red,
                      dotSecondaryColor: Colors.redAccent,
                    ),
                    likeBuilder: (bool isLiked) {
                      return Icon(
                        SocialCubit.get(context).likedPosts[
                                SocialCubit.get(context).postsId[index]]
                            ? Icons.favorite
                            : Icons.favorite_border,
                        size: 25.0,
                        color: SocialCubit.get(context).likedPosts[
                                SocialCubit.get(context).postsId[index]]
                            ? Colors.redAccent
                            : Colors.black,
                      );
                    },
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
                            color: Colors.grey.shade600.withOpacity(0.6),
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

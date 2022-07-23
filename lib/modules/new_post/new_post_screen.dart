import 'package:facebook/layout/cubit/cubit.dart';
import 'package:facebook/shared/functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:video_player/video_player.dart';

import '../../layout/cubit/states.dart';
import '../../shared/styles/colors.dart';

class NewPostScreen extends StatelessWidget {
  NewPostScreen({Key? key}) : super(key: key);
  final textController = TextEditingController();
  final dateTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var user = SocialCubit.get(context).user;
        // Initialize the controller and store the Future for later use.

        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Scaffold(
            appBar: AppBar(
              title: const Text('Create Post'),
            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    if (state is CreatePostLoadingState)
                      const LinearProgressIndicator(),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 25.0,
                          backgroundImage: NetworkImage(user!.image!),
                        ),
                        const SizedBox(width: 15.0),
                        Row(
                          children: [
                            const Text(
                              "Ahmed Sherif",
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
                      ],
                    ),
                    TextFormField(
                      controller: textController,
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        hintText: 'Unleash your creativity.',
                        hintStyle: TextStyle(
                          color: Colors.grey.shade400,
                          fontSize: 20.0,
                          fontFamily: 'Lato-Regular',
                        ),
                      ),
                      maxLines: null,
                    ),
                    if (SocialCubit.get(context).postImage != null)
                      Align(
                        alignment: Alignment.topRight,
                        child: GestureDetector(
                          onTap: () {},
                          child: Stack(
                            alignment: Alignment.topRight,
                            children: [
                              Container(
                                height: 200.0,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(5.0),
                                      topRight: Radius.circular(5.0),
                                    ),
                                    image: DecorationImage(
                                      image: FileImage(
                                          SocialCubit.get(context).postImage!),
                                      fit: BoxFit.cover,
                                    )),
                              ),
                              IconButton(
                                onPressed: () {
                                  SocialCubit.get(context).removePostImage();
                                },
                                iconSize: 30.0,
                                icon: CircleAvatar(
                                  radius: 30,
                                  backgroundColor:
                                      Theme.of(context).scaffoldBackgroundColor,
                                  child: const Icon(
                                    Icons.close,
                                    size: 15.0,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    if (SocialCubit.get(context).postVideo != null)
                      Align(
                        alignment: Alignment.topRight,
                        child: GestureDetector(
                          onTap: () {},
                          child: Stack(
                            alignment: Alignment.topRight,
                            children: [
                              FutureBuilder(
                                future: SocialCubit.get(context)
                                    .initializeVideoPlayerFuture,
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.done) {
                                    // If the VideoPlayerController has finished initialization, use
                                    // the data it provides to limit the aspect ratio of the video.
                                    return SizedBox(
                                      height: 400,
                                      width: double.infinity,
                                      child: VideoPlayer(
                                          SocialCubit.get(context).controller!),
                                    );
                                  } else {
                                    // If the VideoPlayerController is still initializing, show a
                                    // loading spinner.
                                    return const Center(
                                        child: CircularProgressIndicator());
                                  }
                                },
                              ),
                              IconButton(
                                onPressed: () {
                                  SocialCubit.get(context).removePostVideo();
                                },
                                iconSize: 30.0,
                                icon: CircleAvatar(
                                  radius: 30,
                                  backgroundColor:
                                      Theme.of(context).scaffoldBackgroundColor,
                                  child: const Icon(
                                    Icons.close,
                                    size: 15.0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: TextButton(
                                style: ButtonStyle(
                                  overlayColor: MaterialStateColor.resolveWith(
                                      (states) =>
                                          Colors.redAccent.withOpacity(0.09)),
                                ),
                                onPressed: () {
                                  if (SocialCubit.get(context).postImage ==
                                          null ||
                                      SocialCubit.get(context).postVideo ==
                                          null) {
                                    SocialCubit.get(context).getPostImage();
                                  }
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Icon(
                                      Icons.image,
                                      color: Colors.redAccent,
                                    ),
                                    SizedBox(width: 5.0),
                                    Text('Image',
                                        style:
                                            TextStyle(color: Colors.redAccent))
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: TextButton(
                                onPressed: () {
                                  if (SocialCubit.get(context).postImage ==
                                          null ||
                                      SocialCubit.get(context).postVideo ==
                                          null) {
                                    SocialCubit.get(context)
                                        .getPostVideo(context);
                                  }
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Icon(
                                      Iconsax.video5,
                                      color: Colors.blue,
                                    ),
                                    SizedBox(width: 5.0),
                                    Text('Video')
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: TextButton(
                                  onPressed: () {},
                                  style: ButtonStyle(
                                    overlayColor:
                                        MaterialStateColor.resolveWith(
                                            (states) =>
                                                Colors.green.withOpacity(0.09)),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Icon(
                                        Iconsax.hashtag,
                                        color: Colors.green,
                                      ),
                                      SizedBox(width: 5.0),
                                      Text('Hashtags',
                                          style: TextStyle(color: Colors.green))
                                    ],
                                  )),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5.0),
                        MaterialButton(
                          minWidth: double.infinity,
                          height: 45.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          color: Colors.blueAccent,
                          onPressed: () {
                            FocusScope.of(context).unfocus();
                            if (SocialCubit.get(context).postImage != null &&
                                SocialCubit.get(context).postVideo == null) {
                              SocialCubit.get(context).uploadPostImage(
                                dateTime: dateTime.toLocal().toString(),
                                text: textController.text,
                                postId:
                                    "${SocialCubit.get(context).posts.length + 1}",
                              );
                            } else if (SocialCubit.get(context).postImage ==
                                    null &&
                                SocialCubit.get(context).postVideo != null) {
                              SocialCubit.get(context).uploadPostVideo(
                                dateTime: dateTime.toLocal().toString(),
                                text: textController.text,
                                postId:
                                    "${SocialCubit.get(context).posts.length + 1}",
                              );
                            } else {
                              SocialCubit.get(context).createPost(
                                dateTime: dateTime.toLocal().toString(),
                                text: textController.text,
                                postId:
                                    "${SocialCubit.get(context).posts.length + 1}",
                              );
                            }
                            popPage(context);
                          },
                          child: Text(
                            'Post',
                            style: TextStyle(
                                color: Colors.grey.shade200,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                fontFamily: 'Lato-Regular'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facebook/layout/cubit/states.dart';
import 'package:facebook/models/message_model.dart';
import 'package:facebook/models/user_model.dart';
import 'package:facebook/modules/news_feed/news_feed_screen.dart';
import 'package:facebook/modules/users/users_screen.dart';
import 'package:facebook/shared/network/local/cache_helper.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

import '../../models/post_model.dart';
import '../../modules/notifications/notifications_screen.dart';
import '../../modules/profile/profile_screen.dart';
import '../../shared/constants.dart';

class SocialCubit extends Cubit<SocialStates> {
  SocialCubit() : super(InitialState());

  static SocialCubit get(context) => BlocProvider.of(context);

  UserModel? user;

  void init() {
    getPosts();
    getUserData();
  }

  void getUserData() async {
    emit(GetUserLoadingState());
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .get()
        .then((value) async {
      user = UserModel.fromJson(value.data()!);
      emit(GetUserSuccessState());
    });
  }

  int currentIndex = 0;
  List<Widget> screens = [
    const NewsFeedScreen(),
    const NotificationsScreen(),
    const UsersScreen(),
    const ProfileScreen(),
  ];
  List<String> titles = [
    'News Feed',
    'Notifications',
    'Users',
    'Profile',
  ];

  void changeIndex(int index) {
    currentIndex = index;
    emit(ChangeBottomNavBarState());
  }

  File? profileImage;
  final picker = ImagePicker();

  Future<void> getProfileImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      emit(ProfileImagePickedSuccessState());
    }
  }

  File? coverImage;

  Future<void> getCoverImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      coverImage = File(pickedFile.path);
      emit(CoverImagePickedSuccessState());
    }
  }

  String? profileImageUrl;

  void uploadProfileImage() {
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        emit(UploadProfileImageSuccessState());
        profileImageUrl = value;
        print(profileImageUrl);
      }).catchError((error) {
        emit(UploadProfileImageErrorState());
      });
    }).catchError((error) {
      emit(UploadProfileImageErrorState());
    });
  }

  String? coverImageUrl;

  void uploadCoverImage() {
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(coverImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        emit(UploadCoverImageSuccessState());
        coverImageUrl = value;
      }).catchError((error) {
        emit(UploadCoverImageErrorState());
      });
    }).catchError((error) {
      emit(UploadCoverImageErrorState());
    });
  }

  void updateUser({
    required String? name,
    required String? mobile,
    required String? bio,
    required String? email,
    required String? password,
    required bool? valuesChanged,
    required bool? userVerfied,
  }) {
    emit(UpdateUserLoadingState());

    if (coverImage != null) {
      uploadCoverImage();
      print('cover image uploaded');
    } else {
      print('no cover image');
    }

    if (profileImage != null) {
      uploadProfileImage();
      print('profile image uploaded');
    } else {
      print('no profile image');
    }
    UserModel model = UserModel(
      email: email,
      name: name,
      mobile: mobile,
      isEmailVerified: false,
      uId: uId,
      cover: coverImageUrl ?? user?.cover,
      image: profileImageUrl ?? user?.image,
      bio: bio,
      password: password,
      userVerified: user?.userVerified,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(
          model.toMap(),
        )
        .then((value) {
      getUserData();
    }).catchError((error) {
      emit(UpdateUserErrorState());
      print(error.toString());
    });
  }

  String? oldName;

  String? name;
  bool? isNameVisible = CacheHelper.getData(key: 'NameVisible');

  void changeValues() {
    emit(ChangeNameVisibilityState());
    isNameVisible = !isNameVisible!;
    CacheHelper.putBoolean(key: 'NameVisible', value: isNameVisible!);
    emit(ChangeNameVisibilityState());
  }

  void changeName(bool value) {
    name = user?.name;
    if (!value) {
      name = "Anonymous User";
      //isNameVisible = false;
      emit(ChangeNameVisibilityState());
    } else {
      name = "";

      //isNameVisible = false;
      emit(ChangeNameVisibilityState());
    }
  }

  void removePostImage() {
    postImage = null;
    emit(RemovePostImageState());
  }

  void removePostVideo() {
    postVideo = null;
    emit(RemovePostVideoState());
  }

  void uploadPostImage({
    required String? dateTime,
    required String? text,
    String? postId,
  }) {
    emit(CreatePostLoadingState());

    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(postImage!.path).pathSegments.last}')
        .putFile(postImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        emit(CreatePostSuccessState());
        createPost(
            dateTime: dateTime, text: text, postImage: value, postId: postId);
      }).catchError((error) {
        emit(CreatePostErrorState());
      });
    }).catchError((error) {
      emit(CreatePostErrorState());
    });
  }

  String? postImageUrl;

  void uploadPostVideo({
    required String? dateTime,
    required String? text,
    String? postId,
  }) {
    emit(CreatePostLoadingState());

    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(postVideo!.path).pathSegments.last}')
        .putFile(postVideo!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        emit(CreatePostSuccessState());
        createPost(
            dateTime: dateTime, text: text, postVideo: value, postId: postId);
      }).catchError((error) {
        emit(CreatePostErrorState());
      });
    }).catchError((error) {
      emit(CreatePostErrorState());
    });
  }

  File? postImage;
  File? postVideo;

  Future<void> getPostImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      postImage = File(pickedFile.path);
      emit(PostImagePickedSuccessState());
    } else {
      emit(PostImagePickedErrorState());
    }
  }

  Future<void>? initializeVideoPlayerFuture;
  VideoPlayerController? controller;

  Future<void> getPostVideo(context) async {
    final pickedFile = await picker.pickVideo(source: ImageSource.gallery);
    if (pickedFile != null) {
      postVideo = File(pickedFile.path);
      emit(PostVideoPickedSuccessState());
      controller = VideoPlayerController.file(
        postVideo!,
      );
      initializeVideoPlayerFuture = controller?.initialize();

      // Use the controller to loop the video.
      controller?.setLooping(true);
      controller?.play();
      controller?.setVolume(100);
    } else {
      emit(PostVideoPickedErrorState());
    }
  }

  void createPost({
    required String? dateTime,
    required String? text,
    String? postImage,
    String? postVideo,
    String? postId,
  }) {
    emit(CreatePostLoadingState());

    PostModel model = PostModel(
      name: user!.name,
      uId: user!.uId,
      image: user!.image,
      dateTime: dateTime,
      text: text,
      postImage: postImage ?? '',
      postVideo: postVideo ?? '',
    );
    FirebaseFirestore.instance
        .collection('posts')
        .add(
          model.toMap(),
        )
        .then((value) {
      emit(CreatePostSuccessState());
    }).catchError((error) {
      emit(CreatePostErrorState());
    });

    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .collection('posts')
        .add(
          model.toMap(),
        )
        .then((value) {
      emit(CreatePostSuccessState());
    }).catchError((error) {
      emit(CreatePostErrorState());
    });
    getPosts();
  }

  void playAndPausePostVideo() {
    if (controller!.value.isPlaying) {
      controller?.pause();
      emit(PausePostVideoState());
    } else {
      controller?.play();
      emit(PlayPostVideoState());
    }
  }

  List<PostModel> posts = [];
  List<PostModel> myPosts = [];
  List<String> postsId = [];
  List<String> myPostsId = [];
  List<int> likes = [];
  List<int> myLikes = [];
  List<UserModel> users = [];
  List<bool> liked = [];

  var trueValue = true;
  var falseValue = false;

  void getPosts() {
    emit(GetPostsLoadingState());
    //finalPosts = posts + likedPosts;
    //foreach every post and get it's likes and put the values in a list
    FirebaseFirestore.instance
        .collection('posts')
        .orderBy('text', descending: false)
        .get()
        .then((value) {
      value.docs.forEach((element) {
        element.reference
            .collection('likes')
            .orderBy('uId', descending: false)
            .get()
            .then((value) {
          value.docs.forEach((userLike) {
            usersLikes.add(userLike.id);
            usersLikes.forEach((userElement) {
              if (userElement != user?.uId) {
                likedPosts[element.id] = false;
                print('teset');
                print(likedPosts[element.id]);
              } else {
                likedPosts[element.id] = true;
              }
            });
          });

          posts.add(PostModel.fromJson(element.data()));
          likes.add(value.docs.length);
          postsId.add(element.id);

          var isLiked = usersLikes.contains(user!.uId);
          if (isLiked) {
            likedPosts[element.id] = true;
          } else {
            likedPosts[element.id] = false;
          }
          emit(GetPostsSuccessState());
        }).catchError((error) {
          // posts.add(PostModel.fromJson(element.data(), false));
          print(error.toString());
        });
      });

      emit(GetPostsSuccessState());
    });
  }

  void getPostsLikes() {
    FirebaseFirestore.instance.collection('posts').get().then((value) {
      value.docs.forEach((element) {
        element.reference.collection('likes').get().then((value) {
          value.docs.forEach((userLike) {
            usersLikes.add(userLike.id);
          });
          var isLiked = usersLikes.contains(user!.uId);
          if (isLiked) {
            likedPosts[element.id] = true;
          } else {
            likedPosts[element.id] = false;
          }
          if (posts.isEmpty) {
            posts.add(PostModel.fromJson(element.data()));
          }
          likes.add(value.docs.length);
          postsId.add(element.id);
        }).catchError((error) {
          // posts.add(PostModel.fromJson(element.data(), false));
          print(error.toString());
        });
      });

      emit(GetPostsSuccessState());
    });
  }

  void getMyLikes() {
    FirebaseFirestore.instance.collection('posts').get().then((value) {
      value.docs.forEach((element) {
        element.reference.collection('likes').get().then((value) {
          value.docs.forEach((element) {
            print(element.data()['uId']);
            print(element.id);
            if (element.id == uId) {
              myLikes.add(1);
              print('my like');
            } else {
              myLikes.add(0);
              print('not my like');
            }
          });
        }).catchError((error) {
          print(error.toString());
        });
      });
      emit(GetPostsSuccessState());
    });
  }

  void getMyPosts() {
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .collection('posts')
        .get()
        .then((value) {
      value.docs.forEach((element) {
        element.reference.collection('likes').get().then((value) {
          myLikes.add(value.docs.length);
          myPostsId.add(element.id);
          myPosts.add(PostModel.fromJson(element.data()));
        }).catchError((error) {
          print(error.toString());
        });
      });
      emit(GetPostsSuccessState());
    });
  }

  var likedPosts = {};
  var usersLikes = [];

  void getLikedPosts() {
    //finalPosts = posts + likedPosts;
    posts = [];
    //foreach every post and get it's likes and put the values in a list
    FirebaseFirestore.instance.collection('posts').get().then((value) {
      value.docs.forEach((element) {
        element.reference.collection('likes').get().then((value) {
          value.docs.forEach((userLike) {
            usersLikes.add(userLike.id);
          });
          var isLiked = usersLikes.contains(user!.uId);
          if (isLiked) {
            likedPosts[element.id] = true;
          } else {
            likedPosts[element.id] = false;
          }
        }).catchError((error) {
          print(error.toString());
        });
      });

      emit(GetPostsSuccessState());
    });
  }

  void likePost(String postId) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(user!.uId)
        .set({
      'liked': true,
      'uId': user!.uId,
      'name': user!.name,
      'image': user!.image,
    }).then((value) {
      emit(LikePostSuccessState());
      getPosts();
    }).catchError((error) {
      emit(LikePostErrorState(error.toString()));
    });

    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .get()
        .then((value) {
      likes.add(value.docs.length);
      emit(LikePostSuccessState());
    }).catchError((error) {
      emit(LikePostErrorState(error.toString()));
    });
  }

  void changeLike(dynamic postId) {
    likedPosts[postId] = !likedPosts[postId];
    emit(ChangeLikePostSuccessState());
  }

  void changeLikesNumber() {
    emit(LikePostSuccessState());
  }

  void unLikePost(String postId) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(user!.uId)
        .delete()
        .then((value) {
      emit(UnLikePostSuccessState());
    }).catchError((error) {
      emit(UnLikePostErrorState(error.toString()));
    });
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .get()
        .then((value) {
      likes.add(value.docs.length);
      emit(UnLikePostSuccessState());
    }).catchError((error) {
      emit(UnLikePostErrorState(error.toString()));
    });
  }

  void getUsers() {
    if (users.isEmpty) {
      FirebaseFirestore.instance.collection('users').get().then((value) {
        value.docs.forEach((element) {
          if (element.data()['uId'] != user!.uId) {
            users.add(UserModel.fromJson(element.data()));
          }
        });
        emit(GetAllUsersSuccessState());
      }).catchError((error) {
        emit(GetAllUsersErrorState(error.toString()));
      });
    }
  }

  void sendMessage({
    required String? receiverId,
    required String? message,
    required String? dateTime,
  }) {
    MessageModel model = MessageModel(
      senderId: user!.uId!,
      receiverId: receiverId,
      message: message,
      dateTime: dateTime,
    );

    FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uId!)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .add(model.toMap())
        .then((value) {
      emit(SendMessageSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SendMessageSuccessState());
    });

    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverId)
        .collection('chats')
        .doc(user!.uId!)
        .collection('messages')
        .add(model.toMap())
        .then((value) {
      emit(SendMessageSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SendMessageSuccessState());
    });
  }

  void deleteMessage({
    required String? receiverId,
    required String? message,
    required String? dateTime,
    required String? messageId,
  }) {
    MessageModel model = MessageModel(
      senderId: user!.uId!,
      receiverId: receiverId,
      message: message,
      dateTime: dateTime,
    );

    FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uId!)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .doc(messageId)
        .delete()
        .then(
      (doc) {
        emit(DeleteMessageSuccessState());
      },
      onError: (error) {
        print(error.toString());
        emit(DeleteMessageErrorState());
      },
    );

    FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uId!)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .doc(messageId)
        .delete()
        .then((doc) {
      emit(DeleteMessageSuccessState());
    });
  }

  List<MessageModel> messages = [];

  void getMessages({required String? receiverId}) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
      messages = [];
      event.docs.forEach((element) {
        messages.add(MessageModel.fromJson(element.data()));
      });
      emit(GetMessageSuccessState());
    });
  }
}

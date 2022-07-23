import 'package:facebook/layout/cubit/states.dart';
import 'package:facebook/shared/functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';

import '../../layout/cubit/cubit.dart';
import '../../shared/styles/colors.dart';

class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({Key? key}) : super(key: key);
  //add a form key
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _bioController = TextEditingController();
  final _mobileController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var user = SocialCubit.get(context).user;
    bool changed = false;

    _nameController.text = user!.name!;
    _bioController.text = user.bio!;
    _mobileController.text = user.mobile!;
    _emailController.text = user.email!;
    _passwordController.text = user.password!;
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var profileImage = SocialCubit.get(context).profileImage;
        var coverImage = SocialCubit.get(context).coverImage;
        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Scaffold(
            appBar: AppBar(
              // context: context,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios_new_outlined),
                onPressed: () => Navigator.pop(context),
              ),
              title: const Text('Edit Profile'),
              actions: [
                Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: MaterialButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      color: Colors.blueAccent,
                      onPressed: () {
                        FocusScope.of(context).unfocus();
                        if (_formKey.currentState!.validate()) {
                          SocialCubit.get(context).updateUser(
                            name: _nameController.text,
                            mobile: _mobileController.text,
                            bio: _bioController.text,
                            email: _emailController.text,
                            password: _passwordController.text,
                            valuesChanged: changed,
                            userVerfied: user.userVerified,
                          );

                          popPage(context);
                        }
                      },
                      child: Text(
                        'Update',
                        style: TextStyle(
                            color: Colors.grey.shade200,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            fontFamily: 'Lato-Regular'),
                      ),
                    ),
                  ),
                )
              ],
            ),
            body: Form(
              key: _formKey,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    if (state is UpdateUserLoadingState)
                      const LinearProgressIndicator(),
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
                                  child: GestureDetector(
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) => Dialog(
                                          backgroundColor: Theme.of(context)
                                              .scaffoldBackgroundColor,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(12.0),
                                          ),
                                          child: SizedBox(
                                            width: 350.0,
                                            child: Wrap(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Column(
                                                    children: [
                                                      MaterialButton(
                                                        onPressed: () {
                                                          SocialCubit.get(
                                                                  context)
                                                              .getCoverImage();
                                                        },
                                                        minWidth:
                                                            double.infinity,
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        12.0)),
                                                        animationDuration:
                                                            const Duration(
                                                                milliseconds:
                                                                    0),
                                                        splashColor: null,
                                                        enableFeedback: false,
                                                        child: Align(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Row(
                                                            children: [
                                                              Icon(
                                                                Iconsax.image4,
                                                                color: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .caption!
                                                                    .color,
                                                                size: 20,
                                                              ),
                                                              const SizedBox(
                                                                  width: 8.0),
                                                              Text(
                                                                'Select Cover Picture',
                                                                style: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .caption!
                                                                    .copyWith(
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        fontSize:
                                                                            16,
                                                                        fontFamily:
                                                                            'Lato-Regular'),
                                                                textAlign:
                                                                    TextAlign
                                                                        .start,
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      MaterialButton(
                                                        onPressed: () {},
                                                        minWidth:
                                                            double.infinity,
                                                        child: Align(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Row(
                                                            children: [
                                                              Icon(
                                                                Iconsax
                                                                    .picture_frame,
                                                                color: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .caption!
                                                                    .color,
                                                                size: 20,
                                                              ),
                                                              const SizedBox(
                                                                  width: 8.0),
                                                              Text(
                                                                'View Cover Picture',
                                                                style: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .caption!
                                                                    .copyWith(
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        fontSize:
                                                                            16,
                                                                        fontFamily:
                                                                            'Lato-Regular'),
                                                                textAlign:
                                                                    TextAlign
                                                                        .start,
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                    child: Stack(
                                      alignment: Alignment.bottomRight,
                                      children: [
                                        Container(
                                          height: 200.0,
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  const BorderRadius.only(
                                                topLeft: Radius.circular(5.0),
                                                topRight: Radius.circular(5.0),
                                              ),
                                              image: DecorationImage(
                                                image: coverImage == null
                                                    ? NetworkImage(user.cover!)
                                                    : FileImage(coverImage)
                                                        as ImageProvider,
                                                fit: BoxFit.cover,
                                              )),
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            showDialog(
                                              context: context,
                                              builder: (context) => Dialog(
                                                backgroundColor: Theme.of(
                                                        context)
                                                    .scaffoldBackgroundColor,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12.0),
                                                ),
                                                child: SizedBox(
                                                  width: 350.0,
                                                  child: Wrap(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Column(
                                                          children: [
                                                            MaterialButton(
                                                              onPressed: () {
                                                                //TODO: Add Cover image cropper
                                                                SocialCubit.get(
                                                                        context)
                                                                    .getCoverImage();
                                                              },
                                                              minWidth: double
                                                                  .infinity,
                                                              shape: RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              12.0)),
                                                              animationDuration:
                                                                  const Duration(
                                                                      milliseconds:
                                                                          0),
                                                              splashColor: null,
                                                              enableFeedback:
                                                                  false,
                                                              child: Align(
                                                                alignment: Alignment
                                                                    .centerLeft,
                                                                child: Row(
                                                                  children: [
                                                                    Icon(
                                                                      Iconsax
                                                                          .image4,
                                                                      color: Theme.of(
                                                                              context)
                                                                          .textTheme
                                                                          .caption!
                                                                          .color,
                                                                      size: 20,
                                                                    ),
                                                                    const SizedBox(
                                                                        width:
                                                                            8.0),
                                                                    Text(
                                                                      'Select Cover Picture',
                                                                      style: Theme.of(
                                                                              context)
                                                                          .textTheme
                                                                          .caption!
                                                                          .copyWith(
                                                                              fontWeight: FontWeight.bold,
                                                                              fontSize: 16,
                                                                              fontFamily: 'Lato-Regular'),
                                                                      textAlign:
                                                                          TextAlign
                                                                              .start,
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                            MaterialButton(
                                                              onPressed: () {},
                                                              minWidth: double
                                                                  .infinity,
                                                              child: Align(
                                                                alignment: Alignment
                                                                    .centerLeft,
                                                                child: Row(
                                                                  children: [
                                                                    Icon(
                                                                      Iconsax
                                                                          .picture_frame,
                                                                      color: Theme.of(
                                                                              context)
                                                                          .textTheme
                                                                          .caption!
                                                                          .color,
                                                                      size: 20,
                                                                    ),
                                                                    const SizedBox(
                                                                        width:
                                                                            8.0),
                                                                    Text(
                                                                      'View Cover Picture',
                                                                      style: Theme.of(
                                                                              context)
                                                                          .textTheme
                                                                          .caption!
                                                                          .copyWith(
                                                                              fontWeight: FontWeight.bold,
                                                                              fontSize: 16,
                                                                              fontFamily: 'Lato-Regular'),
                                                                      textAlign:
                                                                          TextAlign
                                                                              .start,
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                          iconSize: 40.0,
                                          icon: const CircleAvatar(
                                            radius: 40,
                                            child: Icon(
                                              Icons.photo_camera_outlined,
                                              size: 20.0,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) => Dialog(
                                          backgroundColor: Theme.of(context)
                                              .scaffoldBackgroundColor,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(12.0),
                                          ),
                                          child: SizedBox(
                                            width: 350.0,
                                            child: Wrap(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Column(
                                                    children: [
                                                      MaterialButton(
                                                        onPressed: () {
                                                          //TODO: Add Profile image cropper
                                                          SocialCubit.get(
                                                                  context)
                                                              .getProfileImage();
                                                        },
                                                        minWidth:
                                                            double.infinity,
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        12.0)),
                                                        animationDuration:
                                                            const Duration(
                                                                milliseconds:
                                                                    0),
                                                        splashColor: null,
                                                        enableFeedback: false,
                                                        child: Align(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Row(
                                                            children: [
                                                              Icon(
                                                                Iconsax.image4,
                                                                color: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .caption!
                                                                    .color,
                                                                size: 20,
                                                              ),
                                                              const SizedBox(
                                                                  width: 8.0),
                                                              Text(
                                                                'Select Profile Picture',
                                                                style: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .caption!
                                                                    .copyWith(
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        fontSize:
                                                                            16,
                                                                        fontFamily:
                                                                            'Lato-Regular'),
                                                                textAlign:
                                                                    TextAlign
                                                                        .start,
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      MaterialButton(
                                                        onPressed: () {},
                                                        minWidth:
                                                            double.infinity,
                                                        child: Align(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Row(
                                                            children: [
                                                              Icon(
                                                                Iconsax
                                                                    .picture_frame,
                                                                color: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .caption!
                                                                    .color,
                                                                size: 20,
                                                              ),
                                                              const SizedBox(
                                                                  width: 8.0),
                                                              Text(
                                                                'View Profile Picture',
                                                                style: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .caption!
                                                                    .copyWith(
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        fontSize:
                                                                            16,
                                                                        fontFamily:
                                                                            'Lato-Regular'),
                                                                textAlign:
                                                                    TextAlign
                                                                        .start,
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                    child: Stack(
                                      alignment: Alignment.bottomRight,
                                      children: [
                                        CircleAvatar(
                                          radius: 85.0,
                                          backgroundColor: Theme.of(context)
                                              .scaffoldBackgroundColor,
                                          child: CircleAvatar(
                                            radius: 80.0,
                                            backgroundImage:
                                                profileImage == null
                                                    ? NetworkImage(user.image!)
                                                    : FileImage(profileImage)
                                                        as ImageProvider,
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            showDialog(
                                              context: context,
                                              builder: (context) => Dialog(
                                                backgroundColor: Theme.of(
                                                        context)
                                                    .scaffoldBackgroundColor,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12.0),
                                                ),
                                                child: SizedBox(
                                                  width: 350.0,
                                                  child: Wrap(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Column(
                                                          children: [
                                                            MaterialButton(
                                                              onPressed: () {
                                                                SocialCubit.get(
                                                                        context)
                                                                    .getProfileImage();
                                                              },
                                                              minWidth: double
                                                                  .infinity,
                                                              shape: RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              12.0)),
                                                              animationDuration:
                                                                  const Duration(
                                                                      milliseconds:
                                                                          0),
                                                              splashColor: null,
                                                              enableFeedback:
                                                                  false,
                                                              child: Align(
                                                                alignment: Alignment
                                                                    .centerLeft,
                                                                child: Row(
                                                                  children: [
                                                                    Icon(
                                                                      Iconsax
                                                                          .image4,
                                                                      color: Theme.of(
                                                                              context)
                                                                          .textTheme
                                                                          .caption!
                                                                          .color,
                                                                      size: 20,
                                                                    ),
                                                                    const SizedBox(
                                                                        width:
                                                                            8.0),
                                                                    Text(
                                                                      'Select Profile Picture',
                                                                      style: Theme.of(
                                                                              context)
                                                                          .textTheme
                                                                          .caption!
                                                                          .copyWith(
                                                                              fontWeight: FontWeight.bold,
                                                                              fontSize: 16,
                                                                              fontFamily: 'Lato-Regular'),
                                                                      textAlign:
                                                                          TextAlign
                                                                              .start,
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                            MaterialButton(
                                                              onPressed: () {},
                                                              minWidth: double
                                                                  .infinity,
                                                              child: Align(
                                                                alignment: Alignment
                                                                    .centerLeft,
                                                                child: Row(
                                                                  children: [
                                                                    Icon(
                                                                      Iconsax
                                                                          .picture_frame,
                                                                      color: Theme.of(
                                                                              context)
                                                                          .textTheme
                                                                          .caption!
                                                                          .color,
                                                                      size: 20,
                                                                    ),
                                                                    const SizedBox(
                                                                        width:
                                                                            8.0),
                                                                    Text(
                                                                      'View Profile Picture',
                                                                      style: Theme.of(
                                                                              context)
                                                                          .textTheme
                                                                          .caption!
                                                                          .copyWith(
                                                                              fontWeight: FontWeight.bold,
                                                                              fontSize: 16,
                                                                              fontFamily: 'Lato-Regular'),
                                                                      textAlign:
                                                                          TextAlign
                                                                              .start,
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                          iconSize: 40.0,
                                          icon: const CircleAvatar(
                                            radius: 40,
                                            child: Icon(
                                              Icons.photo_camera_outlined,
                                              size: 20.0,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20.0),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: Text(
                                    'Name',
                                    style: Theme.of(context)
                                        .textTheme
                                        .caption!
                                        .copyWith(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                            fontFamily: 'Lato-Regular'),
                                  ),
                                ),
                                const SizedBox(height: 15.0),
                                TextFormField(
                                  controller: _nameController,
                                  enabled:
                                      SocialCubit.get(context).isNameVisible,
                                  onChanged: (value) {
                                    changed = true;
                                  },
                                  keyboardType: TextInputType.name,
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.person,
                                      color: Theme.of(context)
                                          .textTheme
                                          .caption!
                                          .color,
                                    ),
                                    labelStyle: Theme.of(context)
                                        .textTheme
                                        .caption!
                                        .copyWith(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                            fontFamily: 'Lato-Regular'),
                                  ),
                                  validator: (value) {
                                    if (value == '' || value!.isEmpty) {
                                      return 'Please enter a valid name';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 15.0),
                                Row(
                                  children: [
                                    Text('View Name'),
                                    Spacer(),
                                    Switch(
                                        value: SocialCubit.get(context)
                                            .isNameVisible!,
                                        activeColor: blueColor,
                                        onChanged: (value) {
                                          SocialCubit.get(context)
                                              .changeValues();
                                          if (!SocialCubit.get(context)
                                              .isNameVisible!) {
                                            _nameController.text =
                                                "Anonymous User";
                                          } else {
                                            _nameController.text = "";
                                          }
                                        })
                                  ],
                                )
                              ],
                            ),
                          ),
                          const SizedBox(height: 30.0),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: Text(
                                    'Phone',
                                    style: Theme.of(context)
                                        .textTheme
                                        .caption!
                                        .copyWith(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                            fontFamily: 'Lato-Regular'),
                                  ),
                                ),
                                const SizedBox(height: 15.0),
                                TextFormField(
                                  controller: _mobileController,
                                  onChanged: (value) {
                                    changed = true;
                                  },
                                  keyboardType: TextInputType.phone,
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.call,
                                      color: Theme.of(context)
                                          .textTheme
                                          .caption!
                                          .color,
                                    ),
                                    labelStyle: Theme.of(context)
                                        .textTheme
                                        .caption!
                                        .copyWith(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                            fontFamily: 'Lato-Regular'),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 30.0),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: Text(
                                    'Bio',
                                    style: Theme.of(context)
                                        .textTheme
                                        .caption!
                                        .copyWith(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                            fontFamily: 'Lato-Regular'),
                                  ),
                                ),
                                const SizedBox(height: 15.0),
                                TextFormField(
                                  controller: _bioController,
                                  onChanged: (value) {
                                    changed = true;
                                  },
                                  keyboardType: TextInputType.multiline,
                                  minLines: 1,
                                  maxLines: 7,
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.description_outlined,
                                      color: Theme.of(context)
                                          .textTheme
                                          .caption!
                                          .color,
                                    ),
                                    labelStyle: Theme.of(context)
                                        .textTheme
                                        .caption!
                                        .copyWith(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                            fontFamily: 'Lato-Regular'),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
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

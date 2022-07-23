import 'package:facebook/layout/cubit/cubit.dart';
import 'package:facebook/models/user_model.dart';
import 'package:facebook/modules/chat/chat_screen.dart';
import 'package:facebook/modules/search/search_screen.dart';
import 'package:facebook/modules/settings/settings_screen.dart';
import 'package:facebook/shared/network/local/cache_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';

import '../modules/new_post/new_post_screen.dart';
import '../shared/functions.dart';
import 'cubit/states.dart';

class SocialLayout extends StatelessWidget {
  SocialLayout({Key? key}) : super(key: key);
  final _pageViewController = PageController();
  UserModel? model;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        CacheHelper.init();
        var isDarkMode = CacheHelper.getData(key: "isDark") ?? true;
        print(isDarkMode.toString());
        var cubit = SocialCubit.get(context);
        return Scaffold(
          extendBody: true,
          appBar: AppBar(
            title: Text(cubit.titles[cubit.currentIndex]),
            actions: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.shade600.withOpacity(0.5),
                        shape: BoxShape.circle,
                      ),
                      height: 40,
                      width: 40,
                      child: IconButton(
                        onPressed: () {
                          navigateTo(const SearchScreen(), context);
                        },
                        icon: const Icon(
                          Iconsax.search_normal,
                          size: 22.0,
                        ),
                      ),
                    ),
                    SizedBox(width: 8.0),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.shade600.withOpacity(0.5),
                        shape: BoxShape.circle,
                      ),
                      height: 40,
                      width: 40,
                      child: IconButton(
                        onPressed: () {
                          navigateTo(const SettingsScreen(), context);
                        },
                        icon: const Icon(
                          Iconsax.setting,
                          size: 22.0,
                        ),
                      ),
                    ),
                    SizedBox(width: 8.0),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.shade600.withOpacity(0.5),
                        shape: BoxShape.circle,
                      ),
                      height: 40,
                      width: 40,
                      child: IconButton(
                        onPressed: () {
                          SocialCubit.get(context).getUsers();
                          navigateTo(const ChatScreen(), context);
                        },
                        icon: const Icon(
                          Icons.chat,
                          size: 22.0,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          body: PageView(
            physics: const BouncingScrollPhysics(),
            controller: _pageViewController,
            children: cubit.screens,
            onPageChanged: (index) {
              cubit.changeIndex(index);
            },
          ),
          bottomNavigationBar: BottomAppBar(
            shape: const CircularNotchedRectangle(),
            color: Theme.of(context).scaffoldBackgroundColor.withAlpha(255),
            elevation: 0,
            notchMargin: 6,
            child: BottomNavigationBar(
              backgroundColor:
                  Theme.of(context).scaffoldBackgroundColor.withAlpha(0),
              currentIndex: cubit.currentIndex,
              onTap: (index) {
                _pageViewController.animateToPage(index,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.fastLinearToSlowEaseIn);
                cubit.changeIndex(index);
              },
              elevation: 0,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Iconsax.home_11),
                  label: 'News Feed',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Iconsax.notification5),
                  label: 'Notifications',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Iconsax.people5),
                  label: 'Users',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Iconsax.profile_2user5),
                  label: 'Profile',
                ),
              ],
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              navigateTo(NewPostScreen(), context);
            },
            backgroundColor: Colors.blue,
            child: const Icon(Iconsax.add),
          ),
        );
      },
    );
  }
}
//
// currentIndex: cubit.currentIndex,
// onTap: (index) {
// if (index == 2) {
// Navigator.push(
// context,
// MaterialPageRoute(
// builder: (context) => const NewPostScreen(),
// ),
// );
// } else {
// _pageViewController.animateToPage(index,
// duration: const Duration(milliseconds: 500),
// curve: Curves.fastLinearToSlowEaseIn);
// cubit.changeIndex(index);
// }
// },
// items: const [
// BottomNavigationBarItem(
// icon: Icon(Iconsax.home_11),
// label: 'News Feed',
// ),
// BottomNavigationBarItem(
// icon: Icon(Iconsax.notification5),
// label: 'Notifications',
// ),
// BottomNavigationBarItem(
// icon: Icon(Iconsax.add),
// label: 'New Post',
// ),
// BottomNavigationBarItem(
// icon: Icon(Iconsax.people5),
// label: 'Users',
// ),
// BottomNavigationBarItem(
// icon: Icon(Iconsax.profile_2user5),
// label: 'Profile',
// ),
// ],

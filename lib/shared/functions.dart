import 'package:flutter/material.dart';

//import 'package:facebook/modules/login/login_screen.dart';

import 'constants.dart';
import 'network/local/cache_helper.dart';

void navigateTo(page, context) {
  Navigator.of(context).push(MaterialPageRoute(builder: (context) => page));
}

void popPage(context) {
  uId = null;
  CacheHelper.saveData(key: 'uId', value: null);
  Navigator.of(context).pop();
}

void navigateAndReplaceTo(page, context) {
  Navigator.of(context)
      .pushReplacement(MaterialPageRoute(builder: (context) => page));
}

void submit(context) {
  CacheHelper.saveData(
    key: 'onBoarding',
    value: true,
  ).then((value) {
    if (value) {
      //navigateAndReplaceTo(LoginScreen(), context);
    }
  });
}

void signOut(context) {
  CacheHelper.removeData(key: 'token').then((value) {
    // navigateAndReplaceTo(LoginScreen(), context);
  });
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facebook/modules/login/cubit/states.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/user_model.dart';
import '../../../shared/constants.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);

  void userLogin({
    required String email,
    required String password,
  }) {
    emit(LoginLoadingState());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
      getUserData();
      emit(LoginSuccessState(value.user!.uid));
      uId = value.user!.uid.toString();
    }).catchError((error) {
      emit(LoginErrorState(error.toString()));
    });
    UserModel model = UserModel(
      email: email,
      password: password,
    );
  }

  void getUserData() {
    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      UserModel model = UserModel.fromJson(value.data()!);
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;
  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_off_outlined : Icons.visibility_outlined;
    emit(ChangePasswordVisibilityState());
  }
}

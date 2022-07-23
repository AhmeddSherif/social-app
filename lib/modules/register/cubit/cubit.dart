import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facebook/modules/register/cubit/states.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/user_model.dart';
import '../../../shared/constants.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;

  void userRegister() {
    emit(RegisterLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: emailController.text,
      password: passwordController.text,
    )
        .then((value) {
      userCreate(
        email: emailController.text,
        name: nameController.text,
        mobile: mobileController.text,
        uId: value.user!.uid.toString(),
        password: passwordController.text,
        address: addressController.text,
        userVerified: false,
      );
      uId = value.user!.uid.toString();
    });
  }

  void userCreate({
    required String email,
    required String name,
    required String mobile,
    required String uId,
    required String password,
    required String address,
    required bool userVerified,
  }) {
    UserModel model = UserModel(
      email: email,
      name: name,
      mobile: mobile,
      uId: uId,
      isEmailVerified: false,
      bio: 'Write your bio here',
      password: password,
      cover: 'https://static.xx.fbcdn.net/rsrc.php/v3/y4/r/DGeyGUHgoHO.png',
      image:
          "https://user-images.githubusercontent.com/11250/39013954-f5091c3a-43e6-11e8-9cac-37cf8e8c8e4e.jpg",
      address: "",
      userVerified: false,
    );

    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(
          model.toMap(),
        )
        .then((value) {
      uId = uId;
      emit(CreateUserSuccessState(uId));
    });
  }
}

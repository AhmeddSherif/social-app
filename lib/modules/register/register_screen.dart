import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:facebook/layout/social_layout.dart';
import 'package:facebook/modules/login/login_screen.dart';
import 'package:facebook/shared/functions.dart';
import 'package:facebook/shared/network/local/cache_helper.dart';
import 'package:facebook/shared/styles/colors.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/custom_widgets/TextFormFieldWidget.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterStates>(
        listener: (context, state) {
          if (state is CreateUserSuccessState) {
            CacheHelper.saveData(
              key: "uId",
              value: state.uId,
            );
            navigateAndReplaceTo(SocialLayout(), context);
          }
        },
        builder: (context, state) {
          return GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: Scaffold(
              appBar: AppBar(),
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'REGISTER',
                          style:
                              Theme.of(context).textTheme.headline5!.copyWith(
                                    fontSize: 40,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: 'Lato-Bold',
                                    fontStyle: FontStyle.normal,
                                  ),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          'Explore a new world.',
                          style:
                              Theme.of(context).textTheme.bodyText1?.copyWith(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w800,
                                    fontFamily: 'Lato-Regular',
                                  ),
                        ),
                        const SizedBox(
                          height: 40.0,
                        ),
                        TextFormFieldWidget(
                          controller: RegisterCubit.get(context).nameController,
                          type: TextInputType.name,
                          obsecureText: false,
                          validation: (String? value) {
                            if (value!.isEmpty) {
                              return 'Please enter a Name';
                            }
                            return null;
                          },
                          label: 'Full Name',
                          labelFontSize: 16,
                          labelFontFamily: 'Lato-Regular',
                          focusBorderSide: const BorderSide(
                            color: Colors.blueAccent,
                            width: 2,
                          ),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(15),
                          ),
                          prefixIcon: const Icon(
                            Icons.person,
                          ),
                          borderSide: const BorderSide(
                            color: Colors.blueAccent,
                            width: 2,
                          ),
                          focusBorderRadius: const BorderRadius.all(
                            Radius.circular(15),
                          ),
                        ),
                        space(),
                        TextFormFieldWidget(
                          controller:
                              RegisterCubit.get(context).mobileController,
                          type: TextInputType.phone,
                          obsecureText: false,
                          validation: (String? value) {
                            if (value!.isEmpty) {
                              return 'Please enter a Mobile Number';
                            }
                            return null;
                          },
                          label: 'Mobile Number',
                          labelFontSize: 16,
                          labelFontFamily: 'Lato-Regular',
                          focusBorderSide: const BorderSide(
                            color: Colors.blueAccent,
                            width: 2,
                          ),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(15),
                          ),
                          prefixIcon: const Icon(
                            Icons.phone,
                          ),
                          borderSide: const BorderSide(
                            color: Colors.blueAccent,
                            width: 2,
                          ),
                          focusBorderRadius: const BorderRadius.all(
                            Radius.circular(15),
                          ),
                        ),
                        space(),
                        TextFormFieldWidget(
                          controller:
                              RegisterCubit.get(context).addressController,
                          type: TextInputType.streetAddress,
                          obsecureText: false,
                          validation: (String? value) {
                            if (value!.isEmpty) {
                              return 'Please enter an Address';
                            }
                            return null;
                          },
                          label: 'Address',
                          labelFontSize: 16,
                          labelFontFamily: 'Lato-Regular',
                          focusBorderSide: const BorderSide(
                            color: Colors.blueAccent,
                            width: 2,
                          ),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(15),
                          ),
                          prefixIcon: const Icon(
                            Icons.location_on,
                          ),
                          borderSide: const BorderSide(
                            color: Colors.blueAccent,
                            width: 2,
                          ),
                          focusBorderRadius: const BorderRadius.all(
                            Radius.circular(15),
                          ),
                        ),
                        space(),
                        TextFormFieldWidget(
                          controller:
                              RegisterCubit.get(context).emailController,
                          type: TextInputType.emailAddress,
                          obsecureText: false,
                          validation: (String? value) {
                            if (value!.isEmpty) {
                              return 'Please enter an Email';
                            }
                            if (!RegExp(
                                    "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                                .hasMatch(value)) {
                              return 'Please enter a valid Email';
                            }
                            return null;
                          },
                          label: 'Email Address',
                          labelFontSize: 16,
                          labelFontFamily: 'Lato-Regular',
                          focusBorderSide: const BorderSide(
                            color: Colors.blueAccent,
                            width: 2,
                          ),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(15),
                          ),
                          prefixIcon: const Icon(
                            Icons.email,
                          ),
                          borderSide: const BorderSide(
                            color: Colors.blueAccent,
                            width: 2,
                          ),
                          focusBorderRadius: const BorderRadius.all(
                            Radius.circular(15),
                          ),
                        ),
                        space(),
                        TextFormFieldWidget(
                          controller:
                              RegisterCubit.get(context).passwordController,
                          type: TextInputType.visiblePassword,
                          obsecureText: false,
                          validation: (String? value) {
                            if (value!.isEmpty) {
                              return 'Please enter a Password';
                            }
                            if (value.length < 6) {
                              return 'Password must be at least 6 characters';
                            }
                            return null;
                          },
                          label: 'Password',
                          labelFontSize: 16,
                          labelFontFamily: 'Lato-Regular',
                          focusBorderSide: const BorderSide(
                            color: Colors.blueAccent,
                            width: 2,
                          ),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(15),
                          ),
                          prefixIcon: const Icon(
                            Icons.lock,
                          ),
                          borderSide: const BorderSide(
                            color: Colors.blueAccent,
                            width: 2,
                          ),
                          focusBorderRadius: const BorderRadius.all(
                            Radius.circular(15),
                          ),
                        ),
                        const SizedBox(height: 30),
                        ConditionalBuilder(
                          condition: state is! RegisterLoadingState,
                          builder: (context) => MaterialButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                RegisterCubit.get(context).userRegister();
                                FocusScope.of(context).unfocus();
                              }
                            },
                            color: Colors.blueAccent,
                            minWidth: double.infinity,
                            height: 50,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Text(
                              'REGISTER',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontFamily: 'Lato-Bold',
                              ),
                            ),
                          ),
                          fallback: (context) =>
                              const Center(child: CircularProgressIndicator()),
                        ),
                        const SizedBox(height: 16),
                        Center(
                          child: RichText(
                              text: TextSpan(
                            text: "Already have an Account? ",
                            style:
                                Theme.of(context).textTheme.bodyText1?.copyWith(
                                      color: Colors.grey,
                                      fontFamily: 'Lato-Regular',
                                    ),
                            children: [
                              TextSpan(
                                text: 'Login',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1
                                    ?.copyWith(
                                      color: blueColor,
                                    ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    navigateAndReplaceTo(
                                        LoginScreen(), context);
                                  },
                              ),
                            ],
                          )),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget space() {
    return const SizedBox(
      height: 16.0,
    );
  }
}

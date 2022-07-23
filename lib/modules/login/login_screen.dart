import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:facebook/layout/social_layout.dart';
import 'package:facebook/modules/register/register_screen.dart';
import 'package:facebook/shared/network/local/cache_helper.dart';
import 'package:facebook/shared/styles/colors.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/custom_widgets/TextFormFieldWidget.dart';
import '../../shared/functions.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    return BlocProvider(
      create: (BuildContext context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
          if(state is LoginSuccessState)
            {
              CacheHelper.saveData(
                  key: "uId",
                  value: state.uId,
              ).then((value) {
                navigateAndReplaceTo(SocialLayout(), context);
              });
            }
        },
        builder: (context, state) => GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Scaffold(
            appBar: AppBar(),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'LOGIN',
                        style: Theme.of(context).textTheme.headline5!.copyWith(
                              fontSize: 40,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'Lato-Bold',
                              fontStyle: FontStyle.normal,
                            ),
                      ),
                      Text(
                        'Explore a new world.',
                        style: Theme.of(context).textTheme.bodyText1?.copyWith(
                              color: Colors.grey,
                              fontWeight: FontWeight.w800,
                              fontFamily: 'Lato-Regular',
                            ),
                      ),
                      const SizedBox(height: 30),
                      TextFormFieldWidget(
                        controller: emailController,
                        type: TextInputType.emailAddress,
                        obsecureText: false,
                        validation: (String? value) {
                          if (value!.isEmpty) {
                            return 'Please enter an Email';
                          }
                          if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                              .hasMatch(value)) {
                            return 'Please enter a valid Email';
                          }
                          return null;
                        },
                        label: 'Email Address',
                        focusBorderSide: BorderSide(
                          color: blueColor,
                          width: 2,
                        ),
                        prefixIcon: const Icon(
                          Icons.email,
                        ),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(12.0),
                        ),
                        borderSide: BorderSide(
                          color: blueColor,
                          width: 2,
                        ),
                        focusBorderRadius: const BorderRadius.all(
                          Radius.circular(12),
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextFormFieldWidget(
                        controller: passwordController,
                        type: TextInputType.visiblePassword,
                        obsecureText: LoginCubit.get(context).isPassword,
                        validation: (String? value) {
                          if (value!.length < 6) {
                            return 'Password must be at least 6 characters';
                          }
                          return null;
                        },
                        label: 'Password',
                        focusBorderSide: BorderSide(
                          color: blueColor,
                          width: 2,
                        ),
                        prefixIcon: const Icon(
                          Icons.lock,
                        ),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(12.0),
                        ),
                        suffixIcon: LoginCubit.get(context).suffix,
                        onSuffixPressed: () {
                          LoginCubit.get(context).changePasswordVisibility();
                        },
                        borderSide: BorderSide(
                          color: blueColor,
                          width: 2,
                        ),
                        focusBorderRadius: const BorderRadius.all(
                          Radius.circular(12),
                        ),
                      ),
                      const SizedBox(height: 30),
                      ConditionalBuilder(
                        condition: state is! LoginLoadingState,
                        builder: (context) => MaterialButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              LoginCubit.get(context).userLogin(
                                email: emailController.text,
                                password: passwordController.text,
                              );
                              FocusScope.of(context).unfocus();
                            }
                          },
                          color: blueColor,
                          minWidth: double.infinity,
                          height: 50,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Text(
                            'LOGIN',
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
                          text: "Don't have an account? ",
                          style: Theme.of(context).textTheme.bodyText1?.copyWith(
                                color: Colors.grey,
                                fontFamily: 'Lato-Regular',
                              ),
                          children: [
                            TextSpan(
                              text: 'Sign up',
                              style:
                                  Theme.of(context).textTheme.bodyText1?.copyWith(
                                        color: blueColor,
                                      ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  FocusScope.of(context).unfocus();
                                  navigateAndReplaceTo(RegisterScreen(), context);
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
        ),
      ),
    );
  }
}

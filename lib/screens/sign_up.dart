import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oasis_uz_mobile/bloc/authentication/authentication_cubit.dart';
import 'package:oasis_uz_mobile/bloc/authentication/authentication_state.dart';
import 'package:oasis_uz_mobile/constants/app_color.dart';
import 'package:oasis_uz_mobile/repositories/modules/user.dart';
import 'package:oasis_uz_mobile/screens/sign_in.dart';
import 'package:oasis_uz_mobile/widgets/custom_snackbar.dart';
import 'package:oasis_uz_mobile/widgets/custom_text.dart';
import 'package:oasis_uz_mobile/widgets/custom_textfield.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  var emailController = TextEditingController();
  var nameController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var obscureText = true;
    final AuthenticationCubit authenticationCubit =
        BlocProvider.of<AuthenticationCubit>(context);

    return Scaffold(
      backgroundColor: Colors.brown[50],
      body: BlocListener<AuthenticationCubit, AuthenticationState>(
        listener: (context, state) {
          if (state is RegistrationSuccess) {
            CustomSnackBar(backgroundColor: Colors.green[800]!)
                .showError(context, 'User reigstered successfully!');
            sleep(const Duration(seconds: 3));
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const SignInScreen()),
            );
          } else if (state is RegistrationFailure) {
            CustomSnackBar().showError(context, state.error);
          }
        },
        child: SingleChildScrollView(
          child: SafeArea(
            child: Center(
              child: FractionallySizedBox(
                widthFactor: 0.8,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(
                      height: 150,
                    ),
                    const Center(
                      child: CustomText(
                        text: 'Sign Up',
                        size: 22,
                        weight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    const Center(
                      child: CustomText(
                        text: 'Create an account',
                        size: 20,
                      ),
                    ),
                    const SizedBox(
                      height: 60,
                    ),
                    CustomTextField(
                      labelText: 'Full Name',
                      controller: nameController,
                      leadingButton: const Icon(Icons.person),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    CustomTextField(
                      labelText: 'Email',
                      controller: emailController,
                      leadingButton: const Icon(Icons.mail),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    CustomTextField(
                      labelText: 'Password',
                      controller: passwordController,
                      obscureText: obscureText,
                      leadingButton: const Icon(Icons.lock),
                      trailingButton: const Icon(Icons.remove_red_eye),
                      onTrailingButtonPressed: () {},
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    InkWell(
                      onTap: () {
                        FocusScope.of(context).unfocus();

                        if (emailController.text.isNotEmpty &&
                            passwordController.text.isNotEmpty) {
                          authenticationCubit.registerUser(
                            User(
                              null,
                              nameController.text,
                              passwordController.text,
                              emailController.text,
                            ),
                          );
                        }
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.4,
                        decoration: BoxDecoration(
                          color: mainColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.all(16),
                        child: const Center(
                          child: CustomText(
                            text: 'Sign Up',
                            size: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    InkWell(
                      onTap: () {},
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.4,
                        decoration: BoxDecoration(
                          color: Colors.deepOrangeAccent,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.all(16),
                        child: const Center(
                          child: CustomText(
                            text: 'Sign Up with Google',
                            size: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const CustomText(
                          text: 'Already have an account?',
                          weight: FontWeight.w500,
                          size: 12,
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => const SignInScreen()),
                            );
                          },
                          child: CustomText(
                            text: 'Sign In',
                            color: mainColor,
                            size: 18,
                            weight: FontWeight.w800,
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

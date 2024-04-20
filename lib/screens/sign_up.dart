import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oasis_uz_mobile/bloc/authentication/authentication_cubit.dart';
import 'package:oasis_uz_mobile/bloc/authentication/authentication_state.dart';
import 'package:oasis_uz_mobile/constants/app_color.dart';
import 'package:oasis_uz_mobile/repositories/models/user.dart';
import 'package:oasis_uz_mobile/screens/sign_in.dart';
import 'package:oasis_uz_mobile/widgets/custom_snackbar.dart';
import 'package:oasis_uz_mobile/widgets/custom_text.dart';
import 'package:oasis_uz_mobile/widgets/custom_textfield.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  var emailController = TextEditingController();
  var nameController = TextEditingController();
  var passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

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
              MaterialPageRoute(
                  builder: (context) => const SignInScreen(
                        initialPageIndex: 0,
                      )),
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
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(
                        height: 100,
                      ),
                      Center(
                        child: CustomText(
                          text: AppLocalizations.of(context)!.signUp,
                          size: 22,
                          weight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Center(
                        child: CustomText(
                          text: AppLocalizations.of(context)!.createAccount,
                          size: 20,
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      CustomTextField(
                        labelText: AppLocalizations.of(context)!.fullName,
                        controller: nameController,
                        leadingButton: const Icon(Icons.person),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return AppLocalizations.of(context)!
                                .validateFullName;
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomTextField(
                        labelText: AppLocalizations.of(context)!.phone,
                        controller: passwordController,
                        isPhone: true,
                        leadingButton: const Icon(Icons.phone),
                        onTrailingButtonPressed: () {},
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return AppLocalizations.of(context)!.validatePhone;
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomTextField(
                        labelText: AppLocalizations.of(context)!.email,
                        controller: emailController,
                        leadingButton: const Icon(Icons.mail),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return AppLocalizations.of(context)!.validateEmail;
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomTextField(
                        labelText: AppLocalizations.of(context)!.password,
                        controller: passwordController,
                        obscureText: obscureText,
                        leadingButton: const Icon(Icons.lock),
                        trailingButton: const Icon(Icons.remove_red_eye),
                        onTrailingButtonPressed: () {},
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return AppLocalizations.of(context)!
                                .validatePassword;
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      InkWell(
                        onTap: () {
                          FocusScope.of(context).unfocus();
                          if (_formKey.currentState?.validate() == true) {
                            if (emailController.text.isNotEmpty &&
                                passwordController.text.isNotEmpty) {
                              authenticationCubit.registerUser(
                                User(
                                    null,
                                    nameController.text,
                                    passwordController.text,
                                    emailController.text,
                                    null),
                              );
                            }
                          }
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.4,
                          decoration: BoxDecoration(
                            color: mainColor,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.all(16),
                          child: Center(
                            child: CustomText(
                              text: AppLocalizations.of(context)!.signUp,
                              size: 20,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      InkWell(
                        onTap: () {
                          authenticationCubit.signInWithGoogle();
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.4,
                          decoration: BoxDecoration(
                            color: Colors.deepOrangeAccent,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.all(16),
                          child: Center(
                            child: CustomText(
                              text: AppLocalizations.of(context)!.googleAuth,
                              size: 20,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomText(
                            text: AppLocalizations.of(context)!.noProfile,
                            weight: FontWeight.w500,
                            size: 12,
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => const SignInScreen(
                                          initialPageIndex: 0,
                                        )),
                              );
                            },
                            child: CustomText(
                              text: AppLocalizations.of(context)!.logIn,
                              color: mainColor,
                              size: 18,
                              weight: FontWeight.w800,
                            ),
                          ),
                        ],
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

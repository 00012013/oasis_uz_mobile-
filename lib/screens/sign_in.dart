import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oasis_uz_mobile/app/app_main.dart';
import 'package:oasis_uz_mobile/bloc/authentication/authentication_cubit.dart';
import 'package:oasis_uz_mobile/bloc/authentication/authentication_state.dart';
import 'package:oasis_uz_mobile/constants/app_color.dart';
import 'package:oasis_uz_mobile/screens/sign_up.dart';
import 'package:oasis_uz_mobile/widgets/custom_snackbar.dart';
import 'package:oasis_uz_mobile/widgets/custom_text.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:oasis_uz_mobile/widgets/custom_textfield.dart';

class SignInScreen extends StatefulWidget {
  final int initialPageIndex;

  const SignInScreen({super.key, required this.initialPageIndex});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var initialPageIndex = widget.initialPageIndex;
    var obscureText = true;
    final AuthenticationCubit authenticationCubit =
        BlocProvider.of<AuthenticationCubit>(context);

    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
              builder: (context) => const AppMain(initialPageIndex: 0)),
        );
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        body: BlocListener<AuthenticationCubit, AuthenticationState?>(
          listener: (context, state) {
            if (state is AuthenticationFailure) {
              if (state.error.isNotEmpty) {
                CustomSnackBar().showError(
                  context,
                  state.error,
                );
              }
              authenticationCubit.emitInitial();
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                    builder: (context) =>
                        SignInScreen(initialPageIndex: initialPageIndex)),
              );
            } else if (state is AuthenticationSuccess) {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                    builder: (context) =>
                        AppMain(initialPageIndex: initialPageIndex)),
              );
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
                          height: 150,
                        ),
                        Center(
                          child: CustomText(
                            text: AppLocalizations.of(context)!.login,
                            size: 22,
                            weight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        Center(
                          child: CustomText(
                            text: AppLocalizations.of(context)!.loginSubText,
                            size: 20,
                          ),
                        ),
                        const SizedBox(
                          height: 60,
                        ),
                        CustomTextField(
                          labelText: AppLocalizations.of(context)!.email,
                          controller: emailController,
                          leadingButton: const Icon(Icons.mail),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return AppLocalizations.of(context)!
                                  .validateEmail;
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        CustomTextField(
                          labelText: AppLocalizations.of(context)!.password,
                          controller: passwordController,
                          obscureText: obscureText,
                          leadingButton: const Icon(Icons.lock),
                          trailingButton: const Icon(Icons.remove_red_eye),
                          onTrailingButtonPressed: () {
                            setState(() {
                              obscureText = !obscureText;
                            });
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return AppLocalizations.of(context)!
                                  .validatePassword;
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        InkWell(
                          onTap: () {
                            FocusScope.of(context).unfocus();
                            if (_formKey.currentState?.validate() == true) {
                              if (emailController.text.isNotEmpty &&
                                  passwordController.text.isNotEmpty) {
                                authenticationCubit.authenticateUser(
                                    emailController.text,
                                    passwordController.text);
                              }
                            }
                          },
                          child: Container(
                            width: MediaQuery.sizeOf(context).width * 0.4,
                            decoration: BoxDecoration(
                              color: mainColor,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: const EdgeInsets.all(16),
                            child: Center(
                              child: CustomText(
                                text: AppLocalizations.of(context)!.logIn,
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
                          onTap: () {
                            authenticationCubit.signInWithGoogle();
                          },
                          child: Container(
                            width: MediaQuery.sizeOf(context).width * 0.4,
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
                          height: 25,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomText(
                              text: AppLocalizations.of(context)!.noProfile,
                              weight: FontWeight.w500,
                              size: 12,
                            ),
                            if (AppLocalizations.of(context)!.signUp.length <
                                10)
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const SignUpScreen()),
                                  );
                                },
                                child: CustomText(
                                  text: AppLocalizations.of(context)!.signUp,
                                  color: mainColor,
                                  size: 18,
                                  weight: FontWeight.w800,
                                ),
                              )
                          ],
                        ),
                        if (AppLocalizations.of(context)!.signUp.length > 10)
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => const SignUpScreen()),
                              );
                            },
                            child: CustomText(
                              text: AppLocalizations.of(context)!.signUp,
                              color: mainColor,
                              size: 18,
                              weight: FontWeight.w800,
                            ),
                          )
                      ],
                    ),
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

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oasis_uz_mobile/app/app_main.dart';
import 'package:oasis_uz_mobile/bloc/authentication/authentication_cubit.dart';
import 'package:oasis_uz_mobile/constants/app_color.dart';
import 'package:oasis_uz_mobile/repositories/modules/user.dart';
import 'package:oasis_uz_mobile/widgets/custom_text.dart';
import 'package:oasis_uz_mobile/widgets/custom_textfield.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) {
    var obscureText = true;
    final AuthenticationCubit authenticationCubit =
        BlocProvider.of<AuthenticationCubit>(context);

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.brown[50],
      ),
    );
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    return BlocListener<AuthenticationCubit, User?>(
      listener: (context, state) {
        if (state != null) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const AppMain()),
          );
        }
      },
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        body: SingleChildScrollView(
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
                      text: 'Login',
                      size: 22,
                      weight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  const Center(
                    child: CustomText(
                      text: 'Hello, welcome back',
                      size: 20,
                    ),
                  ),
                  const SizedBox(
                    height: 60,
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
                    onTrailingButtonPressed: () {
                      setState(() {
                        obscureText = !obscureText;
                      });
                    },
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  InkWell(
                    onTap: () {
                      if (emailController.text.isNotEmpty &&
                          passwordController.text.isNotEmpty) {
                        authenticationCubit.authenticateUser(
                            emailController.text, passwordController.text);
                      }
                    },
                    child: Container(
                      width: MediaQuery.sizeOf(context).width * 0.4,
                      decoration: BoxDecoration(
                        color: mainColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.all(16),
                      child: const Center(
                        child: CustomText(
                          text: 'Log in',
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
                      width: MediaQuery.sizeOf(context).width * 0.4,
                      decoration: BoxDecoration(
                        color: Colors.deepOrangeAccent,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.all(16),
                      child: const Center(
                        child: CustomText(
                          text: 'Login with Google',
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
                        text: 'Do not have profile yet?',
                        weight: FontWeight.w500,
                      ),
                      TextButton(
                        onPressed: () {},
                        child: CustomText(
                          text: 'Sign up',
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
        )),
      ),
    );
  }
}

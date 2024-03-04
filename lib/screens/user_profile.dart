import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:oasis_uz_mobile/app/material_app.dart';
import 'package:oasis_uz_mobile/bloc/authentication/authentication_cubit.dart';
import 'package:oasis_uz_mobile/constants/app_color.dart';
import 'package:oasis_uz_mobile/repositories/modules/user.dart';
import 'package:oasis_uz_mobile/screens/feedback_screen.dart';
import 'package:oasis_uz_mobile/screens/language_screen.dart';
import 'package:oasis_uz_mobile/screens/sign_in.dart';
import 'package:oasis_uz_mobile/widgets/custom_text.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final authenticationCubit = context.read<AuthenticationCubit>();
    return SafeArea(
      child: SingleChildScrollView(
        child: BlocBuilder<AuthenticationCubit, User?>(
          builder: (context, state) {
            return Column(
              children: [
                const SizedBox(height: 10),
                Container(
                  height: 80,
                  width: 80,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.grey[400]),
                  child: const Icon(
                    Icons.person_2_outlined,
                    size: 40,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 10),
                if (state != null)
                  Column(
                    children: [
                      CustomText(
                        text: 'Welcome, ${state.fullName}!',
                        size: 22,
                        weight: FontWeight.bold,
                      ),
                    ],
                  ),
                if (state == null)
                  Column(
                    children: [
                      const CustomText(
                        text: 'Welcome to Oasis Uz!',
                        size: 22,
                        weight: FontWeight.bold,
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: const CustomText(
                          text:
                              "Sign in to send and receive messages, post new ads, and review your favorite ads. Like your profile so far? Create a profile in minutes.",
                          maxLines: 5,
                          size: 16,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 20),
                      InkWell(
                        onTap: () {
                          final state = authenticationCubit.state;
                          if (state == null) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SignInScreen()),
                            );
                          } else {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => const MyApp()),
                            );
                          }
                        },
                        child: Container(
                          width: MediaQuery.sizeOf(context).width * 0.8,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: mainColor,
                          ),
                          padding: const EdgeInsets.all(16),
                          child: const CustomText(
                            text: 'Sign in or Sign up',
                            size: 20,
                            textAlign: TextAlign.center,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                const SizedBox(height: 20),
                Center(
                  child: FractionallySizedBox(
                    widthFactor: 0.9,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                            text: AppLocalizations.of(context)!.settings,
                            color: Colors.grey),
                        ListTile(
                          title: CustomText(
                              text:
                                  AppLocalizations.of(context)!.changeLanguage),
                          leading: const Icon(Icons.language_outlined),
                          trailing: const Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 20,
                          ),
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => const LanguageScreen()),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                const Divider(thickness: 1.5),
                Center(
                  child: FractionallySizedBox(
                    widthFactor: 0.9,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                            text: AppLocalizations.of(context)!.other,
                            color: Colors.grey),
                        ListTile(
                          title: CustomText(
                              text: AppLocalizations.of(context)!.feedback),
                          trailing: const Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 20,
                          ),
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const FeedbackScreen()));
                          },
                        ),
                        ListTile(
                          title: CustomText(
                              text: AppLocalizations.of(context)!.aboutProgram),
                          trailing: const Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 20,
                          ),
                          onTap: () {},
                        ),
                      ],
                    ),
                  ),
                ),
                const Divider(thickness: 1.5),
                const SizedBox(height: 10),
                CustomText(
                    text: AppLocalizations.of(context)!.follow,
                    weight: FontWeight.w500),
                const SizedBox(height: 10),
                const CustomText(
                    text: 'Contacts: +998(94)3900080', weight: FontWeight.w500),
              ],
            );
          },
        ),
      ),
    );
  }
}


 // Center(
            //   child: FractionallySizedBox(
            //     widthFactor: 0.9,
            //     child: Column(
            //       crossAxisAlignment: CrossAxisAlignment.start,
            //       children: [
            //         CustomText(
            //             text: AppLocalizations.of(context)!.myProfilte,
            //             color: Colors.grey),
            //         ListTile(
            //           title: CustomText(
            //               text: AppLocalizations.of(context)!.myProfilte),
            //           leading: const Icon(Icons.person_2_outlined),
            //           trailing: const Icon(
            //             Icons.arrow_forward_ios_rounded,
            //             size: 20,
            //           ),
            //           onTap: () {
            //             final state = authenticationCubit.state;
            //             if (state == AuthenticationStatus.unauthenticated) {
            //               Navigator.push(
            //                 context,
            //                 MaterialPageRoute(
            //                     builder: (context) => const SignInScreen()),
            //               );
            //             } else {
            //               Navigator.of(context).pushReplacement(
            //                 MaterialPageRoute(
            //                     builder: (context) => const MyApp()),
            //               );
            //             }
            //           },
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            // const Divider(thickness: 1.5),

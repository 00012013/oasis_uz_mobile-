import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:oasis_uz_mobile/app/app_main.dart';
import 'package:oasis_uz_mobile/bloc/authentication/authentication_cubit.dart';
import 'package:oasis_uz_mobile/bloc/authentication/authentication_state.dart';
import 'package:oasis_uz_mobile/bloc/userCottages/user_cottages_cubit.dart';
import 'package:oasis_uz_mobile/constants/app_color.dart';
import 'package:oasis_uz_mobile/repositories/enums/auth_enum.dart';
import 'package:oasis_uz_mobile/screens/approve_cottages.dart';
import 'package:oasis_uz_mobile/screens/feedback_screen.dart';
import 'package:oasis_uz_mobile/screens/language_screen.dart';
import 'package:oasis_uz_mobile/screens/my_add_screen.dart';
import 'package:oasis_uz_mobile/screens/sign_in.dart';
import 'package:oasis_uz_mobile/widgets/custom_text.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final authenticationCubit = context.read<AuthenticationCubit>();
    return SafeArea(
      child: SingleChildScrollView(
        child: BlocBuilder<AuthenticationCubit, AuthenticationState?>(
          builder: (context, state) {
            return Column(
              children: [
                const SizedBox(height: 10),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: MediaQuery.sizeOf(context).width * 0.4,
                    ),
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
                    SizedBox(
                      width: MediaQuery.sizeOf(context).width * 0.27,
                    ),
                    if (state is AuthenticationSuccess)
                      IconButton(
                        icon: const Icon(Icons.logout_rounded),
                        onPressed: () {
                          authenticationCubit.logout();
                        },
                      ),
                  ],
                ),
                const SizedBox(height: 10),
                if (state is AuthenticationSuccess)
                  Column(
                    children: [
                      CustomText(
                        text:
                            '${AppLocalizations.of(context)!.welcome}, ${state.user!.fullName}!',
                        size: 22,
                        weight: FontWeight.bold,
                      ),
                    ],
                  ),
                if (state is! AuthenticationSuccess)
                  Column(
                    children: [
                      CustomText(
                        text: AppLocalizations.of(context)!.welcomeToOasisUz,
                        size: 22,
                        weight: FontWeight.bold,
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.95,
                        child: CustomText(
                          text: AppLocalizations.of(context)!.singUpSubText,
                          maxLines: 5,
                          size: 16,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 20),
                      InkWell(
                        onTap: () {
                          final state = authenticationCubit.state;
                          if (state is! AuthenticationSuccess) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SignInScreen(
                                        initialPageIndex: 4,
                                      )),
                            );
                          } else {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const AppMain(initialPageIndex: 4)),
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
                          child: CustomText(
                            text: AppLocalizations.of(context)!.signInSignUp,
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
                    widthFactor: 0.95,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                            text: AppLocalizations.of(context)!.settings,
                            color: Colors.grey),
                        if (AuthenticationCubit.currentUserRole ==
                            UserRole.USER)
                          ListTile(
                            title: const CustomText(text: "Advertisments"),
                            leading:
                                const Icon(Icons.dashboard_customize_rounded),
                            trailing: const Icon(
                              Icons.arrow_forward_ios_rounded,
                              size: 20,
                            ),
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) => BlocProvider(
                                          create: (context) =>
                                              UserCottagesCubit(),
                                          child: const MyAdvertisementsScreen(),
                                        )),
                              );
                            },
                          ),
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
                (AuthenticationCubit.currentUserRole != UserRole.ADMIN)
                    ? Center(
                        child: FractionallySizedBox(
                          widthFactor: 0.95,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                  text: AppLocalizations.of(context)!.other,
                                  color: Colors.grey),
                              ListTile(
                                title: CustomText(
                                    text:
                                        AppLocalizations.of(context)!.feedback),
                                trailing: const Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  size: 20,
                                ),
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) =>
                                          const FeedbackScreen()));
                                },
                              ),
                              ListTile(
                                title: CustomText(
                                    text: AppLocalizations.of(context)!
                                        .aboutProgram),
                                trailing: const Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  size: 20,
                                ),
                                onTap: () {},
                              ),
                            ],
                          ),
                        ),
                      )
                    : Center(
                        child: FractionallySizedBox(
                          widthFactor: 0.95,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                  text: AppLocalizations.of(context)!.other,
                                  color: Colors.grey),
                              ListTile(
                                title: CustomText(
                                    text:
                                        AppLocalizations.of(context)!.feedback),
                                trailing: const Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  size: 20,
                                ),
                                onTap: () {},
                              ),
                              ListTile(
                                title:
                                    const CustomText(text: 'Approve cottages'),
                                trailing: const Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  size: 20,
                                ),
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) =>
                                          const ApproveCottageScreen()));
                                },
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

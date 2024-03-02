import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:oasis_uz_mobile/app/material_app.dart';
import 'package:oasis_uz_mobile/bloc/authentication/authentication_cubit.dart';
import 'package:oasis_uz_mobile/repositories/enums/auth_enum.dart';
import 'package:oasis_uz_mobile/screens/feedback_screen.dart';
import 'package:oasis_uz_mobile/screens/language_screen.dart';
import 'package:oasis_uz_mobile/screens/sign_in.dart';
import 'package:oasis_uz_mobile/widgets/custom_text.dart';
import 'package:oasis_uz_mobile/widgets/cutsom_header.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final authenticationCubit = context.read<AuthenticationCubit>();

    return SafeArea(
      child: Column(
        children: [
          AppHeader(AppLocalizations.of(context)!.profile),
          const SizedBox(height: 10),
          Center(
            child: FractionallySizedBox(
              widthFactor: 0.9,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                      text: AppLocalizations.of(context)!.myProfilte,
                      color: Colors.grey),
                  ListTile(
                    title: CustomText(
                        text: AppLocalizations.of(context)!.myProfilte),
                    leading: const Icon(Icons.person_2_outlined),
                    trailing: const Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 20,
                    ),
                    onTap: () {
                      final state = authenticationCubit.state;
                      if (state == AuthenticationStatus.unauthenticated) {
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
                      text: AppLocalizations.of(context)!.settings,
                      color: Colors.grey),
                  ListTile(
                    title: CustomText(
                        text: AppLocalizations.of(context)!.changeLanguage),
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
      ),
    );
  }
}

class TKeys {}

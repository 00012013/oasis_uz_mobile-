import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:oasis_uz_mobile/screens/feedback_screen.dart';
import 'package:oasis_uz_mobile/screens/language_screen.dart';
import 'package:oasis_uz_mobile/widgets/custom_text.dart';
import 'package:oasis_uz_mobile/widgets/cutsom_header.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  Widget build(BuildContext context) {
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
                    onTap: () {},
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
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const LanguageScreen()));
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

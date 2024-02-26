import 'package:flutter/material.dart';
import 'package:oasis_uz_mobile/app/material_app.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:oasis_uz_mobile/constants/app_color.dart';
import 'package:oasis_uz_mobile/constants/language_constants.dart';
import 'package:oasis_uz_mobile/widgets/custom_text.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  late String selectedLanguage;

  @override
  void initState() {
    super.initState();
    final locale = MyApp.of(context)?.locale;
    if (locale!.languageCode == ENGLISH) {
      selectedLanguage = ENGLISH;
    } else if (locale.languageCode == RUSSIAN) {
      selectedLanguage = RUSSIAN;
    } else {
      selectedLanguage = UZBEK;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          text: AppLocalizations.of(context)!.lang,
          color: Colors.black,
          size: 18,
          weight: FontWeight.bold,
        ),
        centerTitle: true,
        elevation: 1,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        actions: [
          IconButton(
            icon: const Icon(Icons.done),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 150,
            ),
            const Icon(
              Icons.language_sharp,
              size: 100,
              color: tealColor,
            ),
            const SizedBox(
              height: 25,
            ),
            CustomText(
              text: AppLocalizations.of(context)!.selectLanguage,
              weight: FontWeight.w500,
              size: 22,
            ),
            const SizedBox(
              height: 25,
            ),
            InkWell(
              onTap: () {
                MyApp.setLocale(context, const Locale('uz'));
                selectedLanguage = UZBEK;
              },
              child: Container(
                width: MediaQuery.sizeOf(context).width * 0.4,
                decoration: BoxDecoration(
                  color: selectedLanguage == UZBEK ? tealColor : null,
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.all(16),
                child: CustomText(
                  text: '🇺🇿  O\'zbek',
                  size: 22,
                  color:
                      selectedLanguage != UZBEK ? Colors.black : Colors.white,
                ),
              ),
            ),
            InkWell(
              onTap: () {
                MyApp.setLocale(context, const Locale('ru'));
                selectedLanguage = RUSSIAN;
              },
              child: Container(
                width: MediaQuery.sizeOf(context).width * 0.4,
                decoration: BoxDecoration(
                  color: selectedLanguage == RUSSIAN ? tealColor : null,
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.all(16),
                child: CustomText(
                  text: '🇷🇺   Русский',
                  size: 22,
                  color:
                      selectedLanguage != RUSSIAN ? Colors.black : Colors.white,
                ),
              ),
            ),
            InkWell(
              onTap: () {
                MyApp.setLocale(context, const Locale('en'));
                selectedLanguage = ENGLISH;
              },
              child: Container(
                width: MediaQuery.sizeOf(context).width * 0.4,
                decoration: BoxDecoration(
                  color: selectedLanguage == ENGLISH ? tealColor : null,
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.all(16),
                child: CustomText(
                  text: '🇺🇸   English',
                  size: 22,
                  color:
                      selectedLanguage != ENGLISH ? Colors.black : Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

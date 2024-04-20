import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oasis_uz_mobile/app/app_main.dart';
import 'package:oasis_uz_mobile/bloc/authentication/authentication_cubit.dart';
import 'package:oasis_uz_mobile/bloc/cottageCubit/cottage_cubit.dart';
import 'package:oasis_uz_mobile/bloc/filter_cottage/filter_cottage_bloc.dart';
import 'package:oasis_uz_mobile/bloc/navigation/navigation_bloc.dart';
import 'package:oasis_uz_mobile/bloc/popular_cottages/popular_cottages_bloc_bloc.dart';
import 'package:oasis_uz_mobile/constants/language_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:oasis_uz_mobile/repositories/authentication_repository.dart';
import 'package:oasis_uz_mobile/repositories/cottage_repository.dart';
import 'package:oasis_uz_mobile/util/language.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
  static void setLocale(BuildContext context, Locale newLocale) {
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state?.setLocale(newLocale);
  }

  static _MyAppState? of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    _getLocaleFromPreferences();
  }

  void _getLocaleFromPreferences() async {
    String? languageCode = await LanguagePreferences.getLanguage();
    if (languageCode != null) {
      setState(() {
        _locale = Locale(languageCode);
      });
    } else {
      LanguagePreferences.saveLanguage(ENGLISH);
    }
  }

  Locale? _locale;

  setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  Locale? get locale => _locale;

  static _MyAppState? of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>();

  @override
  void didChangeDependencies() {
    getLocale().then((locale) => {setLocale(locale)});
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => PopularCottagesBlocBloc(CottageRepository()),
        ),
        BlocProvider(
          create: (context) =>
              AuthenticationCubit(AuthenticationRepository())..initialize(),
        ),
        BlocProvider(
            create: (context) => FilterCottageBloc(CottageRepository())),
        BlocProvider(create: (context) => NavigationBloc()),
        BlocProvider(
          create: (context) => CottageCubit(),
        ),
      ],
      child: MaterialApp(
        locale: _locale,
        debugShowCheckedModeBanner: false,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: const AppMain(initialPageIndex: 0),
      ),
    );
  }
}

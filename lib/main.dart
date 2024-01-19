import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oasis_uz_mobile/bloc/carousel/carousel_slider_bloc.dart';
import 'package:oasis_uz_mobile/bloc/cottage/cottage_bloc.dart';
import 'package:oasis_uz_mobile/bloc/navigation/navigation_bloc.dart';
import 'package:oasis_uz_mobile/repositories/cottage_repository.dart';
import 'package:oasis_uz_mobile/repositories/modules/cottage.dart';
import 'package:oasis_uz_mobile/screens/favourites_dart.dart';
import 'package:oasis_uz_mobile/screens/home_screen.dart';
import 'package:oasis_uz_mobile/screens/search_screen.dart';
import 'package:oasis_uz_mobile/screens/user_profile.dart';
import 'package:oasis_uz_mobile/widgets/app_bar.dart';
import 'package:oasis_uz_mobile/widgets/custom_bottom_nav_bar.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => NavigationBloc()),
      ],
      child: BlocBuilder<NavigationBloc, NavigationState>(
        builder: (context, state) {
          if (state is NavigationInitial) {
            return Scaffold(
              appBar: const CustomAppBar(),
              backgroundColor: Colors.white,
              body: IndexedStack(
                index: state.tabIndex,
                children: const [
                  HomeScreen(),
                  SearchScreen(),
                  FavoritesScreen(),
                  UserProfile(),
                ],
              ),
              bottomNavigationBar: BottomNavigationBar(
                currentIndex: state.tabIndex,
                onTap: (index) {
                  context.read<NavigationBloc>().add(
                        TabChange(tabIndex: index),
                      );
                },
                items: [
                  customBottomNavItem(Icons.home_outlined, ''),
                  customBottomNavItem(Icons.search, ''),
                  customBottomNavItem(Icons.favorite_border, ''),
                  customBottomNavItem(Icons.person_2_outlined, '')
                ],
              ),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}

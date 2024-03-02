import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oasis_uz_mobile/bloc/navigation/navigation_bloc.dart';
import 'package:oasis_uz_mobile/screens/home_screen.dart';
import 'package:oasis_uz_mobile/screens/message_screen.dart';
import 'package:oasis_uz_mobile/screens/my_cottages_screen.dart';
import 'package:oasis_uz_mobile/screens/search_screen.dart';
import 'package:oasis_uz_mobile/screens/user_profile.dart';
import 'package:oasis_uz_mobile/widgets/custom_bottom_nav_bar.dart';

class AppMain extends StatefulWidget {
  const AppMain({super.key});

  @override
  State<AppMain> createState() => _AppMainState();
}

class _AppMainState extends State<AppMain> {
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
              backgroundColor: Colors.white,
              body: IndexedStack(
                index: state.tabIndex,
                children: [
                  HomeScreen(),
                  SearchScreen(),
                  MyCottagesScreen(),
                  const MessageScreen(),
                  const UserProfile(),
                ],
              ),
              bottomNavigationBar: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                currentIndex: state.tabIndex,
                onTap: (index) {
                  context.read<NavigationBloc>().add(
                        TabChange(tabIndex: index),
                      );
                },
                items: [
                  customBottomNavItem(Icons.home_outlined, ''),
                  customBottomNavItem(Icons.search, ''),
                  customBottomNavItem(Icons.add_circle_outline_rounded, ''),
                  customBottomNavItem(Icons.message_rounded, ''),
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

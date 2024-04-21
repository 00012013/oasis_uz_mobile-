import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oasis_uz_mobile/bloc/equipment/equipment_bloc.dart';
import 'package:oasis_uz_mobile/bloc/image_management/image_management_cubit.dart';
import 'package:oasis_uz_mobile/bloc/navigation/navigation_bloc.dart';
import 'package:oasis_uz_mobile/screens/home_screen.dart';
import 'package:oasis_uz_mobile/screens/message_screen.dart';
import 'package:oasis_uz_mobile/screens/my_cottages_screen.dart';
import 'package:oasis_uz_mobile/screens/search_screen.dart';
import 'package:oasis_uz_mobile/screens/user_profile.dart';
import 'package:oasis_uz_mobile/widgets/custom_bottom_nav_bar.dart';

class AppMain extends StatefulWidget {
  const AppMain({super.key, this.initialPageIndex = 0});
  final int initialPageIndex;

  @override
  State<AppMain> createState() => AppMainState();
}

class AppMainState extends State<AppMain> {
  late PageController _pageController;
  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: widget.initialPageIndex);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationBloc, NavigationState>(
      builder: (context, state) {
        if (state is NavigationInitial) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: PageView(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              onPageChanged: (index) {
                context.read<NavigationBloc>().add(TabChange(tabIndex: index));
              },
              children: [
                HomeScreen(),
                SearchScreen(),
                MultiBlocProvider(
                  providers: [
                    BlocProvider(create: (create) => EquipmentBloc()),
                    BlocProvider(
                      create: (context) => ImageManagementCubit(),
                    ),
                  ],
                  child: const MyCottagesScreen(),
                ),
                const MessageScreen(),
                const UserProfile(),
              ],
            ),
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: state.tabIndex,
              onTap: (index) {
                context.read<NavigationBloc>().add(TabChange(tabIndex: index));
                _pageController.jumpToPage(
                  index,
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
    );
  }
}

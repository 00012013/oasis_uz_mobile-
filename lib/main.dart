import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oasis_uz_mobile/bloc/navigation_bloc.dart';
import 'package:oasis_uz_mobile/screens/home_screen.dart';
import 'package:oasis_uz_mobile/screens/search_screen.dart';

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
    return BlocProvider(
      create: (context) => NavigationBloc(),
      child: BlocBuilder<NavigationBloc, NavigationState>(
        builder: (context, state) {
          if (state is NavigationInitial) {
            return Scaffold(
              backgroundColor: Colors.white,
              body: IndexedStack(
                index: state.tabIndex,
                children: const [
                  HomeScreen(),
                  SearchScreen(),
                  SearchScreen(),
                ],
              ),
              bottomNavigationBar: BottomNavigationBar(
                currentIndex: state.tabIndex,
                onTap: (index) {
                  context.read<NavigationBloc>().add(
                        TabChange(tabIndex: index),
                      );
                },
                items: const [
                  BottomNavigationBarItem(
                    label: 'Home',
                    icon: Icon(Icons.home),
                  ),
                  BottomNavigationBarItem(
                    label: 'Profile',
                    icon: Icon(Icons.person),
                  ),
                  BottomNavigationBarItem(
                    label: 'Settings',
                    icon: Icon(Icons.settings),
                  ),
                ],
              ),
            );
          } else {
            return Container();
          }
        },
      ),
    );
    ;
  }
}

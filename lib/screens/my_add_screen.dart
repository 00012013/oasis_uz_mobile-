import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oasis_uz_mobile/bloc/authentication/authentication_cubit.dart';
import 'package:oasis_uz_mobile/bloc/authentication/authentication_state.dart';
import 'package:oasis_uz_mobile/bloc/equipment/equipment_bloc.dart';
import 'package:oasis_uz_mobile/bloc/image_management/image_management_cubit.dart';
import 'package:oasis_uz_mobile/bloc/userCottages/user_cottages_cubit.dart';
import 'package:oasis_uz_mobile/screens/my_cottages_screen.dart';
import 'package:oasis_uz_mobile/screens/sign_in.dart';
import 'package:oasis_uz_mobile/widgets/cottage_tile.dart';
import 'package:oasis_uz_mobile/widgets/custom_text.dart';

class MyAdvertisementsScreen extends StatefulWidget {
  const MyAdvertisementsScreen({super.key});

  @override
  State<MyAdvertisementsScreen> createState() => _MyAdvertisementsScreenState();
}

class _MyAdvertisementsScreenState extends State<MyAdvertisementsScreen> {
  @override
  Widget build(BuildContext context) {
    final AuthenticationCubit authenticationCubit =
        BlocProvider.of<AuthenticationCubit>(context);
    var authState = authenticationCubit.state;

    if (authState is! AuthenticationSuccess) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.of(context).push(
          MaterialPageRoute(
              builder: (context) => const SignInScreen(initialPageIndex: 4)),
        );
      });
      return Container();
    } else {
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const CustomText(
            text: 'My Advertisements',
            weight: FontWeight.bold,
            color: Colors.black,
            size: 18,
          ),
          elevation: 1,
          backgroundColor: Colors.white,
          iconTheme: const IconThemeData(color: Colors.black),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: BlocBuilder<UserCottagesCubit, UserCottagesState>(
            builder: (context, state) {
              if (state is UserCottagesInitial) {
                return Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.4,
                    ),
                    const Center(
                      child: CircularProgressIndicator(),
                    ),
                  ],
                );
              } else if (state is UserCottagesLoaded) {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: state.cottages.length,
                  physics: const PageScrollPhysics(),
                  itemBuilder: (context, index) {
                    final cottage = state.cottages[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MultiBlocProvider(
                              providers: [
                                BlocProvider(
                                  create: (context) => ImageManagementCubit(),
                                ),
                                BlocProvider(
                                  create: (context) => EquipmentBloc(),
                                ),
                              ],
                              child: MyCottagesScreen(cottage, true),
                            ),
                          ),
                        );
                      },
                      child: CustomCottageTile(
                        true,
                        cottage: cottage!,
                      ),
                    );
                  },
                );
              } else if (state is UserCottagesException) {
                return Center(
                  child: CustomText(text: state.message),
                );
              } else {
                return Container();
              }
            },
          ),
        ),
      );
    }
  }
}

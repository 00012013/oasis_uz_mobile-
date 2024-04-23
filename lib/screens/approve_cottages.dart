import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oasis_uz_mobile/bloc/approveCottage/approve_cottage_cubit.dart';
import 'package:oasis_uz_mobile/bloc/approveCottage/approve_cottage_state.dart';
import 'package:oasis_uz_mobile/bloc/carousel/carousel_slider_bloc.dart';
import 'package:oasis_uz_mobile/bloc/isVisible/visible_bloc.dart';
import 'package:oasis_uz_mobile/screens/cottage_screen.dart';
import 'package:oasis_uz_mobile/widgets/cottage_tile.dart';
import 'package:oasis_uz_mobile/widgets/custom_text.dart';

class ApproveCottageScreen extends StatelessWidget {
  const ApproveCottageScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const CustomText(
          text: 'Cottages List',
          weight: FontWeight.bold,
          color: Colors.black,
          size: 18,
        ),
        elevation: 1,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        child: BlocBuilder<ApproveCottageCubit, ApproveCottageState>(
          builder: (context, state) {
            if (state is ApproveCottageInitial) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is ApproveCottageLoaded) {
              return ListView.builder(
                itemCount: state.availableCottages.length,
                itemBuilder: (context, index) {
                  final cottage = state.availableCottages[index];
                  return GestureDetector(
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => MultiBlocProvider(providers: [
                          BlocProvider.value(
                            value: CarouselSliderBloc(),
                          ),
                          BlocProvider.value(
                            value: VisibleBloc(),
                          ),
                        ], child: CottageScreen(cottage, true)),
                      ),
                    ),
                    child: CustomCottageTile(
                      false,
                      cottage: cottage!,
                    ),
                  );
                },
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

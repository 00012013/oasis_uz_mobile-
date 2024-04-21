import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oasis_uz_mobile/bloc/approveCottage/approve_cottage_cubit.dart';
import 'package:oasis_uz_mobile/bloc/approveCottage/approve_cottage_state.dart';
import 'package:oasis_uz_mobile/bloc/carousel/carousel_slider_bloc.dart';
import 'package:oasis_uz_mobile/bloc/isVisible/visible_bloc.dart';
import 'package:oasis_uz_mobile/repositories/enums/status.dart';
import 'package:oasis_uz_mobile/repositories/models/cottage.dart';
import 'package:oasis_uz_mobile/screens/cottage_screen.dart';
import 'package:oasis_uz_mobile/widgets/custom_image.dart';
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
      body: BlocBuilder<ApproveCottageCubit, ApproveCottageState>(
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
                    cottage: cottage!,
                  ),
                );
              },
            );
          } else if (state is ApproveCottageError) {
            return Center(
              child: Text(state.errorMessage),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}

class CustomCottageTile extends StatelessWidget {
  final Cottage cottage;

  const CustomCottageTile({
    Key? key,
    required this.cottage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 120,
            height: 120,
            child: CustomImage(
              cottage.mainAttachment!.id.toString(),
              8,
              true,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomText(text: cottage.name, weight: FontWeight.bold),
                  CustomText(
                    text: '${cottage.weekDaysPrice} USD',
                    weight: FontWeight.bold,
                  ),
                ],
              ),
            ),
          ),
          Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(color: Colors.grey[300]!),
              ),
              child: CustomText(
                text: cottage.status.toStringValue(),
                color: Colors.white,
              )),
          const SizedBox(
            width: 5,
          ),
        ],
      ),
    );
  }
}

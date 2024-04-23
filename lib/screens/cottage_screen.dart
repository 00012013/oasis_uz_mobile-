import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:oasis_uz_mobile/bloc/approveCottage/approve_cottage_cubit.dart';
import 'package:oasis_uz_mobile/bloc/authentication/authentication_cubit.dart';
import 'package:oasis_uz_mobile/bloc/calendar/calendar_bloc.dart';
import 'package:oasis_uz_mobile/bloc/carousel/carousel_slider_bloc.dart';
import 'package:oasis_uz_mobile/repositories/enums/auth_enum.dart';
import 'package:oasis_uz_mobile/repositories/enums/status.dart';
import 'package:oasis_uz_mobile/repositories/models/cottage.dart';
import 'package:oasis_uz_mobile/widgets/custom_button.dart';
import 'package:oasis_uz_mobile/widgets/custom_image.dart';
import 'package:oasis_uz_mobile/widgets/custom_snackbar.dart';
import 'package:oasis_uz_mobile/widgets/custom_text.dart';
import 'package:table_calendar/table_calendar.dart';

class CottageScreen extends StatelessWidget {
  final Cottage? cottage;
  bool changeStatus;
  CottageScreen(this.cottage, this.changeStatus, {super.key});

  @override
  Widget build(BuildContext context) {
    cottage!.bookedDates!.addAll([
      DateTime.utc(2024, 2, 1),
      DateTime.utc(2024, 2, 2),
      DateTime.utc(2024, 2, 5),
      DateTime.utc(2024, 2, 28),
      DateTime.utc(2024, 2, 29),
    ]);
    List<CustomImage> cottageAttachmentList = cottage!.attachmentsList!
        .map(
          (cottage) => CustomImage(cottage.id.toString(), 10, true, true),
        )
        .toList();
    return Scaffold(
      appBar: AppBar(
        title: const CustomText(
          text: "Description",
          color: Colors.black,
          size: 18,
        ),
        centerTitle: true,
        elevation: 1,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Align(
          alignment: Alignment.center,
          child: FractionallySizedBox(
            widthFactor: 0.9,
            child: MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (context) => CalendarBloc(),
                ),
              ],
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 5,
                  ),
                  Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      CarouselSlider(
                        items: cottageAttachmentList,
                        options: CarouselOptions(
                          height: 200,
                          viewportFraction: 1,
                          autoPlayCurve: Curves.fastOutSlowIn,
                          autoPlayAnimationDuration:
                              const Duration(milliseconds: 800),
                          onPageChanged: (index, reason) {
                            BlocProvider.of<CarouselSliderBloc>(context)
                                .add(CarouselIndexChanged(index));
                          },
                        ),
                      ),
                      BlocBuilder<CarouselSliderBloc, CarouselSlidersState>(
                        builder: (context, state) {
                          if (state is CarouselIndexUpdated) {
                            return DotsIndicator(
                              dotsCount: cottageAttachmentList.length,
                              position: state.currentIndex.toDouble(),
                              decorator: DotsDecorator(
                                size: const Size.square(8.0),
                                activeSize: const Size(8.0, 8.0),
                                color: Colors.grey,
                                activeColor: Colors.white,
                                activeShape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                              ),
                            );
                          } else {
                            return Container();
                          }
                        },
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomText(
                    text: cottage!.name,
                    size: 19,
                    color: Colors.black,
                    weight: FontWeight.w600,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  RatingBar.builder(
                    initialRating: 5,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemSize: 12,
                    itemBuilder: (context, _) => const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    ignoreGestures: true,
                    onRatingUpdate: (double value) {},
                  ),
                  const SizedBox(height: 8),

                  CustomText(
                    text: "Weekdays price: ${cottage!.weekDaysPrice} USD ",
                    weight: FontWeight.w600,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  CustomText(
                    text: "Weekends price: ${cottage!.weekendDaysPrice} USD ",
                    weight: FontWeight.w600,
                  ),

                  // if (AuthenticationCubit.currentUserRole != UserRole.ADMIN)
                  //   ElevatedButton(
                  //     onPressed: () {
                  //       BlocProvider.of<VisibleBloc>(context)
                  //           .add(VisibleEvent.toggleVisibility);
                  //     },
                  //     child: const CustomText(
                  //       text: 'Calendar',
                  //       color: Colors.white,
                  //     ),
                  //   ),
                  const SizedBox(
                    height: 8,
                  ),
                  CustomText(
                    text: "Total rooms: ${cottage!.totalRoomCount} ",
                    weight: FontWeight.w600,
                    size: 16,
                  ),
                  const SizedBox(height: 8),
                  CustomText(
                    text: "Max guests: ${cottage!.guestCount}",
                    weight: FontWeight.w600,
                  ),
                  const SizedBox(height: 8),

                  const CustomText(
                    text: 'Description: ',
                    weight: FontWeight.bold,
                    size: 18,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    cottage!.description!.trim(),
                  ),
                  if (AuthenticationCubit.currentUserRole != UserRole.ADMIN)
                    // BlocBuilder<VisibleBloc, bool>(
                    //   builder: (context, isHidden) {
                    //     return Visibility(
                    //       visible: isHidden,
                    //       child:
                    BlocBuilder<CalendarBloc, CalendarState>(
                      builder: (context, state) {
                        if (state is CalendarUpdatedState) {
                          return TableCalendar(
                            availableGestures: AvailableGestures.all,
                            calendarBuilders: CalendarBuilders(
                              markerBuilder: (context, date, events) {
                                return Padding(
                                  padding: const EdgeInsets.all(6.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: cottage!.bookedDates!
                                                  .contains(date) &&
                                              date.isAfter(DateTime.now())
                                          ? Colors.blueAccent
                                          : null,
                                      borderRadius: BorderRadius.circular(40),
                                    ),
                                    child: Center(
                                      child: Text(
                                        '${date.day}',
                                        style: TextStyle(
                                          color: ((cottage!.bookedDates!
                                                          .contains(date) &&
                                                      date.isAfter(
                                                          DateTime.now())) ||
                                                  ((state.focusedDay == date) &&
                                                      date.isAfter(
                                                          DateTime.now()))
                                              ? Colors.white
                                              : date.isBefore(DateTime.now())
                                                  ? Colors.grey
                                                  : Colors.black),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                              selectedBuilder: (context, date, events) {
                                return Padding(
                                  padding: const EdgeInsets.all(6.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: date.isAfter(DateTime.now())
                                          ? Colors.orangeAccent
                                          : null,
                                      borderRadius: BorderRadius.circular(40),
                                    ),
                                    child: Center(
                                      child: Text(
                                        '${date.day}',
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                            calendarFormat: CalendarFormat.month,
                            calendarStyle: const CalendarStyle(
                              outsideTextStyle: TextStyle(color: Colors.grey),
                              isTodayHighlighted: false,
                            ),
                            availableCalendarFormats: const {
                              CalendarFormat.month: 'Month'
                            },
                            dayHitTestBehavior: HitTestBehavior.opaque,
                            daysOfWeekStyle: const DaysOfWeekStyle(),
                            enabledDayPredicate: (day) => true,
                            firstDay: DateTime(2024, 1, 1),
                            focusedDay: state.focusedDay,
                            formatAnimationCurve: Curves.linear,
                            formatAnimationDuration:
                                const Duration(milliseconds: 300),
                            headerStyle: const HeaderStyle(titleCentered: true),
                            headerVisible: true,
                            holidayPredicate: (day) => false,
                            lastDay: DateTime(2030, 12, 31),
                            locale: 'en_US',
                            pageAnimationCurve: Curves.easeInOut,
                            pageAnimationDuration:
                                const Duration(milliseconds: 500),
                            pageJumpingEnabled: true,
                            rangeSelectionMode: RangeSelectionMode.toggledOn,
                            selectedDayPredicate: (day) {
                              return isSameDay(state.selectedDay, day);
                            },
                            onDaySelected: (selectedDay, focusedDay) {
                              BlocProvider.of<CalendarBloc>(context).add(
                                UpdateSelectedDayEvent(selectedDay, focusedDay),
                              );
                            },
                            startingDayOfWeek: StartingDayOfWeek.monday,
                          );
                        } else {
                          return Container();
                        }
                      },
                    ),

                  // );
                  // },
                  // ),
                  if (AuthenticationCubit.currentUserRole == UserRole.ADMIN &&
                      changeStatus)
                    Builder(builder: (ctx) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                            child: CustomButton(
                              text: 'Decline',
                              onPressed: () {
                                CustomSnackBar(backgroundColor: Colors.green)
                                    .showError(
                                  ctx,
                                  "Succefuly Declined!",
                                );
                                var approveCottageCubit =
                                    BlocProvider.of<ApproveCottageCubit>(
                                        context);

                                approveCottageCubit.changeStatus(
                                  Cottage(
                                      id: cottage!.id, status: Status.DECLINED),
                                );
                                Navigator.pop(context);
                              },
                              color: Colors.redAccent,
                              borderRadius: 20.0,
                              fontSize: 18.0,
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: CustomButton(
                              text: 'Approve',
                              onPressed: () {
                                var approveCottageCubit =
                                    BlocProvider.of<ApproveCottageCubit>(
                                        context);
                                CustomSnackBar(backgroundColor: Colors.green)
                                    .showError(
                                  ctx,
                                  "Succefuly Approved!",
                                );
                                approveCottageCubit.changeStatus(
                                  Cottage(
                                      id: cottage!.id, status: Status.APPROVED),
                                );
                                Navigator.pop(context);
                              },
                              color: Colors.green,
                              borderRadius: 20.0,
                              fontSize: 18.0,
                            ),
                          ),
                        ],
                      );
                    }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

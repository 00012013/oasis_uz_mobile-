import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oasis_uz_mobile/bloc/dropdown/dropdown_bloc.dart';
import 'package:oasis_uz_mobile/bloc/equipment/equipment_bloc.dart';
import 'package:oasis_uz_mobile/bloc/filter/filter_bloc.dart';
import 'package:oasis_uz_mobile/bloc/price_range/price_range_bloc.dart';
import 'package:oasis_uz_mobile/constants/app_color.dart';
import 'package:oasis_uz_mobile/repositories/modules/filter.dart';
import 'package:oasis_uz_mobile/widgets/custom_slider.dart';
import 'package:oasis_uz_mobile/widgets/custom_text.dart';
import 'package:oasis_uz_mobile/widgets/drop_down_widget.dart';
import 'package:oasis_uz_mobile/widgets/filter_options_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FilterScreen extends StatelessWidget {
  const FilterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          text: AppLocalizations.of(context)!.filter,
          color: Colors.black,
          size: 18,
          weight: FontWeight.bold,
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                const CustomText(
                  text: 'Sorting types',
                  weight: FontWeight.w600,
                ),
                const SizedBox(
                  height: 15,
                ),
                BlocBuilder<FilterBloc, FilterState>(
                  builder: (context, state) {
                    return Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            FilterOptionWidget(
                              label: 'Latest',
                              isSelected: state is FilterByLatestSelected,
                              onTap: () {
                                BlocProvider.of<FilterBloc>(context).add(
                                  const FilterTypeSelected(
                                    FilterTypeOption.latest,
                                  ),
                                );
                              },
                            ),
                            FilterOptionWidget(
                              label: 'Cheapest',
                              isSelected: state is FilterByCheapestSelected,
                              onTap: () {
                                BlocProvider.of<FilterBloc>(context).add(
                                  const FilterTypeSelected(
                                    FilterTypeOption.cheapest,
                                  ),
                                );
                              },
                            ),
                            FilterOptionWidget(
                              label: 'Most Expensive',
                              isSelected:
                                  state is FilterByMostExpensiveSelected,
                              onTap: () {
                                BlocProvider.of<FilterBloc>(context).add(
                                  const FilterTypeSelected(
                                    FilterTypeOption.mostExpensive,
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                const CustomText(
                  text: 'Popular places',
                  weight: FontWeight.w600,
                ),
                const SizedBox(height: 15),
                BlocBuilder<DropdownBloc, DropdownState>(
                  builder: (context, dropdownState) {
                    return DropDownWidget(
                      dropdownState.selectedOption,
                      dropdownState.options,
                      (value) {
                        BlocProvider.of<DropdownBloc>(context).add(
                          dropdownState is RefreshState
                              ? SelectOptionEvent(value)
                              : RefreshEvent(value),
                        );
                      },
                    );
                  },
                ),
                const SizedBox(height: 20),
                const CustomText(
                  text: 'Price Range',
                  weight: FontWeight.w600,
                ),
                const SizedBox(height: 10),
                BlocBuilder<PriceRangeBloc, PriceRangeState>(
                  builder: (context, state) {
                    if (state is PriceRangeFiltered) {
                      return Column(
                        children: [
                          CustomSliderTheme(
                            child: RangeSlider(
                              values:
                                  RangeValues(state.minPrice, state.maxPrice),
                              min: 0,
                              max: 10000000,
                              divisions: 10,
                              onChanged: (RangeValues values) {
                                BlocProvider.of<PriceRangeBloc>(context).add(
                                  PriceRangeUpdated(values.start, values.end),
                                );
                              },
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                _formatNumberWithSpaces(state.minPrice),
                              ),
                              Text(
                                _formatNumberWithSpaces(state.maxPrice),
                              ),
                            ],
                          ),
                        ],
                      );
                    } else {
                      return const SizedBox();
                    }
                  },
                ),
                const SizedBox(height: 15),
                const CustomText(
                  text: 'Additional FIlters',
                  weight: FontWeight.w600,
                ),
                const SizedBox(height: 15),
                BlocBuilder<EquipmentBloc, EquipmentState>(
                  builder: (context, state) {
                    if (state is EquipmentLoaded) {
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: state.items.length,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          final item = state.items[index];
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Checkbox(
                                visualDensity: VisualDensity.compact,
                                value: item.isChecked,
                                activeColor: mainColor,
                                onChanged: (value) {
                                  BlocProvider.of<EquipmentBloc>(context)
                                      .add(ToggleItemEvent(item.name));
                                },
                              ),
                              Text(item.name),
                            ],
                          );
                        },
                      );
                    } else {
                      return Container();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: Container(
        height: 50,
        color: Colors.white,
        padding: EdgeInsets.only(
            bottom: 10,
            left: MediaQuery.sizeOf(context).width * 0.05,
            right: MediaQuery.sizeOf(context).width * 0.05),
        width: MediaQuery.sizeOf(context).width * 1,
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(mainColor),
            foregroundColor: MaterialStateProperty.all(Colors.white),
          ),
          onPressed: () {
            FilterTypeOption? filterByType;
            final filterBlocState = BlocProvider.of<FilterBloc>(context).state;
            if (filterBlocState is FilterByCheapestSelected) {
              filterByType = FilterTypeOption.cheapest;
            } else if (filterBlocState is FilterByLatestSelected) {
              filterByType = FilterTypeOption.latest;
            } else if (filterBlocState is FilterByMostExpensiveSelected) {
              filterByType = FilterTypeOption.mostExpensive;
            }

            final dropDownState = BlocProvider.of<DropdownBloc>(context).state;
            final selectedOption = dropDownState.selectedOption;

            final priceRangeState =
                BlocProvider.of<PriceRangeBloc>(context).state;
            double? maxPrice;
            double? minPrice;
            if (priceRangeState is PriceRangeFiltered) {
              maxPrice = priceRangeState.maxPrice;
              minPrice = priceRangeState.minPrice;
            }

            final equipmentState =
                BlocProvider.of<EquipmentBloc>(context).state;
            List<String>? equipmentList = [];
            if (equipmentState is EquipmentLoaded) {
              equipmentList = equipmentState.items
                  .where((item) => item.isChecked)
                  .map((e) => e.name.toUpperCase())
                  .toList();
            }

            Filter filterDto = Filter(filterByType?.toString().split('.').last,
                selectedOption, minPrice, maxPrice, equipmentList);

            Navigator.of(context).pop(filterDto);
          },
          child: const CustomText(
            text: 'Apply changes',
            size: 16,
            color: Colors.white,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

String _formatNumberWithSpaces(double number) {
  String originalNumber = number.toStringAsFixed(0);

  String formattedNumber = '';

  int count = 0;
  for (int i = originalNumber.length - 1; i >= 0; i--) {
    formattedNumber = originalNumber[i] + formattedNumber;
    count++;

    if (count % 3 == 0 && i != 0) {
      formattedNumber = ' $formattedNumber';
    }
  }

  return formattedNumber;
}

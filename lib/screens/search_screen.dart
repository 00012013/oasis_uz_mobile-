import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oasis_uz_mobile/bloc/carousel/carousel_slider_bloc.dart';
import 'package:oasis_uz_mobile/bloc/dropdown/dropdown_bloc.dart';
import 'package:oasis_uz_mobile/bloc/equipment/equipment_bloc.dart';
import 'package:oasis_uz_mobile/bloc/filter/filter_bloc.dart';
import 'package:oasis_uz_mobile/bloc/filter_cottage/filter_cottage_bloc.dart';
import 'package:oasis_uz_mobile/bloc/isVisible/visible_bloc.dart';
import 'package:oasis_uz_mobile/bloc/price_range/price_range_bloc.dart';
import 'package:oasis_uz_mobile/constants/app_color.dart';
import 'package:oasis_uz_mobile/repositories/cottage_repository.dart';
import 'package:oasis_uz_mobile/repositories/models/filter.dart';
import 'package:oasis_uz_mobile/screens/cottage_screen.dart';
import 'package:oasis_uz_mobile/screens/filter_screen.dart';
import 'package:oasis_uz_mobile/widgets/cottage_main.dart';
import 'package:oasis_uz_mobile/widgets/custom_text.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:oasis_uz_mobile/widgets/cutsom_header.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});

  final CottageRepository cottageRepository = CottageRepository();

  @override
  Widget build(BuildContext context) {
    final filterBLoc = BlocProvider.of<FilterCottageBloc>(context);
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AppHeader(AppLocalizations.of(context)!.search),
            const SizedBox(height: 10),
            BlocBuilder<FilterCottageBloc, FilterCottageState>(
              builder: (context, state) {
                return FractionallySizedBox(
                  widthFactor: 0.95,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            flex: 6,
                            child: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12),
                              decoration: BoxDecoration(
                                border: Border.all(),
                                borderRadius: BorderRadius.circular(18),
                              ),
                              child: Row(
                                children: [
                                  const Icon(Icons.search),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: TextField(
                                      onChanged: (value) {
                                        if (value.isNotEmpty) {
                                          BlocProvider.of<FilterCottageBloc>(
                                                  context)
                                              .add(
                                                  SearchTextNameChanged(value));
                                        }
                                      },
                                      cursorColor: mainColor,
                                      decoration: InputDecoration(
                                        hintText:
                                            '${AppLocalizations.of(context)!.search}...',
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            flex: 1,
                            child: GestureDetector(
                              onTap: () async {
                                Filter? filterDto =
                                    await Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => MultiBlocProvider(
                                      providers: [
                                        BlocProvider.value(
                                          value: DropdownBloc(),
                                        ),
                                        BlocProvider.value(
                                          value: FilterBloc(),
                                        ),
                                        BlocProvider.value(
                                          value: PriceRangeBloc(),
                                        ),
                                        BlocProvider.value(
                                          value: EquipmentBloc(),
                                        ),
                                        BlocProvider.value(
                                          value: filterBLoc,
                                        ),
                                      ],
                                      child: const FilterScreen(),
                                    ),
                                  ),
                                );
                                filterBLoc.add(FilterCottage(filterDto));
                              },
                              child: Container(
                                padding: const EdgeInsets.all(13),
                                decoration: BoxDecoration(
                                  color: mainColor,
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                child: const Icon(
                                  Icons.format_list_bulleted_rounded,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      state is FilterCottageLoaded
                          ? GridView.builder(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              itemCount: state.cottage.length,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 10,
                                crossAxisSpacing: 10,
                                childAspectRatio: 0.7,
                              ),
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                    onTap: () => Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                MultiBlocProvider(
                                                    providers: [
                                                  BlocProvider.value(
                                                    value: CarouselSliderBloc(),
                                                  ),
                                                  BlocProvider.value(
                                                    value: VisibleBloc(),
                                                  ),
                                                ],
                                                    child: CottageScreen(
                                                        state.cottage[index],
                                                        false)),
                                          ),
                                        ),
                                    child: CottageWidget(state.cottage[index]));
                              },
                            )
                          : Column(
                              children: [
                                SizedBox(
                                  height:
                                      MediaQuery.sizeOf(context).height * 0.3,
                                ),
                                Center(
                                  child: CustomText(
                                      text: AppLocalizations.of(context)!
                                          .searchText,
                                      color: Colors.black),
                                )
                              ],
                            ),
                    ],
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}

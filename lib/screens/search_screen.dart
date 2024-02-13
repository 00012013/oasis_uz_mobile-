import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oasis_uz_mobile/bloc/calendar/search_name_bloc.dart';
import 'package:oasis_uz_mobile/constants/app_color.dart';
import 'package:oasis_uz_mobile/repositories/cottage_repository.dart';
import 'package:oasis_uz_mobile/screens/filter_screen.dart';
import 'package:oasis_uz_mobile/widgets/custom_text.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Card(
              elevation: 1,
              color: Colors.white,
              child: Center(
                heightFactor: 3,
                child: CustomText(
                  text: 'Search',
                  size: 20,
                  weight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 10),
            FractionallySizedBox(
              widthFactor: 0.9,
              child: Row(
                children: [
                  Expanded(
                    flex: 6,
                    child: BlocProvider(
                      create: (context) => SearchNameBloc(CottageRepository()),
                      child: BlocBuilder<SearchNameBloc, SearchNameState>(
                          builder: (context, state) {
                        return Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
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
                                      BlocProvider.of<SearchNameBloc>(context)
                                          .add(SearchTextNameChanged(value));
                                    }
                                  },
                                  cursorColor: mainColor,
                                  decoration: const InputDecoration(
                                    hintText: 'Search...',
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    flex: 1,
                    child: GestureDetector(
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => const FilterScreen()),
                      ),
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
            ),
            SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.3,
            ),
            const Center(
              child: CustomText(
                  text: 'What are you looking for?', color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}

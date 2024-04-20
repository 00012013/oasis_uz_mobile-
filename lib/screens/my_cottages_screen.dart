import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oasis_uz_mobile/bloc/authentication/authentication_cubit.dart';
import 'package:oasis_uz_mobile/bloc/authentication/authentication_state.dart';
import 'package:oasis_uz_mobile/bloc/cottageCubit/cottage_cubit.dart';
import 'package:oasis_uz_mobile/bloc/equipment/equipment_bloc.dart';
import 'package:oasis_uz_mobile/bloc/image_management/image_management_cubit.dart';
import 'package:oasis_uz_mobile/constants/app_color.dart';
import 'package:oasis_uz_mobile/repositories/models/cottage.dart';
import 'package:oasis_uz_mobile/repositories/models/equipments.dart';
import 'package:oasis_uz_mobile/screens/map_screen.dart';
import 'package:oasis_uz_mobile/screens/sign_in.dart';
import 'package:oasis_uz_mobile/widgets/custom_snackbar.dart';
import 'package:oasis_uz_mobile/widgets/custom_text.dart';
import 'package:oasis_uz_mobile/widgets/custom_textfield.dart';
import 'package:oasis_uz_mobile/widgets/cutsom_header.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

class MyCottagesScreen extends StatefulWidget {
  const MyCottagesScreen({super.key});

  @override
  State<MyCottagesScreen> createState() => _MyCottagesScreenState();
}

class _MyCottagesScreenState extends State<MyCottagesScreen> {
  List<Asset> _images = <Asset>[];
  bool hasAttachment = false;
  String? address;

  List<Asset> _image = [];
  final nameController = TextEditingController();
  final descController = TextEditingController();
  final weekdayController = TextEditingController();
  final weekendController = TextEditingController();
  final guestController = TextEditingController();
  final totalRoomsController = TextEditingController();

  Future<void> _pickImages() async {
    List<Asset> resultList = [];

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 10,
        enableCamera: true,
        selectedAssets: _images,
      );
    } on Exception catch (e) {
      print('Error picking images: $e');
    }

    if (!mounted) return;

    setState(() {
      _images = resultList;
    });
  }

  Future<void> _pickImage() async {
    List<Asset> resultList = [];
    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 1,
        enableCamera: true,
        selectedAssets: _image,
      );
    } on Exception catch (e) {
      print('Error picking images: $e');
    }

    if (!mounted) return;
    setState(() {
      _image = resultList;
    });
  }

  @override
  Widget build(BuildContext context) {
    final AuthenticationCubit authenticationCubit =
        BlocProvider.of<AuthenticationCubit>(context);
    final cottageCubit = BlocProvider.of<CottageCubit>(context);
    final imageManagementCubit = BlocProvider.of<ImageManagementCubit>(context);
    final equipmentBloc = BlocProvider.of<EquipmentBloc>(context);
    var authState = authenticationCubit.state;
    final List<Equipment>? allItems =
        (equipmentBloc.state as EquipmentLoaded?)?.items;
    if (authState is! AuthenticationSuccess) {
      print("not auth");
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.of(context).push(
          MaterialPageRoute(
              builder: (context) => const SignInScreen(initialPageIndex: 2)),
        );
      });
      return Container();
    } else {
      return SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              AppHeader(AppLocalizations.of(context)!.myCottages),
              const SizedBox(height: 10),
              FractionallySizedBox(
                widthFactor: 0.95,
                child: Column(
                  children: [
                    BlocBuilder<CottageCubit, Cottage>(
                      builder: (context, state) {
                        nameController.text =
                            state.name == null ? '' : state.name!;
                        descController.text =
                            state.description == null ? '' : state.description!;
                        weekdayController.text = state.weekDaysPrice == null
                            ? ''
                            : state.weekDaysPrice == 0
                                ? ''
                                : '${state.weekDaysPrice?.toInt()}';
                        weekendController.text = state.weekendDaysPrice == null
                            ? ''
                            : state.weekendDaysPrice == 0
                                ? ''
                                : '${state.weekendDaysPrice?.toInt()}';
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            BlocBuilder<ImageManagementCubit,
                                ImageManagementState>(
                              builder: (context, state) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    !hasAttachment
                                        ? InkWell(
                                            onTap: () async {
                                              await _pickImage();
                                              if (_image.isNotEmpty) {
                                                imageManagementCubit
                                                    .addMainAttachment(
                                                        _image.first);
                                                setState(() {
                                                  hasAttachment = true;
                                                });
                                              }
                                            },
                                            child: SizedBox(
                                              width: 150,
                                              height: 150,
                                              child: DecoratedBox(
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                    color: Colors.black,
                                                    width: 1,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                ),
                                                child: const Center(
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Icon(
                                                        Icons
                                                            .add_photo_alternate_outlined,
                                                        size: 35,
                                                      ),
                                                      Text('Main Attachment')
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          )
                                        : Stack(
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                child: AssetThumb(
                                                  asset: imageManagementCubit
                                                      .state
                                                      .mainAttachmentList
                                                      .first,
                                                  width: 150,
                                                  height: 150,
                                                ),
                                              ),
                                              Positioned(
                                                top: -10,
                                                right: -10,
                                                child: IconButton(
                                                  icon: const Icon(
                                                    Icons.cancel_rounded,
                                                    color: Colors.red,
                                                    size: 30,
                                                  ),
                                                  onPressed: () {
                                                    setState(() {
                                                      imageManagementCubit
                                                          .removeMainAttachment(
                                                              0);
                                                      if (imageManagementCubit
                                                          .state
                                                          .mainAttachmentList
                                                          .isEmpty) {
                                                        _images.clear();
                                                        hasAttachment = false;
                                                      }
                                                    });
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                    const SizedBox(height: 20),
                                    GridView.builder(
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 4,
                                        crossAxisSpacing: 4.0,
                                        mainAxisSpacing: 4.0,
                                      ),
                                      shrinkWrap: true,
                                      itemCount: imageManagementCubit
                                                  .state.images.length <
                                              10
                                          ? imageManagementCubit
                                                  .state.images.length +
                                              1
                                          : 10,
                                      itemBuilder: (context, index) {
                                        if (index <
                                            imageManagementCubit
                                                .state.images.length) {
                                          return Stack(
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                child: AssetThumb(
                                                  asset: imageManagementCubit
                                                      .state.images[index],
                                                  width: 150,
                                                  height: 150,
                                                ),
                                              ),
                                              Positioned(
                                                top: -10,
                                                right: -10,
                                                child: IconButton(
                                                  icon: const Icon(
                                                    Icons.cancel_rounded,
                                                    color: Colors.red,
                                                    size: 30,
                                                  ),
                                                  onPressed: () {
                                                    setState(() {
                                                      imageManagementCubit
                                                          .removeImage(index);
                                                      _images.removeAt(index);
                                                    });
                                                  },
                                                ),
                                              ),
                                            ],
                                          );
                                        } else {
                                          return InkWell(
                                            onTap: () async {
                                              await _pickImages();
                                              imageManagementCubit
                                                  .addImage(_images);
                                            },
                                            child: SizedBox(
                                              width: 150,
                                              height: 150,
                                              child: DecoratedBox(
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                    color: Colors.black,
                                                    width: 1,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                ),
                                                child: const Center(
                                                  child: Icon(
                                                    Icons
                                                        .add_photo_alternate_outlined,
                                                    size: 35,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        }
                                      },
                                    ),
                                  ],
                                );
                              },
                            ),
                            const SizedBox(height: 20.0),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const MapScreen()),
                                );
                              },
                              child: Container(
                                width: 200,
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CustomText(
                                      text: 'Select Location',
                                      color: Colors.black87,
                                      weight: FontWeight.w500,
                                    ),
                                    Icon(
                                      Icons.location_on,
                                      color: Colors.red,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 20.0),
                            CustomTextField(
                              controller: nameController,
                              labelText: 'Cottage Name',
                              onChanged: (value) {
                                cottageCubit.updateName(value);
                              },
                              fontSize: 16.0,
                              maxLines: 1,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter cottage name';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 20.0),
                            CustomTextField(
                              controller: weekdayController,
                              labelText: 'Weekday Price',
                              isNumber: true,
                              onChanged: (value) {
                                cottageCubit
                                    .updateWeekdayPrice(double.parse(value));
                              },
                              fontSize: 14.0,
                              maxLines: 1,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter description';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 20.0),
                            CustomTextField(
                              controller: weekendController,
                              labelText: 'Weekend Price',
                              fontSize: 14.0,
                              isNumber: true,
                              maxLines: 1,
                              onChanged: (value) {
                                cottageCubit
                                    .updateWeekendPrice(double.parse(value));
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter description';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 20.0),
                            CustomTextField(
                              controller: descController,
                              labelText: 'Description',
                              fontSize: 14.0,
                              maxLines: 10,
                              onChanged: (value) {
                                cottageCubit.updateDescription(value);
                              },
                              isMaxLength: true,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter description';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 20.0),
                            CustomTextField(
                              controller: guestController,
                              labelText: 'Max guests',
                              fontSize: 14.0,
                              isNumber: true,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter description';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 20.0),
                            CustomTextField(
                              controller: totalRoomsController,
                              labelText: 'Total Rooms',
                              onChanged: (value) {
                                cottageCubit
                                    .updateWeekdayPrice(double.parse(value));
                              },
                              isNumber: true,
                              fontSize: 14.0,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter description';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 20),
                            const CustomText(text: 'Additional Equipments'),
                            const SizedBox(height: 20),
                            BlocBuilder<EquipmentBloc, EquipmentState>(
                              builder: (context, state) {
                                if (state is EquipmentLoaded) {
                                  return ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: allItems != null
                                        ? allItems.length
                                        : state.items.length,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      final item = allItems != null
                                          ? allItems[index]
                                          : state.items[index];
                                      return Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Checkbox(
                                            visualDensity:
                                                VisualDensity.compact,
                                            value: item.isChecked,
                                            activeColor: mainColor,
                                            onChanged: (value) {
                                              BlocProvider.of<EquipmentBloc>(
                                                      context)
                                                  .add(ToggleItemEvent(
                                                      item.name));
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
                            const SizedBox(height: 20.0),
                            Container(
                              width: double.infinity,
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: ElevatedButton(
                                onPressed: () async {
                                  CustomSnackBar(backgroundColor: Colors.amber)
                                      .showError(
                                    context,
                                    "Loading...",
                                  );
                                  var user =
                                      await authenticationCubit.getUser();
                                  // ignore: use_build_context_synchronously
                                  await cottageCubit.addCottage(
                                      Cottage(
                                        name: state.name,
                                        description: state.description,
                                        weekDaysPrice: state.weekDaysPrice,
                                        weekendDaysPrice:
                                            state.weekendDaysPrice,
                                        guestCount: state.guestCount,
                                        totalRoomCount: state.totalRoomCount,
                                        latitude: state.latitude,
                                        longitude: state.longitude,
                                        equipmentsList:
                                            equipmentBloc.getCheckedItems(),
                                      ),
                                      user.id!,
                                      imageManagementCubit.state.images,
                                      imageManagementCubit
                                          .state.mainAttachmentList,
                                      context);
                                },
                                style: ElevatedButton.styleFrom(
                                  foregroundColor: Colors.white,
                                  backgroundColor: mainColor,
                                  padding: const EdgeInsets.all(16),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: const Text(
                                  "Save",
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20.0),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }
  }
}

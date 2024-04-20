import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:oasis_uz_mobile/bloc/cottageCubit/cottage_cubit.dart';
import 'package:oasis_uz_mobile/constants/app_color.dart';
import 'package:oasis_uz_mobile/widgets/custom_text.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController mapController;

  final LatLng _center = const LatLng(41.311081, 69.240562);
  LatLng? _selectedLatLng;

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void _onMapTap(LatLng latLng) {
    setState(() {
      _selectedLatLng = latLng;
    });
  }

  @override
  Widget build(BuildContext context) {
    var cottageCubit = BlocProvider.of<CottageCubit>(context);

    return Scaffold(
      appBar: AppBar(
        title: const CustomText(
          text: 'Select Location',
          weight: FontWeight.bold,
          size: 18,
        ),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: GoogleMap(
              onMapCreated: _onMapCreated,
              onTap: _onMapTap,
              scrollGesturesEnabled: true,
              zoomControlsEnabled: false,
              myLocationEnabled: true,
              initialCameraPosition: CameraPosition(
                target: (cottageCubit.state.latitude != null &&
                        cottageCubit.state.longitude != null)
                    ? LatLng(cottageCubit.state.latitude!,
                        cottageCubit.state.longitude!)
                    : _center,
                zoom: 11.0,
              ),
              markers: _selectedLatLng != null
                  ? {
                      Marker(
                        markerId: const MarkerId('selected_location'),
                        position: _selectedLatLng!,
                        infoWindow: InfoWindow(
                          title: 'Selected Location',
                          snippet:
                              'Lat: ${_selectedLatLng!.latitude}, Lng: ${_selectedLatLng!.longitude}',
                        ),
                      ),
                    }
                  : (cottageCubit.state.latitude != null &&
                          cottageCubit.state.longitude != null)
                      ? {
                          Marker(
                            markerId: const MarkerId('selected_location'),
                            position: LatLng(cottageCubit.state.latitude!,
                                cottageCubit.state.longitude!),
                            infoWindow: InfoWindow(
                              title: 'Selected Location',
                              snippet:
                                  'Lat: ${cottageCubit.state.latitude}, Lng: ${cottageCubit.state.longitude}',
                            ),
                          )
                        }
                      : {},
            ),
          ),
        ],
      ),
      floatingActionButton: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: mainColor,
        ),
        onPressed: () {
          if (_selectedLatLng != null) {
            cottageCubit.updateLatitude(_selectedLatLng!.latitude);
            cottageCubit.updateLongitude(_selectedLatLng!.longitude);
            Navigator.pop(context, _selectedLatLng);
          } else {
            Navigator.pop(context, _selectedLatLng);
          }
        },
        child: const CustomText(
          text: 'Save',
          color: Colors.white,
        ),
      ),
    );
  }
}

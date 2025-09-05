import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import '../../../core/network/api_client.dart';

class MapView extends StatefulWidget {
  const MapView({super.key});

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  Location locationController = new Location();

  final Completer<GoogleMapController> mapController =
      Completer<GoogleMapController>();

  static const LatLng sourceLocation = LatLng(19.0414, -98.2063);
  static const LatLng destination = LatLng(19.0021, -98.2060);

  LatLng? currentP;

  @override
  void initState() {
    super.initState();
    getLocationUpdates(locationController);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: currentP == null
          ? const Center(child: Text("Loading..."))
          : GoogleMap(
              onMapCreated: (GoogleMapController controller) =>
                  mapController.complete(controller),
              initialCameraPosition: CameraPosition(
                target: sourceLocation,
                zoom: 15,
                tilt: 60.0,
              ),
              markers: {
                Marker(
                  markerId: MarkerId("currentLocation"),
                  icon: BitmapDescriptor.defaultMarker,
                  position: currentP!,
                ),
                Marker(
                  markerId: MarkerId("sourceLocation"),
                  icon: BitmapDescriptor.defaultMarker,
                  position: sourceLocation,
                ),
                Marker(
                  markerId: MarkerId("destinationLocation"),
                  icon: BitmapDescriptor.defaultMarker,
                  position: destination,
                ),
              },
            ),
    );
  }

  Future<void> cameraToPostion(LatLng pos) async {
    final GoogleMapController controller = await mapController.future;
    CameraPosition newCameraPosition = CameraPosition(target: pos, zoom: 16);
    await controller.animateCamera(
      CameraUpdate.newCameraPosition(newCameraPosition),
    );
  }

  Future<void> getLocationUpdates(Location controller) async {
    bool serviceEnabled;
    PermissionStatus permissionGranted;

    serviceEnabled = await controller.serviceEnabled();

    if (serviceEnabled) {
      serviceEnabled = await controller.requestService();
    } else {
      return;
    }

    permissionGranted = await controller.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await controller.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    controller.onLocationChanged.listen((LocationData currentLocation) {
      if (currentLocation.latitude != null &&
          currentLocation.longitude != null) {
        setState(() {
          currentP = LatLng(
            currentLocation.latitude!,
            currentLocation.longitude!,
          );
          cameraToPostion(currentP!);
        });
      }
    });
  }
}

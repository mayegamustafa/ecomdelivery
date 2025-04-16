import 'dart:async';

import 'package:delivery_boy/main.export.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart' as geo;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class AddressMapView extends StatefulWidget {
  const AddressMapView({super.key, this.onLocationSelect, this.latLng});

  final Function(LatLng? latLng, String? address, String? cc)? onLocationSelect;
  final LatLng? latLng;

  @override
  State<AddressMapView> createState() => AddressMapViewState();
}

class AddressMapViewState extends State<AddressMapView> {
  bool btLoad = false;
  bool mkLoad = false;
  String? country;
  LatLng? current;

  final markerId = const MarkerId('self');
  final customerMarker = const MarkerId('customer');

  final txCtrl = TextEditingController();

  final _controller = Completer<GoogleMapController>();

  @override
  void dispose() {
    txCtrl.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    current = widget.latLng;
    getLocation();
  }

  Future<void> getLocation() async {
    if (widget.latLng != null) {
      current = widget.latLng;
      await getAddressString(current!);
      if (mounted) setState(() {});
      await animateToCurrent();
      return;
    }
    final location = Location();

    bool service;
    PermissionStatus permission;
    LocationData loc;

    service = await location.serviceEnabled();
    if (!service) {
      service = await location.requestService();
      if (!service) {
        Toaster.showError('tr.msg.no_location');
        return;
      }
    }

    permission = await location.hasPermission();
    if (permission == PermissionStatus.denied) {
      permission = await location.requestPermission();
      if (permission != PermissionStatus.granted) {
        Toaster.showError('tr.msg.no_loc_permission');
        return;
      }
    }

    loc = await location.getLocation();
    final latLng = LatLng(loc.latitude!, loc.longitude!);
    current = latLng;
    await getAddressString(latLng);
    if (mounted) setState(() {});
    await animateToCurrent();
  }

  getAddressString(LatLng latlng) async {
    final LatLng(:latitude, :longitude) = latlng;
    final place = await geo.placemarkFromCoordinates(latitude, longitude);

    final loc = place.firstOrNull;

    if (loc == null) return;

    txCtrl.text =
        '${loc.street}, ${loc.subLocality}, ${loc.locality}, ${loc.country}';

    country = loc.isoCountryCode;
  }

  Future<void> searchAddress() async {
    final place = await geo.locationFromAddress(txCtrl.text);
    final loc = place.firstOrNull;
    if (loc == null) return;
    Logger.json(place.map((e) => e.toJson()).toList());
    current = LatLng(loc.latitude, loc.longitude);
    setState(() {});
    await animateToCurrent();
  }

  Future<void> animateToCurrent() async {
    if (current == null) return;
    final ctrl = await _controller.future;
    CameraUpdate update = CameraUpdate.newCameraPosition(
      CameraPosition(target: current!, zoom: 14),
    );

    // if (widget.latLng != null) {
    //   final bounds =
    //       LatLngBounds(southwest: widget.latLng!, northeast: current!);
    //   update = CameraUpdate.newLatLngBounds(bounds, 10);
    // }

    ctrl.animateCamera(update);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(TR.of(context).selectLocation),
        leading: IconButton.filled(
          style: IconButton.styleFrom(
            foregroundColor: context.colorTheme.surfaceBright,
            backgroundColor: context.colorTheme.surfaceBright.withOpacity(.05),
          ),
          onPressed: () {
            widget.onLocationSelect?.call(current, txCtrl.text, country);
            context.nPop();
          },
          icon: const Icon(Icons.done_rounded),
        ),
        actions: [
          IconButton.filled(
            style: IconButton.styleFrom(
              foregroundColor: context.colorTheme.surfaceBright,
              backgroundColor:
                  context.colorTheme.surfaceBright.withOpacity(.05),
            ),
            onPressed: () => context.nPop(),
            icon: const Icon(Icons.close_rounded),
          ),
        ],
      ),
      body: Column(
        children: [
          if (current == null)
            const Expanded(child: Center(child: CircularProgressIndicator()))
          else
            Expanded(
              child: GoogleMap(
                mapType: MapType.normal,
                initialCameraPosition:
                    CameraPosition(target: current!, zoom: 14),
                onMapCreated: (controller) {
                  _controller.complete(controller);
                },
                onTap: (latLng) {
                  if (widget.latLng != null) return;
                  current = latLng;
                  getAddressString(latLng);
                  setState(() {});
                },
                markers: {
                  Marker(
                    markerId: markerId,
                    position: current!,
                    flat: true,
                    draggable: true,
                    onDragEnd: (value) => setState(() {
                      current = value;
                      getAddressString(value);
                    }),
                  ),
                },
              ),
            ),
          Container(
            color: context.colorTheme.surface,
            padding: Insets.padAll,
            width: context.width,
            child: Row(
              children: [
                Flexible(
                  child: TextField(
                    enabled: widget.latLng == null,
                    controller: txCtrl,
                    maxLines: null,
                    decoration: InputDecoration(
                      alignLabelWithHint: true,
                      suffixIcon: widget.latLng != null
                          ? null
                          : IconButton(
                              onPressed: () => searchAddress(),
                              icon: const Icon(Icons.search_rounded),
                            ),
                    ),
                  ),
                ),
                const Gap(Insets.med),
                IconButton.filled(
                  onPressed: () async {
                    setState(() => btLoad = true);
                    await getLocation();
                    setState(() => btLoad = false);
                  },
                  icon: btLoad
                      ? SizedBox.square(
                          dimension: 24,
                          child: CircularProgressIndicator(
                            color: context.colorTheme.onPrimary,
                            strokeWidth: 2,
                          ),
                        )
                      : const Icon(Icons.location_on),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

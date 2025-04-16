import 'package:delivery_boy/main.export.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class OrderMap extends HookConsumerWidget {
  const OrderMap({
    super.key,
    required this.destination,
    this.address,
    this.height,
  });

  final String? address;
  final double? height;
  final LatLng? destination;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mapController = useState<GoogleMapController?>(null);
    final markers = useState<Set<Marker>>({});
    final polylines = useState<Set<Polyline>>({});
    final currentLoc = useState<LatLng?>(null);

    Future<LocationData> currentLocation() async {
      final locationService = Location();
      return await locationService.getLocation();
    }

    void setMarkers() {
      if (currentLoc.value == null) return;

      markers.value = {
        Marker(
          markerId: const MarkerId('self'),
          position: currentLoc.value!,
          infoWindow: const InfoWindow(
            title: 'Start Point',
            snippet: 'Your current location',
          ),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        ),
        if (destination.isNotNullOrEmpty())
          Marker(
            markerId: const MarkerId('destination'),
            position: destination!,
            infoWindow: InfoWindow(
              title: 'Destination',
              snippet: address,
            ),
            icon:
                BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
          ),
      };
    }

    void setPolyLines() {
      if (currentLoc.value == null) return;
      if (destination == null) return;

      polylines.value = {
        Polyline(
          polylineId: const PolylineId('route'),
          points: [currentLoc.value!, destination!],
          color: context.colorTheme.primary,
          width: 5,
        ),
      };
    }

    Future<void> initMap() async {
      final loc = await currentLocation();
      final latLng = LatLng(loc.latitude!, loc.longitude!);
      currentLoc.value = latLng;

      setMarkers();
      setPolyLines();
    }

    useEffect(
      () {
        initMap();

        return null;
      },
      [mapController.value],
    );

    void onMapCreated(GoogleMapController controller) {
      mapController.value = controller;
      var bounds = _bounds(markers.value);
      if (bounds == null) return;
      mapController.value
          ?.animateCamera(CameraUpdate.newLatLngBounds(bounds, 50));
    }

    return ClipRRect(
      borderRadius: Corners.lgBorder,
      child: SizedBox(
        height: height ?? context.height / 5,
        child: currentLoc.value == null
            ? const Center(child: CircularProgressIndicator())
            : GoogleMap(
                onMapCreated: onMapCreated,
                initialCameraPosition: CameraPosition(
                  target: currentLoc.value!,
                  zoom: 14.0,
                ),
                markers: markers.value,
                polylines: polylines.value,
              ),
      ),
    );
  }
}

LatLngBounds? _bounds(Set<Marker> markers) {
  if (markers.isEmpty) return null;
  return _createBounds(markers.map((m) => m.position).toList());
}

LatLngBounds _createBounds(List<LatLng> positions) {
  final southwestLat = positions.map((p) => p.latitude).reduce(
      (value, element) => value < element ? value : element); // smallest
  final southwestLon = positions
      .map((p) => p.longitude)
      .reduce((value, element) => value < element ? value : element);
  final northeastLat = positions
      .map((p) => p.latitude)
      .reduce((value, element) => value > element ? value : element); // biggest
  final northeastLon = positions
      .map((p) => p.longitude)
      .reduce((value, element) => value > element ? value : element);
  return LatLngBounds(
    southwest: LatLng(southwestLat, southwestLon),
    northeast: LatLng(northeastLat, northeastLon),
  );
}

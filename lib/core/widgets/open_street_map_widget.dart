import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class OpenStreetMapWidget extends StatefulWidget {
  final LatLng? initialCenter;
  final double initialZoom;
  final Function(LatLng)? onTap;

  const OpenStreetMapWidget({
    super.key,
    this.initialCenter,
    this.initialZoom = 13.0,
    this.onTap,
  });

  @override
  State<OpenStreetMapWidget> createState() => _OpenStreetMapWidgetState();
}

class _OpenStreetMapWidgetState extends State<OpenStreetMapWidget> {
  late MapController mapController;
  LatLng? currentCenter;

  @override
  void initState() {
    super.initState();
    mapController = MapController();
    currentCenter = widget.initialCenter ??
        const LatLng(9.9312, 76.2673); // Kochi coordinates
  }

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      mapController: mapController,
      options: MapOptions(
        initialCenter: currentCenter ?? const LatLng(9.9312, 76.2673),
        initialZoom: widget.initialZoom,
        onTap: (tapPosition, point) {
          widget.onTap?.call(point);
        },
      ),
      children: [
        // OpenStreetMap Tile Layer
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'com.example.goatscave',
        ),
        // You can add more layers like markers, polylines here
      ],
    );
  }
}

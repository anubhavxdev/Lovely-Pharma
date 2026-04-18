import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:lovely_pharma/utils/constants.dart';

class TrackingScreen extends StatefulWidget {
  final String orderId;

  const TrackingScreen({super.key, required this.orderId});

  @override
  State<TrackingScreen> createState() => _TrackingScreenState();
}

class _TrackingScreenState extends State<TrackingScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  // Mock Route (Lovely Professional University roughly)
  final List<LatLng> _routeCoords = [
    const LatLng(31.2500, 75.7000), // Pharmacy
    const LatLng(31.2515, 75.7015),
    const LatLng(31.2530, 75.7020),
    const LatLng(31.2540, 75.7035),
    const LatLng(31.2550, 75.7050), // Hostel
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 45), // Reaching in 45 seconds visually
    )..forward();

    _animation = Tween<double>(begin: 0, end: (_routeCoords.length - 1).toDouble()).animate(_animationController)
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  LatLng _getCurrentBikePosition() {
    double value = _animation.value;
    int index = value.floor();
    if (index >= _routeCoords.length - 1) return _routeCoords.last;

    LatLng p1 = _routeCoords[index];
    LatLng p2 = _routeCoords[index + 1];
    double fraction = value - index;

    // Linearly interpolate between points
    double lat = p1.latitude + (p2.latitude - p1.latitude) * fraction;
    double lng = p1.longitude + (p2.longitude - p1.longitude) * fraction;
    return LatLng(lat, lng);
  }

  @override
  Widget build(BuildContext context) {
    bool isArrived = _animation.isCompleted;

    return Scaffold(
      body: Stack(
        children: [
          // Flutter Map
          FlutterMap(
            options: const MapOptions(
              initialCenter: LatLng(31.2525, 75.7025), // Map Center
              initialZoom: 15.0,
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.lovelypharma.app',
              ),
              PolylineLayer(
                polylines: [
                  Polyline(
                    points: _routeCoords,
                    strokeWidth: 4.0,
                    color: AppColors.primary,
                  ),
                ],
              ),
              MarkerLayer(
                markers: [
                  Marker(
                    width: 50.0,
                    height: 50.0,
                    point: _routeCoords.first, // Pharmacy
                    child: const Icon(Icons.maps_home_work, color: Colors.blue, size: 40),
                  ),
                  Marker(
                    width: 50.0,
                    height: 50.0,
                    point: _routeCoords.last, // Hostel
                    child: const Icon(Icons.location_on, color: Colors.red, size: 40),
                  ),
                  Marker(
                    width: 40.0,
                    height: 40.0,
                    point: _getCurrentBikePosition(), // Moving Bike
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 4)],
                      ),
                      child: const Icon(Icons.electric_moped, color: AppColors.primary, size: 24),
                    ),
                  ),
                ],
              ),
            ],
          ),

          // Safe Area App Bar
          Positioned(
            top: 50,
            left: 20,
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle, boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)]),
                child: const Icon(Icons.arrow_back),
              ),
            ),
          ),

          // Live Tracking Bottom Sheet Status Overlay
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 20, offset: Offset(0, -5))],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(child: Container(width: 40, height: 4, decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(2)))),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(isArrived ? 'Arrived!' : 'Out for Delivery', style: AppTextStyles.heading),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(color: isArrived ? AppColors.accent.withOpacity(0.1) : AppColors.primary.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
                        child: Text(isArrived ? 'COMPLETED' : '10 MINS', style: TextStyle(color: isArrived ? AppColors.accent : AppColors.primary, fontWeight: FontWeight.bold)),
                      )
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text('Order #${widget.orderId}', style: AppTextStyles.body.copyWith(color: Colors.grey)),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      const CircleAvatar(radius: 24, backgroundColor: AppColors.primary, child: Icon(Icons.person, color: Colors.white)),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Ramesh Kumar', style: AppTextStyles.subheading),
                            Text('Delivery Partner', style: AppTextStyles.body.copyWith(fontSize: 12, color: Colors.grey)),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(color: Colors.green.shade50, shape: BoxShape.circle),
                        child: const Icon(Icons.call, color: Colors.green),
                      )
                    ],
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

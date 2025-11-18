import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';

class CameraWithWatermark extends StatefulWidget {
  final CameraDescription camera;
  final Map<String, dynamic> locationData;

  const CameraWithWatermark({
    Key? key,
    required this.camera,
    required this.locationData,
  }) : super(key: key);

  @override
  State<CameraWithWatermark> createState() => _CameraWithWatermarkState();
}

class _CameraWithWatermarkState extends State<CameraWithWatermark> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  late Map<String, dynamic> _currentLocationData;
  bool _refreshing = false;

  @override
  void initState() {
    super.initState();
    _controller = CameraController(
      widget.camera,
      ResolutionPreset.high,
    );
    _initializeControllerFuture = _controller.initialize();
    _currentLocationData = Map<String, dynamic>.from(widget.locationData);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _refreshLocation() async {
    try {
      setState(() => _refreshing = true);

      Position pos = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      String address = _currentLocationData['address'] ?? 'Address not available';

      try {
        List<Placemark> places = await placemarkFromCoordinates(
          pos.latitude,
          pos.longitude,
        );

        if (places.isNotEmpty) {
          final p = places.first;
          address =
              '${p.street ?? ''}, ${p.subLocality ?? ''}, ${p.locality ?? ''}, '
              '${p.administrativeArea ?? ''}, ${p.postalCode ?? ''}, ${p.country ?? ''}'
                  .replaceAll(RegExp(r',\s*,'), ',')
                  .replaceAll(RegExp(r'^,\s*'), '')
                  .replaceAll(RegExp(r',\s*$'), '')
                  .trim();
        }
      } catch (e) {
        address =
            'Lat: ${pos.latitude.toStringAsFixed(6)}, Long: ${pos.longitude.toStringAsFixed(6)}';
      }

      DateTime now = DateTime.now();

      setState(() {
        _currentLocationData = {
          'latitude': pos.latitude,
          'longitude': pos.longitude,
          'address': address,
          'timestamp': DateFormat('dd-MM-yyyy HH:mm:ss').format(now),
          'raw_timestamp': now.toIso8601String(),
        };
        _refreshing = false;
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Location refreshed'),
            duration: Duration(seconds: 1),
          ),
        );
      }
    } catch (e) {
      setState(() => _refreshing = false);

      debugPrint('Failed to refresh location: $e');

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to refresh location: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _takePicture() async {
    try {
      await _initializeControllerFuture;
      final image = await _controller.takePicture();

      if (mounted) {
        Navigator.pop(context, {
          'image': image,
          'locationData': _currentLocationData,
        });
      }
    } catch (e) {
      debugPrint('Error taking picture: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Stack(
              children: [
                Positioned.fill(
                  child: CameraPreview(_controller),
                ),
                Positioned(
                  left: 16,
                  right: 16,
                  bottom: 120,
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _buildWatermarkRow(
                          Icons.calendar_today,
                          'Date & Time',
                          _currentLocationData['timestamp'] ?? '',
                        ),
                        const Divider(color: Colors.white24, height: 16),
                        _buildWatermarkRow(
                          Icons.my_location,
                          'Latitude',
                          _currentLocationData['latitude'] != null
                              ? _currentLocationData['latitude'].toStringAsFixed(6)
                              : '',
                        ),
                        const Divider(color: Colors.white24, height: 16),
                        _buildWatermarkRow(
                          Icons.location_on,
                          'Longitude',
                          _currentLocationData['longitude'] != null
                              ? _currentLocationData['longitude'].toStringAsFixed(6)
                              : '',
                        ),
                        const Divider(color: Colors.white24, height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: _buildWatermarkRow(
                                Icons.home,
                                'Address',
                                _currentLocationData['address'] ?? '',
                              ),
                            ),
                            IconButton(
                              onPressed: _refreshing ? null : _refreshLocation,
                              icon: _refreshing
                                  ? const SizedBox(
                                      width: 18,
                                      height: 18,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        color: Colors.red,
                                      ),
                                    )
                                  : const Icon(Icons.refresh, color: Colors.red),
                              tooltip: 'Refresh location',
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 40,
                  left: 16,
                  child: IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close, color: Colors.white, size: 32),
                  ),
                ),
                Positioned(
                  bottom: 30,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: GestureDetector(
                      onTap: _takePicture,
                      child: Container(
                        width: 70,
                        height: 70,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 4),
                        ),
                        child: Container(
                          margin: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(color: Colors.white),
            );
          }
        },
      ),
    );
  }

  Widget _buildWatermarkRow(IconData icon, String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: Colors.white, size: 18),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}


// import 'dart:async';
// import 'dart:io';
// import 'dart:typed_data';
// import 'dart:ui' as ui;

// import 'package:camera/camera.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_exif_rotation/flutter_exif_rotation.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:intl/intl.dart';

// class CameraWithWatermark extends StatefulWidget {
//   final List<CameraDescription> cameras;
//   final int initialCameraIndex;
//   final Map<String, dynamic> locationData;

//   const CameraWithWatermark({
//     super.key,
//     required this.cameras,
//     required this.initialCameraIndex,
//     required this.locationData,
//   });

//   @override
//   State<CameraWithWatermark> createState() => _CameraWithWatermarkState();
// }

// class _CameraWithWatermarkState extends State<CameraWithWatermark> {
//   CameraController? _controller;
//   Future<void>? _initializeControllerFuture;
//   late Map<String, dynamic> _currentLocationData;
//   bool _refreshing = false;
//   late int _selectedCameraIndex;

//   @override
//   void initState() {
//     super.initState();
//     _currentLocationData = Map<String, dynamic>.from(widget.locationData);
//     _selectedCameraIndex = widget.initialCameraIndex;
//     _initCamera(_selectedCameraIndex);
//   }

//   Future<void> _initCamera(int index) async {
//     final previousController = _controller;

//     _controller = CameraController(
//       widget.cameras[index],
//       ResolutionPreset.high,
//       enableAudio: false,
//     );

//     _initializeControllerFuture = _controller!.initialize();

//     setState(() {}); // rebuild FutureBuilder with new future

//     // Dispose old controller after switching to avoid conflicts
//     await previousController?.dispose();
//   }

//   @override
//   void dispose() {
//     _controller?.dispose();
//     super.dispose();
//   }

//   Future<void> _switchCamera() async {
//     if (widget.cameras.length < 2) {
//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('No other camera available')),
//         );
//       }
//       return;
//     }

//     final newIndex = (_selectedCameraIndex + 1) % widget.cameras.length;
//     _selectedCameraIndex = newIndex;
//     await _initCamera(newIndex);
//   }

//   Future<void> _refreshLocation() async {
//     try {
//       setState(() => _refreshing = true);

//       Position pos = await Geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy.high,
//       );

//       String address = _currentLocationData['address'] ?? 'Address not available';

//       try {
//         List<Placemark> places = await placemarkFromCoordinates(
//           pos.latitude,
//           pos.longitude,
//         );

//         if (places.isNotEmpty) {
//           final p = places.first;
//           address =
//               '${p.street ?? ''}, ${p.subLocality ?? ''}, ${p.locality ?? ''}, '
//               '${p.administrativeArea ?? ''}, ${p.postalCode ?? ''}, ${p.country ?? ''}'
//                   .replaceAll(RegExp(r',\s*,'), ',')
//                   .replaceAll(RegExp(r'^,\s*'), '')
//                   .replaceAll(RegExp(r',\s*$'), '')
//                   .trim();
//         }
//       } catch (e) {
//         address =
//             'Lat: ${pos.latitude.toStringAsFixed(6)}, Long: ${pos.longitude.toStringAsFixed(6)}';
//       }

//       DateTime now = DateTime.now();

//       setState(() {
//         _currentLocationData = {
//           'latitude': pos.latitude,
//           'longitude': pos.longitude,
//           'address': address,
//           'timestamp': DateFormat('dd-MM-yyyy HH:mm:ss').format(now),
//           'raw_timestamp': now.toIso8601String(),
//         };
//         _refreshing = false;
//       });

//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(
//             content: Text('Location refreshed'),
//             duration: Duration(seconds: 1),
//           ),
//         );
//       }
//     } catch (e) {
//       setState(() => _refreshing = false);

//       debugPrint('Failed to refresh location: $e');

//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text('Failed to refresh location: $e'),
//             backgroundColor: Colors.red,
//           ),
//         );
//       }
//     }
//   }

//   // Utility: decode bytes to get width & height using dart:ui
//   Future<Map<String, int>> _getImageDimensions(File f) async {
//     try {
//       final Uint8List bytes = await f.readAsBytes();
//       final codec = await ui.instantiateImageCodec(bytes);
//       final frame = await codec.getNextFrame();
//       return { 'width': frame.image.width, 'height': frame.image.height };
//     } catch (e) {
//       debugPrint('Failed to decode image for dimensions: $e');
//       return { 'width': 0, 'height': 0 };
//     }
//   }

//   // The improved takePicture: rotate pixels using flutter_exif_rotation,
//   // then return the rotated XFile. Also logs raw & final dimensions & inferred orientation.
//   Future<void> _takePicture() async {
//     try {
//       if (_initializeControllerFuture == null || _controller == null) return;

//       await _initializeControllerFuture!;
//       final XFile rawXfile = await _controller!.takePicture();

//       final File rawFile = File(rawXfile.path);

//       // Get raw image dimensions (before fix)
//       final rawDims = await _getImageDimensions(rawFile);
//       final rawW = rawDims['width'] ?? 0;
//       final rawH = rawDims['height'] ?? 0;

//       debugPrint('📸 RAW IMAGE INFO:');
//       debugPrint('Path: ${rawFile.path}');
//       debugPrint('Raw Width: $rawW');
//       debugPrint('Raw Height: $rawH');

//       // Rotate pixel data according to EXIF. This returns a new File path (or same if already normal).
//       File rotatedFile;
//       try {
//         rotatedFile = await FlutterExifRotation.rotateImage(path: rawFile.path);
//       } catch (e) {
//         debugPrint('Exif rotation failed, falling back to raw file: $e');
//         rotatedFile = rawFile;
//       }

//       // Get rotated image dimensions
//       final rotatedDims = await _getImageDimensions(rotatedFile);
//       final rotatedW = rotatedDims['width'] ?? 0;
//       final rotatedH = rotatedDims['height'] ?? 0;

//       debugPrint('📸 ROTATED (FINAL) IMAGE INFO:');
//       debugPrint('Path: ${rotatedFile.path}');
//       debugPrint('Final Width: $rotatedW');
//       debugPrint('Final Height: $rotatedH');

//       // Inferred orientation message: compare raw and final dims to guess what happened.
//       String inferred;
//       if (rawW == rotatedW && rawH == rotatedH) {
//         inferred = 'No rotation applied (pixels already upright).';
//       } else if (rawW == rotatedH && rawH == rotatedW) {
//         // swapped width/height -> rotated 90
//         // Determine direction by checking camera sensor orientation is not available here, so use generic.
//         inferred = 'Rotated 90 degrees (EXIF corrected).';
//       } else {
//         inferred = 'Image dimensions changed (EXIF correction or re-encode).';
//       }
//       debugPrint('📸 INFERENCE: $inferred');

//       // Build XFile from rotated path to keep same return type the rest of app expects
//       final XFile finalXfile = XFile(rotatedFile.path);

//       if (mounted) {
//         Navigator.pop(context, {
//           'image': finalXfile,
//           'locationData': _currentLocationData,
//         });
//       }
//     } catch (e, st) {
//       debugPrint('Error taking picture: $e\n$st');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: (_initializeControllerFuture == null || _controller == null)
//           ? const Center(
//               child: CircularProgressIndicator(color: Colors.white),
//             )
//           : FutureBuilder<void>(
//               future: _initializeControllerFuture,
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.done) {
//                   return Stack(
//                     children: [
//                       Positioned.fill(
//                         child: CameraPreview(_controller!),
//                       ),

//                       // Top bar: Close + Switch camera
//                       Positioned(
//                         top: 40,
//                         left: 16,
//                         right: 16,
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             IconButton(
//                               onPressed: () => Navigator.pop(context),
//                               icon: const Icon(
//                                 Icons.close,
//                                 color: Colors.white,
//                                 size: 32,
//                               ),
//                             ),
//                             IconButton(
//                               onPressed: _switchCamera,
//                               icon: const Icon(
//                                 Icons.cameraswitch,
//                                 color: Colors.white,
//                                 size: 32,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),

//                       // Watermark card
//                       Positioned(
//                         left: 16,
//                         right: 16,
//                         bottom: 120,
//                         child: Container(
//                           padding: const EdgeInsets.all(12),
//                           decoration: BoxDecoration(
//                             color: Colors.black.withOpacity(0.7),
//                             borderRadius: BorderRadius.circular(8),
//                           ),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             mainAxisSize: MainAxisSize.min,
//                             children: [
//                               _buildWatermarkRow(
//                                 Icons.calendar_today,
//                                 'Date & Time',
//                                 _currentLocationData['timestamp'] ?? '',
//                               ),
//                               const Divider(color: Colors.white24, height: 16),
//                               _buildWatermarkRow(
//                                 Icons.my_location,
//                                 'Latitude',
//                                 _currentLocationData['latitude'] != null
//                                     ? _currentLocationData['latitude']
//                                         .toStringAsFixed(6)
//                                     : '',
//                               ),
//                               const Divider(color: Colors.white24, height: 16),
//                               _buildWatermarkRow(
//                                 Icons.location_on,
//                                 'Longitude',
//                                 _currentLocationData['longitude'] != null
//                                     ? _currentLocationData['longitude']
//                                         .toStringAsFixed(6)
//                                     : '',
//                               ),
//                               const Divider(color: Colors.white24, height: 16),
//                               Row(
//                                 children: [
//                                   Expanded(
//                                     child: _buildWatermarkRow(
//                                       Icons.home,
//                                       'Address',
//                                       _currentLocationData['address'] ?? '',
//                                     ),
//                                   ),
//                                   IconButton(
//                                     onPressed: _refreshing ? null : _refreshLocation,
//                                     icon: _refreshing
//                                         ? const SizedBox(
//                                             width: 18,
//                                             height: 18,
//                                             child: CircularProgressIndicator(
//                                               strokeWidth: 2,
//                                               color: Colors.red,
//                                             ),
//                                           )
//                                         : const Icon(
//                                             Icons.refresh,
//                                             color: Colors.red,
//                                           ),
//                                     tooltip: 'Refresh location',
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),

//                       // Capture button
//                       Positioned(
//                         bottom: 30,
//                         left: 0,
//                         right: 0,
//                         child: Center(
//                           child: GestureDetector(
//                             onTap: _takePicture,
//                             child: Container(
//                               width: 70,
//                               height: 70,
//                               decoration: BoxDecoration(
//                                 shape: BoxShape.circle,
//                                 border: Border.all(color: Colors.white, width: 4),
//                               ),
//                               child: Container(
//                                 margin: const EdgeInsets.all(4),
//                                 decoration: const BoxDecoration(
//                                   color: Colors.white,
//                                   shape: BoxShape.circle,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   );
//                 } else {
//                   return const Center(
//                     child: CircularProgressIndicator(color: Colors.white),
//                   );
//                 }
//               },
//             ),
//     );
//   }

//   Widget _buildWatermarkRow(IconData icon, String label, String value) {
//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Icon(icon, color: Colors.white, size: 18),
//         const SizedBox(width: 8),
//         Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 label,
//                 style: const TextStyle(
//                   color: Colors.white70,
//                   fontSize: 11,
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),
//               const SizedBox(height: 2),
//               Text(
//                 value,
//                 style: const TextStyle(
//                   color: Colors.white,
//                   fontSize: 13,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }

import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_exif_rotation/flutter_exif_rotation.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image/image.dart' as img;
import 'package:intl/intl.dart';

class CameraWithWatermark extends StatefulWidget {
  final List<CameraDescription> cameras;
  final int initialCameraIndex;
  final Map<String, dynamic> locationData;

  const CameraWithWatermark({
    super.key,
    required this.cameras,
    required this.initialCameraIndex,
    required this.locationData,
  });

  @override
  State<CameraWithWatermark> createState() => _CameraWithWatermarkState();
}

class _CameraWithWatermarkState extends State<CameraWithWatermark> {
  CameraController? _controller;
  Future<void>? _initializeControllerFuture;
  late Map<String, dynamic> _currentLocationData;
  bool _refreshing = false;
  late int _selectedCameraIndex;

  @override
  void initState() {
    super.initState();
    _currentLocationData = Map<String, dynamic>.from(widget.locationData);
    _selectedCameraIndex = widget.initialCameraIndex;
    _initCamera(_selectedCameraIndex);
  }

  Future<void> _initCamera(int index) async {
    final previousController = _controller;

    _controller = CameraController(
      widget.cameras[index],
      ResolutionPreset.high,
      enableAudio: false,
    );

    _initializeControllerFuture = _controller!.initialize();

    setState(() {}); // rebuild FutureBuilder with new future

    // Dispose old controller after switching to avoid conflicts
    await previousController?.dispose();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  Future<void> _switchCamera() async {
    if (widget.cameras.length < 2) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No other camera available')),
        );
      }
      return;
    }

    final newIndex = (_selectedCameraIndex + 1) % widget.cameras.length;
    _selectedCameraIndex = newIndex;
    await _initCamera(newIndex);
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

  // Utility: decode bytes to get width & height using dart:ui
  Future<Map<String, int>> _getImageDimensions(File f) async {
    try {
      final Uint8List bytes = await f.readAsBytes();
      final codec = await ui.instantiateImageCodec(bytes);
      final frame = await codec.getNextFrame();
      return { 'width': frame.image.width, 'height': frame.image.height };
    } catch (e) {
      debugPrint('Failed to decode image for dimensions: $e');
      return { 'width': 0, 'height': 0 };
    }
  }

  // The improved takePicture: rotate pixels using flutter_exif_rotation,
  // then return the rotated XFile. Also logs raw & final dimensions & inferred orientation.
  Future<void> _takePicture() async {
    try {
      if (_initializeControllerFuture == null || _controller == null) return;

      await _initializeControllerFuture!;
      final XFile rawXfile = await _controller!.takePicture();

      final File rawFile = File(rawXfile.path);

      // Get raw image dimensions (before fix)
      final rawDims = await _getImageDimensions(rawFile);
      final rawW = rawDims['width'] ?? 0;
      final rawH = rawDims['height'] ?? 0;

      debugPrint('📸 RAW IMAGE INFO:');
      debugPrint('Path: ${rawFile.path}');
      debugPrint('Raw Width: $rawW');
      debugPrint('Raw Height: $rawH');

      // Rotate pixel data according to EXIF. This returns a new File path (or same if already normal).
  File rotatedFile;
try {
  rotatedFile = await FlutterExifRotation.rotateImage(path: rawFile.path);
} catch (e) {
  rotatedFile = rawFile;
}

// 👇 make front camera behave EXACTLY like back camera
final isFrontCamera =
    widget.cameras[_selectedCameraIndex].lensDirection ==
        CameraLensDirection.front;

if (isFrontCamera) {
  rotatedFile = await _removeFrontCameraMirror(rotatedFile);
}


      // Get rotated image dimensions
      final rotatedDims = await _getImageDimensions(rotatedFile);
      final rotatedW = rotatedDims['width'] ?? 0;
      final rotatedH = rotatedDims['height'] ?? 0;

      debugPrint('📸 ROTATED (FINAL) IMAGE INFO:');
      debugPrint('Path: ${rotatedFile.path}');
      debugPrint('Final Width: $rotatedW');
      debugPrint('Final Height: $rotatedH');

      // Inferred orientation message: compare raw and final dims to guess what happened.
      String inferred;
      if (rawW == rotatedW && rawH == rotatedH) {
        inferred = 'No rotation applied (pixels already upright).';
      } else if (rawW == rotatedH && rawH == rotatedW) {
        // swapped width/height -> rotated 90
        // Determine direction by checking camera sensor orientation is not available here, so use generic.
        inferred = 'Rotated 90 degrees (EXIF corrected).';
      } else {
        inferred = 'Image dimensions changed (EXIF correction or re-encode).';
      }
      debugPrint('📸 INFERENCE: $inferred');

      // Build XFile from rotated path to keep same return type the rest of app expects
      final XFile finalXfile = XFile(rotatedFile.path);

      if (mounted) {
        Navigator.pop(context, {
          'image': finalXfile,
          'locationData': _currentLocationData,
        });
      }
    } catch (e, st) {
      debugPrint('Error taking picture: $e\n$st');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: (_initializeControllerFuture == null || _controller == null)
          ? const Center(
              child: CircularProgressIndicator(color: Colors.white),
            )
          : FutureBuilder<void>(
              future: _initializeControllerFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Stack(
                    children: [
                      Positioned.fill(
                        child: CameraPreview(_controller!),
                      ),

                      // Top bar: Close + Switch camera
                      Positioned(
                        top: 40,
                        left: 16,
                        right: 16,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              onPressed: () => Navigator.pop(context),
                              icon: const Icon(
                                Icons.close,
                                color: Colors.white,
                                size: 32,
                              ),
                            ),
                            IconButton(
                              onPressed: _switchCamera,
                              icon: const Icon(
                                Icons.cameraswitch,
                                color: Colors.white,
                                size: 32,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Watermark card
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
                                    ? _currentLocationData['latitude']
                                        .toStringAsFixed(6)
                                    : '',
                              ),
                              const Divider(color: Colors.white24, height: 16),
                              _buildWatermarkRow(
                                Icons.location_on,
                                'Longitude',
                                _currentLocationData['longitude'] != null
                                    ? _currentLocationData['longitude']
                                        .toStringAsFixed(6)
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
                                        : const Icon(
                                            Icons.refresh,
                                            color: Colors.red,
                                          ),
                                    tooltip: 'Refresh location',
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),

                      // Capture button
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
  Future<File> _removeFrontCameraMirror(File file) async {
  final bytes = await file.readAsBytes();
  final image = img.decodeImage(bytes);
  if (image == null) return file;

  final fixed = img.flipHorizontal(image);
  return File(file.path).writeAsBytes(
    img.encodeJpg(fixed, quality: 100),
  );
}
}


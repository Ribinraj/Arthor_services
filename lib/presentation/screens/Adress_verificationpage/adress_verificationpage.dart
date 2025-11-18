// import 'dart:async';
// import 'dart:convert';
// import 'dart:io';

// import 'package:arthor/core/colors.dart';
// import 'package:arthor/data/atributes_model.dart';
// import 'package:arthor/data/untreceablereason_model.dart';
// import 'package:arthor/presentation/blocs/fetch_atributes_bloc/fetch_atributes_bloc.dart';
// import 'package:arthor/presentation/blocs/untreceable_reasons_bloc/untreceable_reasons_bloc.dart';
// import 'package:arthor/presentation/screens/Adress_verificationpage/widgets/camera_withwatermark.dart';
// import 'package:arthor/presentation/screens/Adress_verificationpage/widgets/custom_dropdwonfield.dart';
// import 'package:arthor/presentation/screens/Adress_verificationpage/widgets/customtextfield.dart';
// import 'package:arthor/presentation/screens/Adress_verificationpage/widgets/document_uploadcard.dart';
// import 'package:arthor/presentation/screens/Adress_verificationpage/widgets/verification_imagegallery.dart';

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:intl/intl.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:camera/camera.dart';

// class AddressVerificationPage extends StatefulWidget {
//   final String sectionKey;
//   final String verificationTypeId;

//   const AddressVerificationPage({
//     super.key,
//     required this.sectionKey,
//     required this.verificationTypeId,
//   });

//   @override
//   State<AddressVerificationPage> createState() =>
//       _AddressVerificationPageState();
// }

// class _AddressVerificationPageState extends State<AddressVerificationPage> {
//   final _formKey = GlobalKey<FormState>();
//   final ImagePicker _picker =
//       ImagePicker(); // Reserved for gallery if needed later

//   // Image and document storage with metadata
//   List<Map<String, dynamic>> _capturedImages = [];
//   PlatformFile? _uploadedDocument;

//   // Cached location data to avoid fetching repeatedly before camera
//   Map<String, dynamic>? _cachedLocationData;
//   StreamSubscription<Position>? _positionStreamSub;

//   // Dynamic form fields from server
//   List<AtributesModel> _formFields = [];
//   bool _initializedAnswers = false;

//   String? _traceable;

//   // 🔹 Untraceable reasons from server
//   List<UntreceableReasonModels> _untraceableReasons = [];
//   String? _untraceableReason; // selected reason text
//   String? _untraceableReasonId; // selected reason id (for submit)

//   final List<String> _traceableOptions = ['traceable', 'untraceable'];

//   // 🔹 caseResult dropdown (only for traceable)
//   String? _caseResult;
//   final List<String> _caseResultOptions = ['POSITIVE', 'NEGATIVE'];

//   final Map<String, dynamic> answers = {};

//   @override
//   void initState() {
//     super.initState();

//     // Fetch dynamic attributes
//     context.read<FetchAtributesBloc>().add(
//           FetchAtributesInitialEvent(
//             verificationTypeId: widget.verificationTypeId,
//           ),
//         );

//     // 🔹 Fetch untraceable reasons from server
//     context
//         .read<UntreceableReasonsBloc>()
//         .add(UntreceableReasonsFetchingInitialEvent());

//     _requestPermissions();
//     _fetchInitialLocation();
//   }

//   @override
//   void dispose() {
//     _positionStreamSub?.cancel();
//     super.dispose();
//   }

//   // Request necessary permissions
//   Future<void> _requestPermissions() async {
//     await Permission.camera.request();
//     await Permission.location.request();
//   }

//   // Fetch initial location silently (no snackbars)
//   Future<void> _fetchInitialLocation() async {
//     try {
//       bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
//       if (!serviceEnabled) return;

//       LocationPermission permission = await Geolocator.checkPermission();
//       if (permission == LocationPermission.denied) {
//         permission = await Geolocator.requestPermission();
//         if (permission == LocationPermission.denied) return;
//       }
//       if (permission == LocationPermission.deniedForever) return;

//       Position position = await Geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy.high,
//         timeLimit: const Duration(seconds: 6),
//       );

//       String address = 'Address not available';
//       try {
//         List<Placemark> placemarks = await placemarkFromCoordinates(
//           position.latitude,
//           position.longitude,
//         );
//         if (placemarks.isNotEmpty) {
//           Placemark place = placemarks[0];
//           address =
//               '${place.street ?? ''}, ${place.subLocality ?? ''}, ${place.locality ?? ''}, ${place.administrativeArea ?? ''}, ${place.postalCode ?? ''}, ${place.country ?? ''}'
//                   .replaceAll(RegExp(r',\s*,'), ',')
//                   .replaceAll(RegExp(r'^,\s*|,\s*$'), '')
//                   .trim();
//         }
//       } catch (e) {
//         address =
//             'Lat: ${position.latitude.toStringAsFixed(6)}, Long: ${position.longitude.toStringAsFixed(6)}';
//       }

//       DateTime now = DateTime.now();
//       _cachedLocationData = {
//         'latitude': position.latitude,
//         'longitude': position.longitude,
//         'address': address,
//         'timestamp': DateFormat('dd-MM-yyyy HH:mm:ss').format(now),
//         'raw_timestamp': now.toIso8601String(),
//       };
//       setState(() {});
//     } catch (e) {
//       debugPrint('Silent initial location fetch failed: $e');
//     }
//   }

//   // Full location with snackbars
//   Future<Map<String, dynamic>?> _getCurrentLocationData() async {
//     try {
//       bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
//       if (!serviceEnabled) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(
//             content: Text('Location services are disabled. Please enable them.'),
//             backgroundColor: Colors.orange,
//           ),
//         );
//         return null;
//       }

//       LocationPermission permission = await Geolocator.checkPermission();
//       if (permission == LocationPermission.denied) {
//         permission = await Geolocator.requestPermission();
//         if (permission == LocationPermission.denied) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(
//               content: Text('Location permission denied'),
//               backgroundColor: Colors.red,
//             ),
//           );
//           return null;
//         }
//       }

//       if (permission == LocationPermission.deniedForever) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(
//             content: Text('Location permissions are permanently denied'),
//             backgroundColor: Colors.red,
//           ),
//         );
//         return null;
//       }

//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(
//             content: Row(
//               children: [
//                 SizedBox(
//                   width: 20,
//                   height: 20,
//                   child: CircularProgressIndicator(
//                     strokeWidth: 2,
//                     valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
//                   ),
//                 ),
//                 SizedBox(width: 16),
//                 Text('Getting location...'),
//               ],
//             ),
//             duration: Duration(seconds: 2),
//           ),
//         );
//       }

//       Position position = await Geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy.high,
//       );

//       String address = 'Address not available';
//       try {
//         List<Placemark> placemarks = await placemarkFromCoordinates(
//           position.latitude,
//           position.longitude,
//         );

//         if (placemarks.isNotEmpty) {
//           Placemark place = placemarks[0];
//           address =
//               '${place.street ?? ''}, ${place.subLocality ?? ''}, ${place.locality ?? ''}, ${place.administrativeArea ?? ''}, ${place.postalCode ?? ''}, ${place.country ?? ''}'
//                   .replaceAll(RegExp(r',\s*,'), ',')
//                   .replaceAll(RegExp(r'^,\s*|,\s*$'), '')
//                   .trim();
//         }
//       } catch (e) {
//         debugPrint('Error getting address: $e');
//         address =
//             'Lat: ${position.latitude.toStringAsFixed(6)}, Long: ${position.longitude.toStringAsFixed(6)}';
//       }

//       DateTime now = DateTime.now();
//       String formattedDateTime =
//           DateFormat('dd-MM-yyyy HH:mm:ss').format(now);

//       return {
//         'latitude': position.latitude,
//         'longitude': position.longitude,
//         'address': address,
//         'timestamp': formattedDateTime,
//         'raw_timestamp': now.toIso8601String(),
//       };
//     } catch (e) {
//       debugPrint('Error getting location: $e');
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Error getting location: $e'),
//           backgroundColor: Colors.red,
//         ),
//       );
//       return null;
//     }
//   }

//   // Camera capture with location
//   Future<void> _captureImage() async {
//     try {
//       if (_cachedLocationData == null) {
//         final loc = await _getCurrentLocationData();
//         if (loc == null) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(
//               content: Text('Cannot capture image without location data'),
//               backgroundColor: Colors.red,
//               duration: Duration(seconds: 3),
//             ),
//           );
//           return;
//         }
//         _cachedLocationData = loc;
//       }

//       final cameras = await availableCameras();
//       if (cameras.isEmpty) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(
//             content: Text('No camera available'),
//             backgroundColor: Colors.red,
//           ),
//         );
//         return;
//       }

//       final result = await Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => CameraWithWatermark(
//             camera: cameras.first,
//             locationData: _cachedLocationData!,
//           ),
//         ),
//       );

//       if (result != null && result is Map && result['image'] != null) {
//         final XFile photo = result['image'] as XFile;
//         final Map<String, dynamic> usedLocation =
//             Map<String, dynamic>.from(
//                 result['locationData'] ?? _cachedLocationData!);

//         setState(() {
//           _capturedImages.add({
//             'image': photo,
//             'latitude': usedLocation['latitude'],
//             'longitude': usedLocation['longitude'],
//             'address': usedLocation['address'],
//             'timestamp': usedLocation['timestamp'],
//             'raw_timestamp': usedLocation['raw_timestamp'],
//           });
//           _cachedLocationData = usedLocation;
//         });

//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content:
//                 Text('Image ${_capturedImages.length} captured with location'),
//             backgroundColor: Colors.green,
//             duration: const Duration(seconds: 2),
//           ),
//         );
//       }
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Error capturing image: $e'),
//           backgroundColor: Colors.red,
//         ),
//       );
//     }
//   }

//   void _removeImage(int index) {
//     setState(() {
//       _capturedImages.removeAt(index);
//     });

//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(
//         content: Text('Image removed'),
//         duration: Duration(seconds: 1),
//       ),
//     );
//   }

//   void _showImageDetails(Map<String, dynamic> imageData, int index) {
//     showDialog(
//       context: context,
//       builder: (context) => Dialog(
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//         child: Container(
//           constraints: const BoxConstraints(maxWidth: 500, maxHeight: 700),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Row(
//                   children: [
//                     Icon(Icons.info_outline, color: Appcolors.kprimarycolor),
//                     const SizedBox(width: 8),
//                     Text(
//                       'Image ${index + 1} Details',
//                       style: const TextStyle(
//                           fontSize: 18, fontWeight: FontWeight.bold),
//                     ),
//                     const Spacer(),
//                     IconButton(
//                       onPressed: () => Navigator.pop(context),
//                       icon: const Icon(Icons.close),
//                     ),
//                   ],
//                 ),
//               ),
//               Expanded(
//                 child: SingleChildScrollView(
//                   padding: const EdgeInsets.symmetric(horizontal: 16),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       ClipRRect(
//                         borderRadius: BorderRadius.circular(8),
//                         child: Image.file(
//                           File(imageData['image'].path),
//                           height: 200,
//                           width: double.infinity,
//                           fit: BoxFit.cover,
//                         ),
//                       ),
//                       const SizedBox(height: 16),
//                       _buildDetailRow(
//                           Icons.calendar_today, 'Date & Time', imageData['timestamp']),
//                       const Divider(),
//                       _buildDetailRow(Icons.my_location, 'Latitude',
//                           imageData['latitude'].toStringAsFixed(6)),
//                       const Divider(),
//                       _buildDetailRow(Icons.location_on, 'Longitude',
//                           imageData['longitude'].toStringAsFixed(6)),
//                       const Divider(),
//                       _buildDetailRow(Icons.home, 'Address', imageData['address']),
//                       const SizedBox(height: 16),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildDetailRow(IconData icon, String label, String value) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Icon(icon, size: 20, color: Appcolors.kprimarycolor),
//           const SizedBox(width: 12),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   label,
//                   style: const TextStyle(
//                     fontSize: 12,
//                     color: Colors.grey,
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//                 const SizedBox(height: 4),
//                 Text(
//                   value,
//                   style: const TextStyle(
//                     fontSize: 14,
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Future<void> _pickDocument() async {
//     try {
//       FilePickerResult? result = await FilePicker.platform.pickFiles(
//         type: FileType.custom,
//         allowedExtensions: ['pdf', 'doc', 'docx', 'jpg', 'jpeg', 'png'],
//       );

//       if (result != null && result.files.isNotEmpty) {
//         setState(() {
//           _uploadedDocument = result.files.first;
//         });

//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text('Document uploaded: ${_uploadedDocument!.name}'),
//             backgroundColor: Colors.green,
//           ),
//         );
//       }
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Error picking document: $e'),
//           backgroundColor: Colors.red,
//         ),
//       );
//     }
//   }

//   void _removeDocument() {
//     setState(() {
//       _uploadedDocument = null;
//     });

//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(
//         content: Text('Document removed'),
//         duration: Duration(seconds: 1),
//       ),
//     );
//   }

//   // Dynamic field builder using custom widgets
//   Widget _buildField(AtributesModel field) {
//     final label = field.attributeName;
//     final type = field.attributeType;
//     final required = field.isRequired;
//     final options = field.optionsList;

//     if (type == 'SELECT' && options.isNotEmpty) {
//       return Padding(
//         padding: const EdgeInsets.only(bottom: 16.0),
//         child: CustomDropdownField(
//           label: label,
//           isRequired: required,
//           items: options,
//           value: answers[label],
//           onChanged: (v) => setState(() => answers[label] = v),
//           validator: required
//               ? (v) =>
//                   (v == null || v.isEmpty) ? 'Please select $label' : null
//               : null,
//         ),
//       );
//     } else if (type == 'NUMBER') {
//       return Padding(
//         padding: const EdgeInsets.only(bottom: 16.0),
//         child: CustomTextfieldVerification(
//           label: label,
//           isRequired: required,
//           initialValue: answers[label],
//           keyboardType: TextInputType.number,
//           onChanged: (v) => answers[label] = v,
//           validator: (v) {
//             if (required && (v == null || v.trim().isEmpty)) {
//               return 'Please enter $label';
//             }
//             if (v != null && v.isNotEmpty) {
//               final number = num.tryParse(v);
//               if (number == null) {
//                 return 'Please enter a valid number';
//               }
//             }
//             return null;
//           },
//         ),
//       );
//     } else {
//       // Default TEXT type
//       return Padding(
//         padding: const EdgeInsets.only(bottom: 16.0),
//         child: CustomTextfieldVerification(
//           label: label,
//           isRequired: required,
//           initialValue: answers[label],
//           onChanged: (v) => answers[label] = v,
//           validator: required
//               ? (v) => (v == null || v.trim().isEmpty)
//                   ? 'Please enter $label'
//                   : null
//               : null,
//         ),
//       );
//     }
//   }

//   void _onSubmit() {
//     if (!_formKey.currentState!.validate()) return;

//     if (_capturedImages.length < 5) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text('Please capture at least 5 images before submitting'),
//           backgroundColor: Colors.red,
//           duration: Duration(seconds: 3),
//         ),
//       );
//       return;
//     }

//     if (_traceable == 'untraceable') {
//       if (_untraceableReasonId == null || _untraceableReason == null) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(
//             content: Text('Please select untraceable reason'),
//             backgroundColor: Colors.red,
//             duration: Duration(seconds: 2),
//           ),
//         );
//         return;
//       }

//       answers['is_traceable'] = 'untraceable';
//       answers['untraceable_reason_id'] = _untraceableReasonId;
//       answers['untraceable_reason'] = _untraceableReason;
//       // caseResult is not used in untraceable flow
//       answers['caseResult'] = null;
//     } else {
//       // traceable
//       answers['is_traceable'] = 'traceable';
//       answers['untraceable_reason_id'] = null;
//       answers['untraceable_reason'] = null;

//       // 🔹 Ensure caseResult selected
//       if (_caseResult == null || _caseResult!.isEmpty) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(
//             content: Text('Please select caseResult'),
//             backgroundColor: Colors.red,
//             duration: Duration(seconds: 2),
//           ),
//         );
//         return;
//       }
//       answers['caseResult'] = _caseResult;
//     }

//     final imagesData = _capturedImages
//         .map((imgData) => {
//               'image_path': imgData['image'].path,
//               'latitude': imgData['latitude'],
//               'longitude': imgData['longitude'],
//               'address': imgData['address'],
//               'timestamp': imgData['timestamp'],
//               'raw_timestamp': imgData['raw_timestamp'],
//             })
//         .toList();

//     debugPrint('========== ALL CAPTURED IMAGES DATA ==========');
//     for (int i = 0; i < imagesData.length; i++) {
//       debugPrint('--- Image ${i + 1} ---');
//       debugPrint('Path: ${imagesData[i]['image_path']}');
//       debugPrint('Latitude: ${imagesData[i]['latitude']}');
//       debugPrint('Longitude: ${imagesData[i]['longitude']}');
//       debugPrint('Address: ${imagesData[i]['address']}');
//       debugPrint('Timestamp: ${imagesData[i]['timestamp']}');
//       debugPrint('');
//     }
//     debugPrint('==============================================');

//     final payload = {
//       'section': widget.sectionKey,
//       'verification_type_id': widget.verificationTypeId,
//       'answers': answers,
//       'images': imagesData,
//       'image_count': _capturedImages.length,
//       'document': _uploadedDocument != null
//           ? {
//               'name': _uploadedDocument!.name,
//               'path': _uploadedDocument!.path,
//               'size': _uploadedDocument!.size,
//             }
//           : null,
//     };

//     final jsonStr = jsonEncode(payload);
//     debugPrint(jsonStr);

//     showDialog(
//       context: context,
//       builder: (_) => AlertDialog(
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//         title: Row(
//           children: [
//             Icon(Icons.check_circle,
//                 color: Appcolors.kprimarycolor, size: 28),
//             const SizedBox(width: 12),
//             const Text(
//               'Submitted Successfully',
//               style: TextStyle(fontSize: 18),
//             ),
//           ],
//         ),
//         content: SingleChildScrollView(
//           child: Container(
//             padding: const EdgeInsets.all(12),
//             decoration: BoxDecoration(
//               color: Colors.grey[100],
//               borderRadius: BorderRadius.circular(8),
//             ),
//             child: Text(
//               jsonStr,
//               style: const TextStyle(fontSize: 12, fontFamily: 'monospace'),
//             ),
//           ),
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             style: TextButton.styleFrom(
//               foregroundColor: Appcolors.kprimarycolor,
//               padding:
//                   const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
//             ),
//             child: const Text(
//               'OK',
//               style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//             ),
//           )
//         ],
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[50],
//       appBar: AppBar(
//         backgroundColor: Appcolors.kprimarycolor,
//         foregroundColor: Appcolors.kwhitecolor,
//         elevation: 0,
//         title: Text('Verification - ${widget.sectionKey}'),
//         centerTitle: false,
//       ),
//       body: BlocConsumer<FetchAtributesBloc, FetchAtributesState>(
//         listener: (context, state) {
//           if (state is FetchAtributesErrorState) {
//             ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(
//                 content: Text('Error loading form: ${state.message}'),
//                 backgroundColor: Colors.red,
//               ),
//             );
//           }

//           if (state is FetchAtributesSuccessState && !_initializedAnswers) {
//             setState(() {
//               _formFields = state.atributes;
//               for (var field in _formFields) {
//                 answers[field.attributeName] = null;
//               }
//               answers['is_traceable'] = null;
//               answers['untraceable_reason_id'] = null;
//               answers['untraceable_reason'] = null;
//               answers['caseResult'] = null;
//               _initializedAnswers = true;
//             });
//           }
//         },
//         builder: (context, state) {
//           if (state is FetchAtributesLoadingState ||
//               state is FetchAtributesInitial) {
//             return Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   CircularProgressIndicator(color: Appcolors.kprimarycolor),
//                   const SizedBox(height: 16),
//                   const Text('Loading form fields...'),
//                 ],
//               ),
//             );
//           }

//           if (state is FetchAtributesErrorState) {
//             return Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   const Icon(Icons.error_outline, color: Colors.red, size: 40),
//                   const SizedBox(height: 12),
//                   Text(
//                     state.message,
//                     textAlign: TextAlign.center,
//                   ),
//                   const SizedBox(height: 16),
//                   ElevatedButton.icon(
//                     onPressed: () {
//                       context.read<FetchAtributesBloc>().add(
//                             FetchAtributesInitialEvent(
//                               verificationTypeId: widget.verificationTypeId,
//                             ),
//                           );
//                     },
//                     icon: const Icon(Icons.refresh),
//                     label: const Text('Retry'),
//                   ),
//                 ],
//               ),
//             );
//           }

//           // success state
//           return Form(
//             key: _formKey,
//             child: Column(
//               children: [
//                 // Traceable/Untraceable Section
//                 Container(
//                   width: double.infinity,
//                   padding: const EdgeInsets.all(16),
//                   decoration: BoxDecoration(
//                     color: Appcolors.kwhitecolor,
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.black.withOpacity(0.05),
//                         blurRadius: 4,
//                         offset: const Offset(0, 2),
//                       )
//                     ],
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'Address Traceability',
//                         style: TextStyle(
//                           fontSize: 16,
//                           fontWeight: FontWeight.bold,
//                           color: Appcolors.kblackcolor,
//                         ),
//                       ),
//                       const SizedBox(height: 12),
//                       CustomDropdownField(
//                         label: 'Is the address traceable?',
//                         isRequired: true,
//                         items: _traceableOptions,
//                         value: _traceable,
//                         onChanged: (v) {
//                           setState(() {
//                             _traceable = v;
//                             answers['is_traceable'] = _traceable;
//                             if (v == 'traceable') {
//                               _untraceableReason = null;
//                               _untraceableReasonId = null;
//                               answers['untraceable_reason_id'] = null;
//                               answers['untraceable_reason'] = null;
//                               // keep caseResult as is, or reset if you want:
//                               // _caseResult = null; answers['caseResult'] = null;
//                             } else {
//                               _caseResult = null;
//                               answers['caseResult'] = null;
//                             }
//                           });
//                         },
//                         validator: (v) => (v == null || v.isEmpty)
//                             ? 'Please select whether address is traceable'
//                             : null,
//                       ),
//                     ],
//                   ),
//                 ),

//                 // Main Content Area
//                 Expanded(
//                   child: _traceable == null
//                       ? Center(
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Icon(Icons.arrow_upward,
//                                   size: 48, color: Colors.grey[400]),
//                               const SizedBox(height: 16),
//                               Text(
//                                 'Please select traceability status above',
//                                 style: TextStyle(
//                                     fontSize: 16, color: Colors.grey[600]),
//                               ),
//                             ],
//                           ),
//                         )
//                       : _traceable == 'traceable'
//                           ? ListView(
//                               padding: const EdgeInsets.all(16),
//                               children: [
//                                 Container(
//                                   padding: const EdgeInsets.all(16),
//                                   decoration: BoxDecoration(
//                                     color: Appcolors.kwhitecolor,
//                                     borderRadius: BorderRadius.circular(12),
//                                     boxShadow: [
//                                       BoxShadow(
//                                         color: Colors.black.withOpacity(0.05),
//                                         blurRadius: 4,
//                                         offset: const Offset(0, 2),
//                                       )
//                                     ],
//                                   ),
//                                   child: Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       Row(
//                                         children: [
//                                           Icon(Icons.assignment,
//                                               color: Appcolors.kprimarycolor),
//                                           const SizedBox(width: 8),
//                                           const Text(
//                                             'Verification Details',
//                                             style: TextStyle(
//                                                 fontSize: 18,
//                                                 fontWeight: FontWeight.bold),
//                                           ),
//                                         ],
//                                       ),
//                                       const SizedBox(height: 16),
//                                       ..._formFields
//                                           .map((f) => _buildField(f))
//                                           .toList(),
//                                       const SizedBox(height: 16),
//                                       // 🔹 caseResult dropdown (only when traceable)
//                                       CustomDropdownField(
//                                         label: 'caseResult',
//                                         isRequired: true,
//                                         items: _caseResultOptions,
//                                         value: _caseResult,
//                                         onChanged: (v) {
//                                           setState(() {
//                                             _caseResult = v;
//                                             answers['caseResult'] = v;
//                                           });
//                                         },
//                                         validator: (v) =>
//                                             (v == null || v.isEmpty)
//                                                 ? 'Please select caseResult'
//                                                 : null,
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                                 const SizedBox(height: 16),
//                                 VerificationImageGallery(
//                                   images: _capturedImages,
//                                   onCapturePressed: _captureImage,
//                                   onRemoveImage: _removeImage,
//                                   onTapImage: (index) => _showImageDetails(
//                                     _capturedImages[index],
//                                     index,
//                                   ),
//                                 ),
//                                 const SizedBox(height: 16),
//                                 DocumentUploadCard(
//                                   document: _uploadedDocument,
//                                   onUploadPressed: _pickDocument,
//                                   onRemovePressed: _removeDocument,
//                                 ),
//                                 const SizedBox(height: 24),
//                                 SizedBox(
//                                   width: double.infinity,
//                                   height: 50,
//                                   child: ElevatedButton(
//                                     onPressed: _onSubmit,
//                                     style: ElevatedButton.styleFrom(
//                                       backgroundColor: Appcolors.kprimarycolor,
//                                       foregroundColor: Appcolors.kwhitecolor,
//                                       shape: RoundedRectangleBorder(
//                                         borderRadius: BorderRadius.circular(12),
//                                       ),
//                                       elevation: 2,
//                                     ),
//                                     child: const Text(
//                                       'Submit Verification',
//                                       style: TextStyle(
//                                           fontSize: 16,
//                                           fontWeight: FontWeight.bold),
//                                     ),
//                                   ),
//                                 ),
//                                 const SizedBox(height: 16),
//                               ],
//                             )
//                           : ListView(
//                               padding: const EdgeInsets.all(16),
//                               children: [
//                                 Container(
//                                   padding: const EdgeInsets.all(16),
//                                   decoration: BoxDecoration(
//                                     color: Appcolors.kwhitecolor,
//                                     borderRadius: BorderRadius.circular(12),
//                                     boxShadow: [
//                                       BoxShadow(
//                                         color: Colors.black.withOpacity(0.05),
//                                         blurRadius: 4,
//                                         offset: const Offset(0, 2),
//                                       )
//                                     ],
//                                   ),
//                                   child: Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       Row(
//                                         children: [
//                                           Icon(
//                                             Icons.warning_amber_rounded,
//                                             color: Appcolors.ksecondarycolor,
//                                             size: 28,
//                                           ),
//                                           const SizedBox(width: 12),
//                                           const Text(
//                                             'Untraceable Reason',
//                                             style: TextStyle(
//                                                 fontSize: 18,
//                                                 fontWeight: FontWeight.bold),
//                                           ),
//                                         ],
//                                       ),
//                                       const SizedBox(height: 16),
//                                       const Text(
//                                         'Please select the reason why the address is untraceable:',
//                                         style: TextStyle(
//                                             fontSize: 14,
//                                             color: Colors.black87),
//                                       ),
//                                       const SizedBox(height: 16),

//                                       // 🔹 Untraceable reasons from Bloc
//                                       BlocBuilder<UntreceableReasonsBloc,
//                                           UntreceableReasonsState>(
//                                         builder: (context, reasonState) {
//                                           if (reasonState
//                                                   is UntreceableReasonsLoadingState &&
//                                               _untraceableReasons.isEmpty) {
//                                             return const Padding(
//                                               padding: EdgeInsets.symmetric(
//                                                   vertical: 8.0),
//                                               child: Row(
//                                                 children: [
//                                                   SizedBox(
//                                                     width: 18,
//                                                     height: 18,
//                                                     child:
//                                                         CircularProgressIndicator(
//                                                       strokeWidth: 2,
//                                                     ),
//                                                   ),
//                                                   SizedBox(width: 8),
//                                                   Text('Loading reasons...'),
//                                                 ],
//                                               ),
//                                             );
//                                           }

//                                           if (reasonState
//                                                   is UntreceableReasonsErrorState &&
//                                               _untraceableReasons.isEmpty) {
//                                             return Column(
//                                               crossAxisAlignment:
//                                                   CrossAxisAlignment.start,
//                                               children: [
//                                                 Text(
//                                                   reasonState.message,
//                                                   style: const TextStyle(
//                                                     color: Colors.red,
//                                                     fontSize: 13,
//                                                   ),
//                                                 ),
//                                                 const SizedBox(height: 8),
//                                                 TextButton.icon(
//                                                   onPressed: () {
//                                                     context
//                                                         .read<
//                                                             UntreceableReasonsBloc>()
//                                                         .add(
//                                                           UntreceableReasonsFetchingInitialEvent(),
//                                                         );
//                                                   },
//                                                   icon: const Icon(
//                                                       Icons.refresh),
//                                                   label: const Text('Retry'),
//                                                 ),
//                                               ],
//                                             );
//                                           }

//                                           if (reasonState
//                                               is UntreceableReasonsSuccessState) {
//                                             _untraceableReasons =
//                                                 reasonState.reasons;
//                                           }

//                                           final items = _untraceableReasons
//                                               .map((r) => r.reason)
//                                               .toList();

//                                           return CustomDropdownField(
//                                             label: 'Reason',
//                                             isRequired: true,
//                                             items: items,
//                                             value: _untraceableReason,
//                                             onChanged: (v) {
//                                               setState(() {
//                                                 _untraceableReason = v;
//                                                 _untraceableReasonId = null;

//                                                 if (v != null) {
//                                                   final selected =
//                                                       _untraceableReasons
//                                                           .where((r) =>
//                                                               r.reason == v)
//                                                           .toList();
//                                                   if (selected.isNotEmpty) {
//                                                     _untraceableReasonId =
//                                                         selected
//                                                             .first.reasonId;
//                                                   }
//                                                 }
//                                               });
//                                             },
//                                             validator: (v) =>
//                                                 (v == null || v.isEmpty)
//                                                     ? 'Please select reason for untraceable'
//                                                     : null,
//                                           );
//                                         },
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                                 const SizedBox(height: 16),
//                                 VerificationImageGallery(
//                                   images: _capturedImages,
//                                   onCapturePressed: _captureImage,
//                                   onRemoveImage: _removeImage,
//                                   onTapImage: (index) => _showImageDetails(
//                                     _capturedImages[index],
//                                     index,
//                                   ),
//                                 ),
//                                 const SizedBox(height: 16),
//                                 DocumentUploadCard(
//                                   document: _uploadedDocument,
//                                   onUploadPressed: _pickDocument,
//                                   onRemovePressed: _removeDocument,
//                                 ),
//                                 const SizedBox(height: 24),
//                                 SizedBox(
//                                   width: double.infinity,
//                                   height: 50,
//                                   child: ElevatedButton(
//                                     onPressed: _onSubmit,
//                                     style: ElevatedButton.styleFrom(
//                                       backgroundColor: Appcolors.kprimarycolor,
//                                       foregroundColor: Appcolors.kwhitecolor,
//                                       shape: RoundedRectangleBorder(
//                                         borderRadius: BorderRadius.circular(12),
//                                       ),
//                                       elevation: 2,
//                                     ),
//                                     child: const Text(
//                                       'Submit',
//                                       style: TextStyle(
//                                           fontSize: 16,
//                                           fontWeight: FontWeight.bold),
//                                     ),
//                                   ),
//                                 ),
//                                 const SizedBox(height: 16),
//                               ],
//                             ),
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
//////////////////////////////////////////////
import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:arthor/core/colors.dart';
import 'package:arthor/data/atributes_model.dart';
import 'package:arthor/data/treceable_verificationmodel.dart' as traceable;
import 'package:arthor/data/untreceable_verificationmodel.dart' as untraceable;
import 'package:arthor/data/untreceablereason_model.dart';
import 'package:arthor/presentation/blocs/bloc/form_submit_bloc.dart';
import 'package:arthor/presentation/blocs/fetch_atributes_bloc/fetch_atributes_bloc.dart';

import 'package:arthor/presentation/blocs/untreceable_reasons_bloc/untreceable_reasons_bloc.dart';
import 'package:arthor/presentation/screens/Adress_verificationpage/widgets/camera_withwatermark.dart';
import 'package:arthor/presentation/screens/Adress_verificationpage/widgets/custom_dropdwonfield.dart';
import 'package:arthor/presentation/screens/Adress_verificationpage/widgets/customtextfield.dart';
import 'package:arthor/presentation/screens/Adress_verificationpage/widgets/document_uploadcard.dart';
import 'package:arthor/presentation/screens/Adress_verificationpage/widgets/verification_imagegallery.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:camera/camera.dart';

class AddressVerificationPage extends StatefulWidget {
  final String sectionKey;
  final String verificationTypeId;
  final String caseId; // Add caseId parameter

  const AddressVerificationPage({
    super.key,
    required this.sectionKey,
    required this.verificationTypeId,
    required this.caseId,
  });

  @override
  State<AddressVerificationPage> createState() =>
      _AddressVerificationPageState();
}

class _AddressVerificationPageState extends State<AddressVerificationPage> {
  final _formKey = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();

  // Image and document storage with metadata (now includes base64)
  List<Map<String, dynamic>> _capturedImages = [];
  PlatformFile? _uploadedDocument;
  String? _uploadedDocumentBase64;

  // Cached location data
  Map<String, dynamic>? _cachedLocationData;
  StreamSubscription<Position>? _positionStreamSub;

  // Dynamic form fields from server
  List<AtributesModel> _formFields = [];
  bool _initializedAnswers = false;

  String? _traceable;

  // Untraceable reasons from server
  List<UntreceableReasonModels> _untraceableReasons = [];
  String? _untraceableReason;
  String? _untraceableReasonId;

  final List<String> _traceableOptions = ['traceable', 'untraceable'];

  // caseResult dropdown (only for traceable)
  String? _caseResult;
  final List<String> _caseResultOptions = ['POSITIVE', 'NEGATIVE'];

  final Map<String, dynamic> answers = {};

  @override
  void initState() {
    super.initState();

    context.read<FetchAtributesBloc>().add(
          FetchAtributesInitialEvent(
            verificationTypeId: widget.verificationTypeId,
          ),
        );

    context
        .read<UntreceableReasonsBloc>()
        .add(UntreceableReasonsFetchingInitialEvent());

    _requestPermissions();
    _fetchInitialLocation();
  }

  @override
  void dispose() {
    _positionStreamSub?.cancel();
    super.dispose();
  }

  Future<void> _requestPermissions() async {
    await Permission.camera.request();
    await Permission.location.request();
  }

  Future<void> _fetchInitialLocation() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) return;

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) return;
      }
      if (permission == LocationPermission.deniedForever) return;

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
        timeLimit: const Duration(seconds: 6),
      );

      String address = 'Address not available';
      try {
        List<Placemark> placemarks = await placemarkFromCoordinates(
          position.latitude,
          position.longitude,
        );
        if (placemarks.isNotEmpty) {
          Placemark place = placemarks[0];
          address =
              '${place.street ?? ''}, ${place.subLocality ?? ''}, ${place.locality ?? ''}, ${place.administrativeArea ?? ''}, ${place.postalCode ?? ''}, ${place.country ?? ''}'
                  .replaceAll(RegExp(r',\s*,'), ',')
                  .replaceAll(RegExp(r'^,\s*|,\s*$'), '')
                  .trim();
        }
      } catch (e) {
        address =
            'Lat: ${position.latitude.toStringAsFixed(6)}, Long: ${position.longitude.toStringAsFixed(6)}';
      }

      DateTime now = DateTime.now();
      _cachedLocationData = {
        'latitude': position.latitude,
        'longitude': position.longitude,
        'address': address,
        'timestamp': DateFormat('dd-MM-yyyy HH:mm:ss').format(now),
        'raw_timestamp': now.toIso8601String(),
      };
      setState(() {});
    } catch (e) {
      debugPrint('Silent initial location fetch failed: $e');
    }
  }

  Future<Map<String, dynamic>?> _getCurrentLocationData() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Location services are disabled. Please enable them.'),
            backgroundColor: Colors.orange,
          ),
        );
        return null;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Location permission denied'),
              backgroundColor: Colors.red,
            ),
          );
          return null;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Location permissions are permanently denied'),
            backgroundColor: Colors.red,
          ),
        );
        return null;
      }

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      String address = 'Address not available';
      try {
        List<Placemark> placemarks = await placemarkFromCoordinates(
          position.latitude,
          position.longitude,
        );

        if (placemarks.isNotEmpty) {
          Placemark place = placemarks[0];
          address =
              '${place.street ?? ''}, ${place.subLocality ?? ''}, ${place.locality ?? ''}, ${place.administrativeArea ?? ''}, ${place.postalCode ?? ''}, ${place.country ?? ''}'
                  .replaceAll(RegExp(r',\s*,'), ',')
                  .replaceAll(RegExp(r'^,\s*|,\s*$'), '')
                  .trim();
        }
      } catch (e) {
        debugPrint('Error getting address: $e');
        address =
            'Lat: ${position.latitude.toStringAsFixed(6)}, Long: ${position.longitude.toStringAsFixed(6)}';
      }

      DateTime now = DateTime.now();
      String formattedDateTime = DateFormat('dd-MM-yyyy HH:mm:ss').format(now);

      return {
        'latitude': position.latitude,
        'longitude': position.longitude,
        'address': address,
        'timestamp': formattedDateTime,
        'raw_timestamp': now.toIso8601String(),
      };
    } catch (e) {
      debugPrint('Error getting location: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error getting location: $e'),
          backgroundColor: Colors.red,
        ),
      );
      return null;
    }
  }

  // Convert file to base64
  Future<String> _fileToBase64(String filePath) async {
    try {
      final bytes = await File(filePath).readAsBytes();
      return base64Encode(bytes);
    } catch (e) {
      debugPrint('Error converting file to base64: $e');
      rethrow;
    }
  }

  Future<void> _captureImage() async {
    try {
      if (_cachedLocationData == null) {
        final loc = await _getCurrentLocationData();
        if (loc == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Cannot capture image without location data'),
              backgroundColor: Colors.red,
              duration: Duration(seconds: 3),
            ),
          );
          return;
        }
        _cachedLocationData = loc;
      }

      final cameras = await availableCameras();
      if (cameras.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('No camera available'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      final result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CameraWithWatermark(
            camera: cameras.first,
            locationData: _cachedLocationData!,
          ),
        ),
      );

      if (result != null && result is Map && result['image'] != null) {
        final XFile photo = result['image'] as XFile;
        final Map<String, dynamic> usedLocation =
            Map<String, dynamic>.from(result['locationData'] ?? _cachedLocationData!);

        // Convert image to base64 immediately
        String base64Image = await _fileToBase64(photo.path);

        setState(() {
          _capturedImages.add({
            'image': photo,
            'latitude': usedLocation['latitude'],
            'longitude': usedLocation['longitude'],
            'address': usedLocation['address'],
            'timestamp': usedLocation['timestamp'],
            'raw_timestamp': usedLocation['raw_timestamp'],
            'base64': base64Image, // Store base64
            'fileName': photo.name,
          });
          _cachedLocationData = usedLocation;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Image ${_capturedImages.length} captured with location'),
            backgroundColor: Colors.green,
            duration: const Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error capturing image: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _removeImage(int index) {
    setState(() {
      _capturedImages.removeAt(index);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Image removed'),
        duration: Duration(seconds: 1),
      ),
    );
  }

  void _showImageDetails(Map<String, dynamic> imageData, int index) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Container(
          constraints: const BoxConstraints(maxWidth: 500, maxHeight: 700),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Icon(Icons.info_outline, color: Appcolors.kprimarycolor),
                    const SizedBox(width: 8),
                    Text(
                      'Image ${index + 1} Details',
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.close),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.file(
                          File(imageData['image'].path),
                          height: 200,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(height: 16),
                      _buildDetailRow(Icons.calendar_today, 'Date & Time', imageData['timestamp']),
                      const Divider(),
                      _buildDetailRow(Icons.my_location, 'Latitude',
                          imageData['latitude'].toStringAsFixed(6)),
                      const Divider(),
                      _buildDetailRow(Icons.location_on, 'Longitude',
                          imageData['longitude'].toStringAsFixed(6)),
                      const Divider(),
                      _buildDetailRow(Icons.home, 'Address', imageData['address']),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20, color: Appcolors.kprimarycolor),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _pickDocument() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'doc', 'docx', 'jpg', 'jpeg', 'png'],
      );

      if (result != null && result.files.isNotEmpty) {
        // Convert document to base64 immediately
        String base64Doc = await _fileToBase64(result.files.first.path!);

        setState(() {
          _uploadedDocument = result.files.first;
          _uploadedDocumentBase64 = base64Doc;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Document uploaded: ${_uploadedDocument!.name}'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error picking document: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _removeDocument() {
    setState(() {
      _uploadedDocument = null;
      _uploadedDocumentBase64 = null;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Document removed'),
        duration: Duration(seconds: 1),
      ),
    );
  }

  Widget _buildField(AtributesModel field) {
    final label = field.attributeName;
    final type = field.attributeType;
    final required = field.isRequired;
    final options = field.optionsList;

    if (type == 'SELECT' && options.isNotEmpty) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 16.0),
        child: CustomDropdownField(
          label: label,
          isRequired: required,
          items: options,
          value: answers[label],
          onChanged: (v) => setState(() => answers[label] = v),
          validator: required
              ? (v) => (v == null || v.isEmpty) ? 'Please select $label' : null
              : null,
        ),
      );
    } else if (type == 'NUMBER') {
      return Padding(
        padding: const EdgeInsets.only(bottom: 16.0),
        child: CustomTextfieldVerification(
          label: label,
          isRequired: required,
          initialValue: answers[label],
          keyboardType: TextInputType.number,
          onChanged: (v) => answers[label] = v,
          validator: (v) {
            if (required && (v == null || v.trim().isEmpty)) {
              return 'Please enter $label';
            }
            if (v != null && v.isNotEmpty) {
              final number = num.tryParse(v);
              if (number == null) {
                return 'Please enter a valid number';
              }
            }
            return null;
          },
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.only(bottom: 16.0),
        child: CustomTextfieldVerification(
          label: label,
          isRequired: required,
          initialValue: answers[label],
          onChanged: (v) => answers[label] = v,
          validator: required
              ? (v) => (v == null || v.trim().isEmpty) ? 'Please enter $label' : null
              : null,
        ),
      );
    }
  }

  void _onSubmit() {
    if (!_formKey.currentState!.validate()) return;

    if (_capturedImages.length < 5) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please capture at least 5 images before submitting'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 3),
        ),
      );
      return;
    }

    if (_traceable == 'untraceable') {
      // Untraceable submission
      _submitUntraceable();
    } else {
      // Traceable submission
      if (_caseResult == null || _caseResult!.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please select caseResult'),
            backgroundColor: Colors.red,
            duration: Duration(seconds: 2),
          ),
        );
        return;
      }
      _submitTraceable();
    }
  }

void _submitUntraceable() {
  if (_untraceableReasonId == null || _untraceableReason == null) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Please select untraceable reason'),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 2),
      ),
    );
    return;
  }

  // Build untraceable attachments
  List<untraceable.Attachment> attachments = _capturedImages.map((img) {
    // Format datetime as "yyyy-MM-dd HH:mm:ss"
    DateTime dt = DateTime.parse(img['raw_timestamp']);
    String formattedDt = DateFormat('yyyy-MM-dd HH:mm:ss').format(dt);

    return untraceable.Attachment(
      latitude: img['latitude'].toString(),
      longitude: img['longitude'].toString(),
      dateTime: formattedDt,
      fileName: img['fileName'],
      file: img['base64'],
    );
  }).toList();

  final untraceableModel = untraceable.UntreceableVerificationmodel(
    caseId: widget.caseId,
    addressStatus: 'UNTRACEABLE',
    reasonId: _untraceableReasonId!,
    caseResult: 'NEGATIVE', // Default as per requirement
    attachments: attachments,
  );

  // Submit via Bloc
  context.read<FormSubmitBloc>().add(
        SubmitUntraceablePressed(data: untraceableModel),
      );
}


void _submitTraceable() {
  // Get current location for main lat/long
  final mainLat = _cachedLocationData?['latitude']?.toString() ?? '0.0';
  final mainLong = _cachedLocationData?['longitude']?.toString() ?? '0.0';

  // Build attachment (supporting document) - optional
  traceable.SingleAttachment? attachment;
  if (_uploadedDocument != null && _uploadedDocumentBase64 != null) {
    attachment = traceable.SingleAttachment(
      fileName: _uploadedDocument!.name,
      file: _uploadedDocumentBase64!,
    );
  }

  // Build attachments (images with location)
  List<traceable.Attachment> attachments = _capturedImages.map((img) {
    return traceable.Attachment(
      fileName: img['fileName'],
      file: img['base64'],
      latt: img['latitude'].toString(),
      longi: img['longitude'].toString(),
      address: img['address'],
    );
  }).toList();

  // Build attributes from form fields
  List<traceable.AttributeItem> attributes = [];
  for (var field in _formFields) {
    final value = answers[field.attributeName];
    if (value != null && value.toString().isNotEmpty) {
      attributes.add(
        traceable.AttributeItem(
          attributeId: int.parse(field.attributeId),
          value: value.toString(),
        ),
      );
    }
  }

  final traceableModel = traceable.TreceableVerificationmodel(
    caseId: widget.caseId,
    addressStatus: 'TRACEABLE',
    caseResult: _caseResult!,
    latt: mainLat,
    longi: mainLong,
    attachment: attachment,
    attachments: attachments,
    attributes: attributes,
  );

  // Submit via Bloc
  context.read<FormSubmitBloc>().add(
        SubmitTraceablePressed(data: traceableModel),
      );
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Appcolors.kprimarycolor,
        foregroundColor: Appcolors.kwhitecolor,
        elevation: 0,
        title: Text('Verification - ${widget.sectionKey}'),
        centerTitle: false,
      ),
      body: MultiBlocListener(
        listeners: [
          BlocListener<FetchAtributesBloc, FetchAtributesState>(
            listener: (context, state) {
              if (state is FetchAtributesErrorState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Error loading form: ${state.message}'),
                    backgroundColor: Colors.red,
                  ),
                );
              }

              if (state is FetchAtributesSuccessState && !_initializedAnswers) {
                setState(() {
                  _formFields = state.atributes;
                  for (var field in _formFields) {
                    answers[field.attributeName] = null;
                  }
                  _initializedAnswers = true;
                });
              }
            },
          ),
          BlocListener<FormSubmitBloc, FormSubmitState>(
            listener: (context, state) {
              if (state is FormSubmitLoadingState) {
                // Show loading dialog
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (_) => WillPopScope(
                    onWillPop: () async => false,
                    child: Center(
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CircularProgressIndicator(color: Appcolors.kprimarycolor),
                              const SizedBox(height: 16),
                              const Text('Submitting verification...'),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }

              if (state is FormSubmitSuccessState) {
                Navigator.pop(context); // Close loading dialog
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    title: Row(
                      children: [
                        Icon(Icons.check_circle, color: Colors.green, size: 28),
                        const SizedBox(width: 12),
                        const Text('Success!'),
                      ],
                    ),
                    content: Text(state.message),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context); // Close dialog
                          Navigator.pop(context); // Go back to previous screen
                        },
                        child: const Text('OK'),
                      ),
                    ],
                  ),
                );
              }

              if (state is FormSubmitErrorState) {
                Navigator.pop(context); // Close loading dialog
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    title: Row(
                      children: [
                        Icon(Icons.error_outline, color: Colors.red, size: 28),
                        const SizedBox(width: 12),
                        const Text('Error'),
                      ],
                    ),
                    content: Text(state.message),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('OK'),
                      ),
                    ],
                  ),
                );
              }
            },
          ),
        ],
        child: BlocBuilder<FetchAtributesBloc, FetchAtributesState>(
          builder: (context, state) {
            if (state is FetchAtributesLoadingState || state is FetchAtributesInitial) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(color: Appcolors.kprimarycolor),
                    const SizedBox(height: 16),
                    const Text('Loading form fields...'),
                  ],
                ),
              );
            }

            if (state is FetchAtributesErrorState) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error_outline, color: Colors.red, size: 40),
                    const SizedBox(height: 12),
                    Text(state.message, textAlign: TextAlign.center),
                    const SizedBox(height: 16),
                    ElevatedButton.icon(
                      onPressed: () {
                        context.read<FetchAtributesBloc>().add(
                              FetchAtributesInitialEvent(
                                verificationTypeId: widget.verificationTypeId,
                              ),
                            );
                      },
                      icon: const Icon(Icons.refresh),
                      label: const Text('Retry'),
                    ),
                  ],
                ),
              );
            }

            return Form(
              key: _formKey,
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Appcolors.kwhitecolor,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        )
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Address Traceability',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Appcolors.kblackcolor,
                          ),
                        ),
                        const SizedBox(height: 12),
                        CustomDropdownField(
                          label: 'Is the address traceable?',
                          isRequired: true,
                          items: _traceableOptions,
                          value: _traceable,
                          onChanged: (v) {
                            setState(() {
                              _traceable = v;
                              if (v == 'traceable') {
                                _untraceableReason = null;
                                _untraceableReasonId = null;
                              } else {
                                _caseResult = null;
                              }
                            });
                          },
                          validator: (v) => (v == null || v.isEmpty)
                              ? 'Please select whether address is traceable'
                              : null,
                        ),
                      ],
                    ),
                  ),

                  Expanded(
                    child: _traceable == null
                        ? Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.arrow_upward, size: 48, color: Colors.grey[400]),
                                const SizedBox(height: 16),
                                Text(
                                  'Please select traceability status above',
                                  style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                                ),
                              ],
                            ),
                          )
                        : _traceable == 'traceable'
                            ? ListView(
                                padding: const EdgeInsets.all(16),
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                      color: Appcolors.kwhitecolor,
                                      borderRadius: BorderRadius.circular(12),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.05),
                                          blurRadius: 4,
                                          offset: const Offset(0, 2),
                                        )
                                      ],
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(Icons.assignment, color: Appcolors.kprimarycolor),
                                            const SizedBox(width: 8),
                                            const Text(
                                              'Verification Details',
                                              style: TextStyle(
                                                  fontSize: 18, fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 16),
                                        ..._formFields.map((f) => _buildField(f)).toList(),
                                        const SizedBox(height: 16),
                                        CustomDropdownField(
                                          label: 'Case Result',
                                          isRequired: true,
                                          items: _caseResultOptions,
                                          value: _caseResult,
                                          onChanged: (v) {
                                            setState(() {
                                              _caseResult = v;
                                            });
                                          },
                                          validator: (v) => (v == null || v.isEmpty)
                                              ? 'Please select caseResult'
                                              : null,
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  VerificationImageGallery(
                                    images: _capturedImages,
                                    onCapturePressed: _captureImage,
                                    onRemoveImage: _removeImage,
                                    onTapImage: (index) => _showImageDetails(
                                      _capturedImages[index],
                                      index,
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  DocumentUploadCard(
                                    document: _uploadedDocument,
                                    onUploadPressed: _pickDocument,
                                    onRemovePressed: _removeDocument,
                                  ),
                                  const SizedBox(height: 24),
                                  SizedBox(
                                    width: double.infinity,
                                    height: 50,
                                    child: ElevatedButton(
                                      onPressed: _onSubmit,
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Appcolors.kprimarycolor,
                                        foregroundColor: Appcolors.kwhitecolor,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                        elevation: 2,
                                      ),
                                      child: const Text(
                                        'Submit Verification',
                                        style: TextStyle(
                                            fontSize: 16, fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                ],
                              )
                            : ListView(
                                padding: const EdgeInsets.all(16),
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                      color: Appcolors.kwhitecolor,
                                      borderRadius: BorderRadius.circular(12),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.05),
                                          blurRadius: 4,
                                          offset: const Offset(0, 2),
                                        )
                                      ],
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.warning_amber_rounded,
                                              color: Appcolors.ksecondarycolor,
                                              size: 28,
                                            ),
                                            const SizedBox(width: 12),
                                            const Text(
                                              'Untraceable Reason',
                                              style: TextStyle(
                                                  fontSize: 18, fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 16),
                                        const Text(
                                          'Please select the reason why the address is untraceable:',
                                          style: TextStyle(fontSize: 14, color: Colors.black87),
                                        ),
                                        const SizedBox(height: 16),
                                        BlocBuilder<UntreceableReasonsBloc, UntreceableReasonsState>(
                                          builder: (context, reasonState) {
                                            if (reasonState is UntreceableReasonsLoadingState &&
                                                _untraceableReasons.isEmpty) {
                                              return const Padding(
                                                padding: EdgeInsets.symmetric(vertical: 8.0),
                                                child: Row(
                                                  children: [
                                                    SizedBox(
                                                      width: 18,
                                                      height: 18,
                                                      child: CircularProgressIndicator(
                                                        strokeWidth: 2,
                                                      ),
                                                    ),
                                                    SizedBox(width: 8),
                                                    Text('Loading reasons...'),
                                                  ],
                                                ),
                                              );
                                            }

                                            if (reasonState is UntreceableReasonsErrorState &&
                                                _untraceableReasons.isEmpty) {
                                              return Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    reasonState.message,
                                                    style: const TextStyle(
                                                      color: Colors.red,
                                                      fontSize: 13,
                                                    ),
                                                  ),
                                                  const SizedBox(height: 8),
                                                  TextButton.icon(
                                                    onPressed: () {
                                                      context.read<UntreceableReasonsBloc>().add(
                                                            UntreceableReasonsFetchingInitialEvent(),
                                                          );
                                                    },
                                                    icon: const Icon(Icons.refresh),
                                                    label: const Text('Retry'),
                                                  ),
                                                ],
                                              );
                                            }

                                            if (reasonState is UntreceableReasonsSuccessState) {
                                              _untraceableReasons = reasonState.reasons;
                                            }

                                            final items = _untraceableReasons
                                                .map((r) => r.reason)
                                                .toList();

                                            return CustomDropdownField(
                                              label: 'Reason',
                                              isRequired: true,
                                              items: items,
                                              value: _untraceableReason,
                                              onChanged: (v) {
                                                setState(() {
                                                  _untraceableReason = v;
                                                  _untraceableReasonId = null;

                                                  if (v != null) {
                                                    final selected = _untraceableReasons
                                                        .where((r) => r.reason == v)
                                                        .toList();
                                                    if (selected.isNotEmpty) {
                                                      _untraceableReasonId = selected.first.reasonId;
                                                    }
                                                  }
                                                });
                                              },
                                              validator: (v) => (v == null || v.isEmpty)
                                                  ? 'Please select reason for untraceable'
                                                  : null,
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  VerificationImageGallery(
                                    images: _capturedImages,
                                    onCapturePressed: _captureImage,
                                    onRemoveImage: _removeImage,
                                    onTapImage: (index) => _showImageDetails(
                                      _capturedImages[index],
                                      index,
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  DocumentUploadCard(
                                    document: _uploadedDocument,
                                    onUploadPressed: _pickDocument,
                                    onRemovePressed: _removeDocument,
                                  ),
                                  const SizedBox(height: 24),
                                  SizedBox(
                                    width: double.infinity,
                                    height: 50,
                                    child: ElevatedButton(
                                      onPressed: _onSubmit,
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Appcolors.kprimarycolor,
                                        foregroundColor: Appcolors.kwhitecolor,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                        elevation: 2,
                                      ),
                                      child: const Text(
                                        'Submit',
                                        style: TextStyle(
                                            fontSize: 16, fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                ],
                              ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
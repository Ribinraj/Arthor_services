
// // import 'dart:convert';
// // import 'dart:io';
// // import 'package:arthor/core/colors.dart';

// // import 'package:flutter/material.dart';
// // import 'package:image_picker/image_picker.dart';
// // import 'package:file_picker/file_picker.dart';

// // /// AddressVerificationPage
// // /// - Pass `sectionKey` as one of the available sections
// // /// - Questions marked with required:true are validated before submit
// // /// - Minimum 5 images required (camera only)
// // /// - Optional document upload
// // class AddressVerificationPage extends StatefulWidget {
// //   final String sectionKey;
// //   const AddressVerificationPage({super.key, required this.sectionKey});

// //   @override
// //   State<AddressVerificationPage> createState() => _AddressVerificationPageState();
// // }

// // class _AddressVerificationPageState extends State<AddressVerificationPage> {
// //   final _formKey = GlobalKey<FormState>();
// //   final ImagePicker _picker = ImagePicker();
  
// //   // Image and document storage
// //   List<XFile> _capturedImages = [];
// //   PlatformFile? _uploadedDocument;

// //   /// Form schema with required field validation
// //   final Map<String, List<Map<String, dynamic>>> formSchema = {
// //     "Present Residence": [
// //       {"label": "Entry Allowed", "type": "dropdown", "options": ["Yes", "No"], "required": true},
// //       {"label": "Met Person", "type": "text", "required": true},
// //       {"label": "Relationship with Applicant", "type": "text", "required": true},
// //       {"label": "Applicant age", "type": "text", "required": true},
// //       {"label": "Rented/Owned/Leased", "type": "text", "required": true},
// //       {"label": "Amount If Rent/Leased (type)", "type": "text", "required": false},
// //       {"label": "Total Family Members", "type": "text", "required": true},
// //       {"label": "No of members Working", "type": "text", "required": true},
// //       {"label": "Names of Working Person", "type": "text", "required": true},
// //       {"label": "No of members dependent", "type": "text", "required": true},
// //       {"label": "Name of Dependent person", "type": "text", "required": false},
// //       {"label": "Door number Displayed(Yes / No)", "type": "dropdown", "options": ["Yes", "No"], "required": true},
// //       {"label": "Applicant working company name", "type": "text", "required": true},
// //       {"label": "Designation", "type": "text", "required": true},
// //       {"label": "Years of working", "type": "text", "required": true},
// //       {"label": "Salary", "type": "text", "required": true},
// //       {"label": "Type of Resi (RCC/ Tiled/ Sheet)", "type": "dropdown", "options": ["RCC", "Tiled", "Sheet"], "required": true},
// //       {"label": "Independent/Part of independent/ Attached", "type": "text", "required": true},
// //       {"label": "Floor", "type": "text", "required": true},
// //       {"label": "Color", "type": "text", "required": true},
// //       {"label": "Sqft", "type": "text", "required": true},
// //       {"label": "Type of Area (Middle Class area/ Commercial area/Village area/Negative area/ slum area/Industrial Area)", "type": "text", "required": true},
// //       {"label": "Landmark", "type": "text", "required": true},
// //       {"label": "km", "type": "text", "required": true},
// //       {"label": "Neighbour - 1", "type": "text", "required": true},
// //       {"label": "Neighbour - 2", "type": "text", "required": true},
// //       {"label": "Status", "type": "text", "required": true},
// //     ],

// //     "Business": [
// //       {"label": "Entry Allowed", "type": "dropdown", "options": ["Yes", "No"], "required": true},
// //       {"label": "Met Person", "type": "text", "required": true},
// //       {"label": "Designation of the person met", "type": "text", "required": true},
// //       {"label": "Designation of the Applicant", "type": "text", "required": true},
// //       {"label": "Name of the company", "type": "text", "required": true},
// //       {"label": "Years of working", "type": "text", "required": true},
// //       {"label": "Salary", "type": "text", "required": true},
// //       {"label": "Name board displayed", "type": "text", "required": true},
// //       {"label": "No of Employees working", "type": "text", "required": true},
// //       {"label": "Business activity (Good, Average, Poor)", "type": "text", "required": true},
// //       {"label": "Stock (High, Medium, Less)", "type": "text", "required": true},
// //       {"label": "Name board is displayed (Yes/No)", "type": "dropdown", "options": ["Yes", "No"], "required": true},
// //       {"label": "Type of Area (Middle Class area/ Commercial area/Village area/Negative area/ slum area/Industrial Area)", "type": "text", "required": true},
// //       {"label": "Status", "type": "text", "required": true},
// //     ],

// //     "Permanent Residence": [
// //       {"label": "Entry Allowed", "type": "dropdown", "options": ["Yes", "No"], "required": true},
// //       {"label": "Met Person", "type": "text", "required": true},
// //       {"label": "Relationship with Applicant", "type": "text", "required": true},
// //       {"label": "Applicant age", "type": "text", "required": true},
// //       {"label": "Rented/Owned/Leased", "type": "text", "required": true},
// //       {"label": "Amount If Rent/Leased (type)", "type": "text", "required": false},
// //       {"label": "Total Family Members", "type": "text", "required": true},
// //       {"label": "No of members Working", "type": "text", "required": true},
// //       {"label": "Names of Working Person", "type": "text", "required": true},
// //       {"label": "Name of Dependent person", "type": "text", "required": false},
// //       {"label": "Neighbour - 1", "type": "text", "required": true},
// //       {"label": "Neighbour - 2", "type": "text", "required": true},
// //       {"label": "Status", "type": "text", "required": true},
// //     ],

// //     "Resi c...er Verification": [
// //       {"label": "Document Verification - Name of the document", "type": "text", "required": true},
// //       {"label": "Met Person", "type": "text", "required": true},
// //       {"label": "Relationship with Applicant", "type": "text", "required": true},
// //       {"label": "Property (Yes/No)", "type": "dropdown", "options": ["Yes", "No"], "required": true},
// //       {"label": "Confirmation on Document(Yes/ No)", "type": "dropdown", "options": ["Yes", "No"], "required": true},
// //       {"label": "Name board is displayed (Yes/No)", "type": "dropdown", "options": ["Yes", "No"], "required": true},
// //       {"label": "Name of the asset", "type": "text", "required": true},
// //       {"label": "Designation", "type": "text", "required": true},
// //       {"label": "Relationship with Seller", "type": "text", "required": true},
// //       {"label": "Applicant age", "type": "text", "required": true},
// //       {"label": "Rented/Owned/Leased", "type": "text", "required": true},
// //       {"label": "Name board displayed (Yes/No)", "type": "dropdown", "options": ["Yes", "No"], "required": true},
// //       {"label": "Total Family Members", "type": "text", "required": true},
// //       {"label": "No of members Working", "type": "text", "required": true},
// //       {"label": "Sqft", "type": "text", "required": true},
// //       {"label": "Floor", "type": "text", "required": true},
// //       {"label": "Status", "type": "text", "required": true},
// //     ],

// //     "Document Verification": [
// //       {"label": "Type of asset", "type": "text", "required": true},
// //       {"label": "Met Person", "type": "text", "required": true},
// //       {"label": "Relationship with Applicant", "type": "text", "required": true},
// //       {"label": "Designation", "type": "text", "required": true},
// //       {"label": "Relationship with Applicant", "type": "text", "required": true},
// //       {"label": "Applicant age", "type": "text", "required": true},
// //       {"label": "Rented/Owned/Leased", "type": "text", "required": true},
// //       {"label": "Amount If Rent/Leased (type)", "type": "text", "required": false},
// //       {"label": "Total Family Members", "type": "text", "required": true},
// //       {"label": "Department", "type": "text", "required": true},
// //       {"label": "Sqft", "type": "text", "required": true},
// //       {"label": "Floor", "type": "text", "required": true},
// //       {"label": "Status", "type": "text", "required": true},
// //     ],

// //     "Asset Verification": [
// //       {"label": "Name of the asset", "type": "text", "required": true},
// //       {"label": "Met Person", "type": "text", "required": true},
// //       {"label": "Relationship with Applicant", "type": "text", "required": true},
// //       {"label": "Designation", "type": "text", "required": true},
// //       {"label": "Relationship with Applicant", "type": "text", "required": true},
// //       {"label": "Applicant age", "type": "text", "required": true},
// //       {"label": "Rented/Owned/Leased", "type": "text", "required": true},
// //       {"label": "Amount If Rent/Leased (type)", "type": "text", "required": false},
// //       {"label": "Sqft", "type": "text", "required": true},
// //       {"label": "No of members Working", "type": "text", "required": true},
// //       {"label": "No of members dependent", "type": "text", "required": true},
// //       {"label": "Designation", "type": "text", "required": true},
// //       {"label": "Status", "type": "text", "required": true},
// //     ],
// //   };

// //   String? _traceable;
// //   String? _untraceableReason;
// //   final List<String> _traceableOptions = ['traceable', 'untraceable'];
// //   final List<String> _untraceableReasons = [
// //     'address insufficient',
// //     'address insufficient and difficult to locate',
// //     'applicant not responding phonecall',
// //     'loan cancel',
// //   ];

// //   final Map<String, dynamic> answers = {};

// //   @override
// //   void initState() {
// //     super.initState();
// //     final fields = formSchema[widget.sectionKey] ?? [];
// //     for (var f in fields) {
// //       answers[f['label']] = null;
// //     }
// //     answers['is_traceable'] = null;
// //     answers['untraceable_reason'] = null;
// //   }

// //   // Camera capture function
// //   Future<void> _captureImage() async {
// //     try {
// //       final XFile? photo = await _picker.pickImage(
// //         source: ImageSource.camera,
// //         imageQuality: 85,
// //       );
      
// //       if (photo != null) {
// //         setState(() {
// //           _capturedImages.add(photo);
// //         });
        
// //         ScaffoldMessenger.of(context).showSnackBar(
// //           SnackBar(
// //             content: Text('Image ${_capturedImages.length} captured successfully'),
// //             backgroundColor: Colors.green,
// //             duration: const Duration(seconds: 2),
// //           ),
// //         );
// //       }
// //     } catch (e) {
// //       ScaffoldMessenger.of(context).showSnackBar(
// //         SnackBar(
// //           content: Text('Error capturing image: $e'),
// //           backgroundColor: Colors.red,
// //         ),
// //       );
// //     }
// //   }

// //   // Remove image function
// //   void _removeImage(int index) {
// //     setState(() {
// //       _capturedImages.removeAt(index);
// //     });
    
// //     ScaffoldMessenger.of(context).showSnackBar(
// //       const SnackBar(
// //         content: Text('Image removed'),
// //         duration: Duration(seconds: 1),
// //       ),
// //     );
// //   }

// //   // Document picker function
// //   Future<void> _pickDocument() async {
// //     try {
// //       FilePickerResult? result = await FilePicker.platform.pickFiles(
// //         type: FileType.custom,
// //         allowedExtensions: ['pdf', 'doc', 'docx', 'jpg', 'jpeg', 'png'],
// //       );

// //       if (result != null && result.files.isNotEmpty) {
// //         setState(() {
// //           _uploadedDocument = result.files.first;
// //         });
        
// //         ScaffoldMessenger.of(context).showSnackBar(
// //           SnackBar(
// //             content: Text('Document uploaded: ${_uploadedDocument!.name}'),
// //             backgroundColor: Colors.green,
// //           ),
// //         );
// //       }
// //     } catch (e) {
// //       ScaffoldMessenger.of(context).showSnackBar(
// //         SnackBar(
// //           content: Text('Error picking document: $e'),
// //           backgroundColor: Colors.red,
// //         ),
// //       );
// //     }
// //   }

// //   // Remove document function
// //   void _removeDocument() {
// //     setState(() {
// //       _uploadedDocument = null;
// //     });
    
// //     ScaffoldMessenger.of(context).showSnackBar(
// //       const SnackBar(
// //         content: Text('Document removed'),
// //         duration: Duration(seconds: 1),
// //       ),
// //     );
// //   }

// //   Widget _buildField(Map<String, dynamic> field) {
// //     final label = field['label'] as String;
// //     final type = field['type'] as String;
// //     final required = field['required'] as bool? ?? true;

// //     if (type == 'dropdown') {
// //       final List<dynamic> opts = field['options'] ?? [];
// //       return Padding(
// //         padding: const EdgeInsets.only(bottom: 16.0),
// //         child: DropdownButtonFormField<String>(
// //           decoration: InputDecoration(
// //             labelText: required ? '$label *' : label,
// //             labelStyle: TextStyle(color: Appcolors.kblackcolor.withOpacity(0.7)),
// //             border: OutlineInputBorder(
// //               borderRadius: BorderRadius.circular(12),
// //               borderSide: const BorderSide(color: Appcolors.kbordercolor),
// //             ),
// //             enabledBorder: OutlineInputBorder(
// //               borderRadius: BorderRadius.circular(12),
// //               borderSide: BorderSide(color: Appcolors.kbordercolor.withOpacity(0.5)),
// //             ),
// //             focusedBorder: OutlineInputBorder(
// //               borderRadius: BorderRadius.circular(12),
// //               borderSide: const BorderSide(color: Appcolors.kprimarycolor, width: 2),
// //             ),
// //             filled: true,
// //             fillColor: Appcolors.kwhitecolor,
// //             contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
// //           ),
// //           items: opts.map((o) => DropdownMenuItem(value: o.toString(), child: Text(o.toString()))).toList(),
// //           value: answers[label],
// //           onChanged: (v) => setState(() => answers[label] = v),
// //           validator: required ? (v) => (v == null || v.isEmpty) ? 'Please select $label' : null : null,
// //         ),
// //       );
// //     } else {
// //       return Padding(
// //         padding: const EdgeInsets.only(bottom: 16.0),
// //         child: TextFormField(
// //           initialValue: answers[label],
// //           decoration: InputDecoration(
// //             labelText: required ? '$label *' : label,
// //             labelStyle: TextStyle(color: Appcolors.kblackcolor.withOpacity(0.7)),
// //             border: OutlineInputBorder(
// //               borderRadius: BorderRadius.circular(12),
// //               borderSide: const BorderSide(color: Appcolors.kbordercolor),
// //             ),
// //             enabledBorder: OutlineInputBorder(
// //               borderRadius: BorderRadius.circular(12),
// //               borderSide: BorderSide(color: Appcolors.kbordercolor.withOpacity(0.5)),
// //             ),
// //             focusedBorder: OutlineInputBorder(
// //               borderRadius: BorderRadius.circular(12),
// //               borderSide: const BorderSide(color: Appcolors.kprimarycolor, width: 2),
// //             ),
// //             filled: true,
// //             fillColor: Appcolors.kwhitecolor,
// //             contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
// //           ),
// //           onChanged: (v) => answers[label] = v,
// //           validator: required ? (v) => (v == null || v.trim().isEmpty) ? 'Please enter $label' : null : null,
// //         ),
// //       );
// //     }
// //   }

// //   // Image gallery widget
// //   Widget _buildImageGallery() {
// //     return Container(
// //       padding: const EdgeInsets.all(16),
// //       decoration: BoxDecoration(
// //         color: Appcolors.kwhitecolor,
// //         borderRadius: BorderRadius.circular(12),
// //         boxShadow: [
// //           BoxShadow(
// //             color: Colors.black.withOpacity(0.05),
// //             blurRadius: 4,
// //             offset: const Offset(0, 2),
// //           )
// //         ],
// //       ),
// //       child: Column(
// //         crossAxisAlignment: CrossAxisAlignment.start,
// //         children: [
// //           Row(
// //             children: [
// //               Icon(Icons.camera_alt, color: Appcolors.kprimarycolor),
// //               const SizedBox(width: 8),
// //               const Text(
// //                 'Verification Images',
// //                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
// //               ),
// //               const Spacer(),
// //               Container(
// //                 padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
// //                 decoration: BoxDecoration(
// //                   color: _capturedImages.length >= 5 ? Colors.green : Colors.orange,
// //                   borderRadius: BorderRadius.circular(20),
// //                 ),
// //                 child: Text(
// //                   '${_capturedImages.length}/5 min',
// //                   style: const TextStyle(
// //                     color: Colors.white,
// //                     fontSize: 12,
// //                     fontWeight: FontWeight.bold,
// //                   ),
// //                 ),
// //               ),
// //             ],
// //           ),
// //           const SizedBox(height: 12),
// //           Text(
// //             'Minimum 5 images required *',
// //             style: TextStyle(
// //               fontSize: 13,
// //               color: _capturedImages.length < 5 ? Colors.red : Colors.green,
// //               fontWeight: FontWeight.w500,
// //             ),
// //           ),
// //           const SizedBox(height: 16),
          
// //           // Display captured images
// //           if (_capturedImages.isNotEmpty)
// //             GridView.builder(
// //               shrinkWrap: true,
// //               physics: const NeverScrollableScrollPhysics(),
// //               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
// //                 crossAxisCount: 3,
// //                 crossAxisSpacing: 8,
// //                 mainAxisSpacing: 8,
// //               ),
// //               itemCount: _capturedImages.length,
// //               itemBuilder: (context, index) {
// //                 return Stack(
// //                   children: [
// //                     ClipRRect(
// //                       borderRadius: BorderRadius.circular(8),
// //                       child: Image.file(
// //                         File(_capturedImages[index].path),
// //                         fit: BoxFit.cover,
// //                         width: double.infinity,
// //                         height: double.infinity,
// //                       ),
// //                     ),
// //                     Positioned(
// //                       top: 4,
// //                       right: 4,
// //                       child: GestureDetector(
// //                         onTap: () => _removeImage(index),
// //                         child: Container(
// //                           padding: const EdgeInsets.all(4),
// //                           decoration: const BoxDecoration(
// //                             color: Colors.red,
// //                             shape: BoxShape.circle,
// //                           ),
// //                           child: const Icon(
// //                             Icons.close,
// //                             size: 16,
// //                             color: Colors.white,
// //                           ),
// //                         ),
// //                       ),
// //                     ),
// //                     Positioned(
// //                       bottom: 4,
// //                       left: 4,
// //                       child: Container(
// //                         padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
// //                         decoration: BoxDecoration(
// //                           color: Colors.black54,
// //                           borderRadius: BorderRadius.circular(4),
// //                         ),
// //                         child: Text(
// //                           '${index + 1}',
// //                           style: const TextStyle(
// //                             color: Colors.white,
// //                             fontSize: 10,
// //                             fontWeight: FontWeight.bold,
// //                           ),
// //                         ),
// //                       ),
// //                     ),
// //                   ],
// //                 );
// //               },
// //             ),
          
// //           const SizedBox(height: 16),
// //           SizedBox(
// //             width: double.infinity,
// //             height: 50,
// //             child: OutlinedButton.icon(
// //               onPressed: _captureImage,
// //               icon: const Icon(Icons.camera_alt),
// //               label: const Text('Capture Image'),
// //               style: OutlinedButton.styleFrom(
// //                 foregroundColor: Appcolors.kprimarycolor,
// //                 side: BorderSide(color: Appcolors.kprimarycolor, width: 2),
// //                 shape: RoundedRectangleBorder(
// //                   borderRadius: BorderRadius.circular(12),
// //                 ),
// //               ),
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }

// //   // Document upload widget
// //   Widget _buildDocumentUpload() {
// //     return Container(
// //       padding: const EdgeInsets.all(16),
// //       decoration: BoxDecoration(
// //         color: Appcolors.kwhitecolor,
// //         borderRadius: BorderRadius.circular(12),
// //         boxShadow: [
// //           BoxShadow(
// //             color: Colors.black.withOpacity(0.05),
// //             blurRadius: 4,
// //             offset: const Offset(0, 2),
// //           )
// //         ],
// //       ),
// //       child: Column(
// //         crossAxisAlignment: CrossAxisAlignment.start,
// //         children: [
// //           Row(
// //             children: [
// //               Icon(Icons.insert_drive_file, color: Appcolors.kprimarycolor),
// //               const SizedBox(width: 8),
// //               const Text(
// //                 'Supporting Document',
// //                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
// //               ),
// //             ],
// //           ),
// //           const SizedBox(height: 8),
// //           const Text(
// //             'Optional - PDF, DOC, DOCX, or Images',
// //             style: TextStyle(fontSize: 13, color: Colors.black54),
// //           ),
// //           const SizedBox(height: 16),
          
// //           if (_uploadedDocument != null)
// //             Container(
// //               padding: const EdgeInsets.all(12),
// //               decoration: BoxDecoration(
// //                 color: Colors.green.withOpacity(0.1),
// //                 borderRadius: BorderRadius.circular(8),
// //                 border: Border.all(color: Colors.green, width: 1),
// //               ),
// //               child: Row(
// //                 children: [
// //                   const Icon(Icons.check_circle, color: Colors.green, size: 24),
// //                   const SizedBox(width: 12),
// //                   Expanded(
// //                     child: Column(
// //                       crossAxisAlignment: CrossAxisAlignment.start,
// //                       children: [
// //                         Text(
// //                           _uploadedDocument!.name,
// //                           style: const TextStyle(
// //                             fontWeight: FontWeight.w500,
// //                             fontSize: 14,
// //                           ),
// //                           maxLines: 1,
// //                           overflow: TextOverflow.ellipsis,
// //                         ),
// //                         Text(
// //                           '${(_uploadedDocument!.size / 1024).toStringAsFixed(2)} KB',
// //                           style: const TextStyle(
// //                             fontSize: 12,
// //                             color: Colors.black54,
// //                           ),
// //                         ),
// //                       ],
// //                     ),
// //                   ),
// //                   IconButton(
// //                     onPressed: _removeDocument,
// //                     icon: const Icon(Icons.delete, color: Colors.red),
// //                   ),
// //                 ],
// //               ),
// //             )
// //           else
// //             SizedBox(
// //               width: double.infinity,
// //               height: 50,
// //               child: OutlinedButton.icon(
// //                 onPressed: _pickDocument,
// //                 icon: const Icon(Icons.upload_file),
// //                 label: const Text('Upload Document'),
// //                 style: OutlinedButton.styleFrom(
// //                   foregroundColor: Appcolors.kprimarycolor,
// //                   side: BorderSide(color: Appcolors.kprimarycolor.withOpacity(0.5), width: 1.5),
// //                   shape: RoundedRectangleBorder(
// //                     borderRadius: BorderRadius.circular(12),
// //                   ),
// //                 ),
// //               ),
// //             ),
// //         ],
// //       ),
// //     );
// //   }

// //   void _onSubmit() {
// //     // Validate form fields
// //     if (!_formKey.currentState!.validate()) return;

// //     // Validate minimum images
// //     if (_capturedImages.length < 5) {
// //       ScaffoldMessenger.of(context).showSnackBar(
// //         const SnackBar(
// //           content: Text('Please capture at least 5 images before submitting'),
// //           backgroundColor: Colors.red,
// //           duration: Duration(seconds: 3),
// //         ),
// //       );
// //       return;
// //     }

// //     if (_traceable == 'untraceable') {
// //       answers['is_traceable'] = 'untraceable';
// //       answers['untraceable_reason'] = _untraceableReason;
// //     } else {
// //       answers['is_traceable'] = 'traceable';
// //       answers['untraceable_reason'] = null;
// //     }

// //     final payload = {
// //       'section': widget.sectionKey,
// //       'answers': answers,
// //       'images': _capturedImages.map((img) => img.path).toList(),
// //       'image_count': _capturedImages.length,
// //       'document': _uploadedDocument != null ? {
// //         'name': _uploadedDocument!.name,
// //         'path': _uploadedDocument!.path,
// //         'size': _uploadedDocument!.size,
// //       } : null,
// //     };

// //     final jsonStr = jsonEncode(payload);
// //     debugPrint(jsonStr);
    
// //     showDialog(
// //       context: context,
// //       builder: (_) => AlertDialog(
// //         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
// //         title: Row(
// //           children: [
// //             Icon(Icons.check_circle, color: Appcolors.kprimarycolor, size: 28),
// //             const SizedBox(width: 12),
// //             const Text('Submitted Successfully', style: TextStyle(fontSize: 18)),
// //           ],
// //         ),
// //         content: SingleChildScrollView(
// //           child: Container(
// //             padding: const EdgeInsets.all(12),
// //             decoration: BoxDecoration(
// //               color: Colors.grey[100],
// //               borderRadius: BorderRadius.circular(8),
// //             ),
// //             child: Text(jsonStr, style: const TextStyle(fontSize: 12, fontFamily: 'monospace')),
// //           ),
// //         ),
// //         actions: [
// //           TextButton(
// //             onPressed: () => Navigator.pop(context),
// //             style: TextButton.styleFrom(
// //               foregroundColor: Appcolors.kprimarycolor,
// //               padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
// //             ),
// //             child: const Text('OK', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
// //           )
// //         ],
// //       ),
// //     );
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     final fields = formSchema[widget.sectionKey] ?? [];
// //     return Scaffold(
// //       backgroundColor: Colors.grey[50],
// //       appBar: AppBar(
// //         backgroundColor: Appcolors.kprimarycolor,
// //         foregroundColor: Appcolors.kwhitecolor,
// //         elevation: 0,
// //         title: Text('Verification - ${widget.sectionKey}'),
// //         centerTitle: false,
// //       ),
// //       body: Form(
// //         key: _formKey,
// //         child: Column(
// //           children: [
// //             // Traceable/Untraceable Section
// //             Container(
// //               width: double.infinity,
// //               padding: const EdgeInsets.all(16),
// //               decoration: BoxDecoration(
// //                 color: Appcolors.kwhitecolor,
// //                 boxShadow: [
// //                   BoxShadow(
// //                     color: Colors.black.withOpacity(0.05),
// //                     blurRadius: 4,
// //                     offset: const Offset(0, 2),
// //                   )
// //                 ],
// //               ),
// //               child: Column(
// //                 crossAxisAlignment: CrossAxisAlignment.start,
// //                 children: [
// //                   Text(
// //                     'Address Traceability',
// //                     style: TextStyle(
// //                       fontSize: 16,
// //                       fontWeight: FontWeight.bold,
// //                       color: Appcolors.kblackcolor,
// //                     ),
// //                   ),
// //                   const SizedBox(height: 12),
// //                   DropdownButtonFormField<String>(
// //                     decoration: InputDecoration(
// //                       labelText: 'Is the address traceable? *',
// //                       labelStyle: TextStyle(color: Appcolors.kblackcolor.withOpacity(0.7)),
// //                       border: OutlineInputBorder(
// //                         borderRadius: BorderRadius.circular(12),
// //                         borderSide: const BorderSide(color: Appcolors.kbordercolor),
// //                       ),
// //                       enabledBorder: OutlineInputBorder(
// //                         borderRadius: BorderRadius.circular(12),
// //                         borderSide: BorderSide(color: Appcolors.kbordercolor.withOpacity(0.5)),
// //                       ),
// //                       focusedBorder: OutlineInputBorder(
// //                         borderRadius: BorderRadius.circular(12),
// //                         borderSide: const BorderSide(color: Appcolors.kprimarycolor, width: 2),
// //                       ),
// //                       filled: true,
// //                       fillColor: Appcolors.kwhitecolor,
// //                       contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
// //                     ),
// //                     items: _traceableOptions.map((o) => DropdownMenuItem(value: o, child: Text(o.toUpperCase()))).toList(),
// //                     value: _traceable,
// //                     onChanged: (v) => setState(() {
// //                       _traceable = v;
// //                       answers['is_traceable'] = _traceable;
// //                       if (v == 'traceable') {
// //                         _untraceableReason = null;
// //                         answers['untraceable_reason'] = null;
// //                       }
// //                     }),
// //                     validator: (v) => (v == null || v.isEmpty) ? 'Please select whether address is traceable' : null,
// //                   ),
// //                 ],
// //               ),
// //             ),

// //             // Main Content Area
// //             Expanded(
// //               child: _traceable == null
// //                   ? Center(
// //                       child: Column(
// //                         mainAxisAlignment: MainAxisAlignment.center,
// //                         children: [
// //                           Icon(Icons.arrow_upward, size: 48, color: Colors.grey[400]),
// //                           const SizedBox(height: 16),
// //                           Text(
// //                             'Please select traceability status above',
// //                             style: TextStyle(fontSize: 16, color: Colors.grey[600]),
// //                           ),
// //                         ],
// //                       ),
// //                     )
// //                   : _traceable == 'traceable'
// //                       ? ListView(
// //                           padding: const EdgeInsets.all(16),
// //                           children: [
// //                             Container(
// //                               padding: const EdgeInsets.all(16),
// //                               decoration: BoxDecoration(
// //                                 color: Appcolors.kwhitecolor,
// //                                 borderRadius: BorderRadius.circular(12),
// //                                 boxShadow: [
// //                                   BoxShadow(
// //                                     color: Colors.black.withOpacity(0.05),
// //                                     blurRadius: 4,
// //                                     offset: const Offset(0, 2),
// //                                   )
// //                                 ],
// //                               ),
// //                               child: Column(
// //                                 crossAxisAlignment: CrossAxisAlignment.start,
// //                                 children: [
// //                                   Row(
// //                                     children: [
// //                                       Icon(Icons.assignment, color: Appcolors.kprimarycolor),
// //                                       const SizedBox(width: 8),
// //                                       const Text(
// //                                         'Verification Details',
// //                                         style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
// //                                       ),
// //                                     ],
// //                                   ),
// //                                   const SizedBox(height: 16),
// //                                   ...fields.map((f) => _buildField(f)).toList(),
// //                                 ],
// //                               ),
// //                             ),
// //                             const SizedBox(height: 16),
                            
// //                             // Image Gallery
// //                             _buildImageGallery(),
// //                             const SizedBox(height: 16),
                            
// //                             // Document Upload
// //                             _buildDocumentUpload(),
// //                             const SizedBox(height: 24),
                            
// //                             SizedBox(
// //                               width: double.infinity,
// //                               height: 50,
// //                               child: ElevatedButton(
// //                                 onPressed: _onSubmit,
// //                                 style: ElevatedButton.styleFrom(
// //                                   backgroundColor: Appcolors.kprimarycolor,
// //                                   foregroundColor: Appcolors.kwhitecolor,
// //                                   shape: RoundedRectangleBorder(
// //                                     borderRadius: BorderRadius.circular(12),
// //                                   ),
// //                                   elevation: 2,
// //                                 ),
// //                                 child: const Text('Submit Verification', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
// //                               ),
// //                             ),
// //                             const SizedBox(height: 16),
// //                           ],
// //                         )
// //                       : ListView(
// //                           padding: const EdgeInsets.all(16),
// //                           children: [
// //                             Container(
// //                               padding: const EdgeInsets.all(16),
// //                               decoration: BoxDecoration(
// //                                 color: Appcolors.kwhitecolor,
// //                                 borderRadius: BorderRadius.circular(12),
// //                                 boxShadow: [
// //                                   BoxShadow(
// //                                     color: Colors.black.withOpacity(0.05),
// //                                     blurRadius: 4,
// //                                     offset: const Offset(0, 2),
// //                                   )
// //                                 ],
// //                               ),
// //                               child: Column(
// //                                 crossAxisAlignment: CrossAxisAlignment.start,
// //                                 children: [
// //                                   Row(
// //                                     children: [
// //                                       Icon(Icons.warning_amber_rounded, color: Appcolors.ksecondarycolor, size: 28),
// //                                       const SizedBox(width: 12),
// //                                       const Text(
// //                                         'Untraceable Reason',
// //                                         style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
// //                                       ),
// //                                     ],
// //                                   ),
// //                                   const SizedBox(height: 16),
// //                                   const Text(
// //                                     'Please select the reason why the address is untraceable:',
// //                                     style: TextStyle(fontSize: 14, color: Colors.black87),
// //                                   ),
// //                                   const SizedBox(height: 16),
// //                                   DropdownButtonFormField<String>(
// //                                     decoration: InputDecoration(
// //                                       labelText: 'Reason *',
// //                                       labelStyle: TextStyle(color: Appcolors.kblackcolor.withOpacity(0.7)),
// //                                       border: OutlineInputBorder(
// //                                         borderRadius: BorderRadius.circular(12),
// //                                         borderSide: const BorderSide(color: Appcolors.kbordercolor),
// //                                       ),
// //                                       enabledBorder: OutlineInputBorder(
// //                                         borderRadius: BorderRadius.circular(12),
// //                                         borderSide: BorderSide(color: Appcolors.kbordercolor.withOpacity(0.5)),
// //                                       ),
// //                                       focusedBorder: OutlineInputBorder(
// //                                         borderRadius: BorderRadius.circular(12),
// //                                         borderSide: const BorderSide(color: Appcolors.kprimarycolor, width: 2),
// //                                       ),
// //                                       filled: true,
// //                                       fillColor: Appcolors.kwhitecolor,
// //                                       contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
// //                                     ),
// //                                     isExpanded: true,
// //                                     items: _untraceableReasons
// //                                         .map((r) => DropdownMenuItem(
// //                                               value: r,
// //                                               child: Text(
// //                                                 r,
// //                                                 overflow: TextOverflow.ellipsis,
// //                                                 maxLines: 2,
// //                                               ),
// //                                             ))
// //                                         .toList(),
// //                                     value: _untraceableReason,
// //                                     onChanged: (v) => setState(() => _untraceableReason = v),
// //                                     validator: (v) => (v == null || v.isEmpty) ? 'Please select reason for untraceable' : null,
// //                                   ),
// //                                 ],
// //                               ),
// //                             ),
// //                             const SizedBox(height: 16),
                            
// //                             // Image Gallery for untraceable
// //                             _buildImageGallery(),
// //                             const SizedBox(height: 16),
                            
// //                             // Document Upload for untraceable
// //                             _buildDocumentUpload(),
// //                             const SizedBox(height: 24),
                            
// //                             SizedBox(
// //                               width: double.infinity,
// //                               height: 50,
// //                               child: ElevatedButton(
// //                                 onPressed: _onSubmit,
// //                                 style: ElevatedButton.styleFrom(
// //                                   backgroundColor: Appcolors.kprimarycolor,
// //                                   foregroundColor: Appcolors.kwhitecolor,
// //                                   shape: RoundedRectangleBorder(
// //                                     borderRadius: BorderRadius.circular(12),
// //                                   ),
// //                                   elevation: 2,
// //                                 ),
// //                                 child: const Text('Submit', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
// //                               ),
// //                             ),
// //                             const SizedBox(height: 16),
// //                           ],
// //                         ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }

// import 'dart:convert';
// import 'dart:io';
// import 'package:arthor/core/colors.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:intl/intl.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:camera/camera.dart';

// /// AddressVerificationPage
// /// - Pass `sectionKey` as one of the available sections
// /// - Questions marked with required:true are validated before submit
// /// - Minimum 5 images required (camera only)
// /// - Optional document upload
// /// - Captures location, timestamp, and address for each image
// /// - Shows watermark in camera preview (not in captured image)
// class AddressVerificationPage extends StatefulWidget {
//   final String sectionKey;
//   const AddressVerificationPage({super.key, required this.sectionKey});

//   @override
//   State<AddressVerificationPage> createState() => _AddressVerificationPageState();
// }

// class _AddressVerificationPageState extends State<AddressVerificationPage> {
//   final _formKey = GlobalKey<FormState>();
//   final ImagePicker _picker = ImagePicker();
  
//   // Image and document storage with metadata
//   List<Map<String, dynamic>> _capturedImages = [];
//   PlatformFile? _uploadedDocument;

//   /// Form schema with required field validation
//   final Map<String, List<Map<String, dynamic>>> formSchema = {
//     "Present Residence": [
//       {"label": "Entry Allowed", "type": "dropdown", "options": ["Yes", "No"], "required": true},
//       {"label": "Met Person", "type": "text", "required": true},
//       {"label": "Relationship with Applicant", "type": "text", "required": true},
//       {"label": "Applicant age", "type": "text", "required": true},
//       {"label": "Rented/Owned/Leased", "type": "text", "required": true},
//       {"label": "Amount If Rent/Leased (type)", "type": "text", "required": false},
//       {"label": "Total Family Members", "type": "text", "required": true},
//       {"label": "No of members Working", "type": "text", "required": true},
//       {"label": "Names of Working Person", "type": "text", "required": true},
//       {"label": "No of members dependent", "type": "text", "required": true},
//       {"label": "Name of Dependent person", "type": "text", "required": false},
//       {"label": "Door number Displayed(Yes / No)", "type": "dropdown", "options": ["Yes", "No"], "required": true},
//       {"label": "Applicant working company name", "type": "text", "required": true},
//       {"label": "Designation", "type": "text", "required": true},
//       {"label": "Years of working", "type": "text", "required": true},
//       {"label": "Salary", "type": "text", "required": true},
//       {"label": "Type of Resi (RCC/ Tiled/ Sheet)", "type": "dropdown", "options": ["RCC", "Tiled", "Sheet"], "required": true},
//       {"label": "Independent/Part of independent/ Attached", "type": "text", "required": true},
//       {"label": "Floor", "type": "text", "required": true},
//       {"label": "Color", "type": "text", "required": true},
//       {"label": "Sqft", "type": "text", "required": true},
//       {"label": "Type of Area (Middle Class area/ Commercial area/Village area/Negative area/ slum area/Industrial Area)", "type": "text", "required": true},
//       {"label": "Landmark", "type": "text", "required": true},
//       {"label": "km", "type": "text", "required": true},
//       {"label": "Neighbour - 1", "type": "text", "required": true},
//       {"label": "Neighbour - 2", "type": "text", "required": true},
//       {"label": "Status", "type": "text", "required": true},
//     ],

//     "Business": [
//       {"label": "Entry Allowed", "type": "dropdown", "options": ["Yes", "No"], "required": true},
//       {"label": "Met Person", "type": "text", "required": true},
//       {"label": "Designation of the person met", "type": "text", "required": true},
//       {"label": "Designation of the Applicant", "type": "text", "required": true},
//       {"label": "Name of the company", "type": "text", "required": true},
//       {"label": "Years of working", "type": "text", "required": true},
//       {"label": "Salary", "type": "text", "required": true},
//       {"label": "Name board displayed", "type": "text", "required": true},
//       {"label": "No of Employees working", "type": "text", "required": true},
//       {"label": "Business activity (Good, Average, Poor)", "type": "text", "required": true},
//       {"label": "Stock (High, Medium, Less)", "type": "text", "required": true},
//       {"label": "Name board is displayed (Yes/No)", "type": "dropdown", "options": ["Yes", "No"], "required": true},
//       {"label": "Type of Area (Middle Class area/ Commercial area/Village area/Negative area/ slum area/Industrial Area)", "type": "text", "required": true},
//       {"label": "Status", "type": "text", "required": true},
//     ],

//     "Permanent Residence": [
//       {"label": "Entry Allowed", "type": "dropdown", "options": ["Yes", "No"], "required": true},
//       {"label": "Met Person", "type": "text", "required": true},
//       {"label": "Relationship with Applicant", "type": "text", "required": true},
//       {"label": "Applicant age", "type": "text", "required": true},
//       {"label": "Rented/Owned/Leased", "type": "text", "required": true},
//       {"label": "Amount If Rent/Leased (type)", "type": "text", "required": false},
//       {"label": "Total Family Members", "type": "text", "required": true},
//       {"label": "No of members Working", "type": "text", "required": true},
//       {"label": "Names of Working Person", "type": "text", "required": true},
//       {"label": "Name of Dependent person", "type": "text", "required": false},
//       {"label": "Neighbour - 1", "type": "text", "required": true},
//       {"label": "Neighbour - 2", "type": "text", "required": true},
//       {"label": "Status", "type": "text", "required": true},
//     ],

//     "Resi c...er Verification": [
//       {"label": "Document Verification - Name of the document", "type": "text", "required": true},
//       {"label": "Met Person", "type": "text", "required": true},
//       {"label": "Relationship with Applicant", "type": "text", "required": true},
//       {"label": "Property (Yes/No)", "type": "dropdown", "options": ["Yes", "No"], "required": true},
//       {"label": "Confirmation on Document(Yes/ No)", "type": "dropdown", "options": ["Yes", "No"], "required": true},
//       {"label": "Name board is displayed (Yes/No)", "type": "dropdown", "options": ["Yes", "No"], "required": true},
//       {"label": "Name of the asset", "type": "text", "required": true},
//       {"label": "Designation", "type": "text", "required": true},
//       {"label": "Relationship with Seller", "type": "text", "required": true},
//       {"label": "Applicant age", "type": "text", "required": true},
//       {"label": "Rented/Owned/Leased", "type": "text", "required": true},
//       {"label": "Name board displayed (Yes/No)", "type": "dropdown", "options": ["Yes", "No"], "required": true},
//       {"label": "Total Family Members", "type": "text", "required": true},
//       {"label": "No of members Working", "type": "text", "required": true},
//       {"label": "Sqft", "type": "text", "required": true},
//       {"label": "Floor", "type": "text", "required": true},
//       {"label": "Status", "type": "text", "required": true},
//     ],

//     "Document Verification": [
//       {"label": "Type of asset", "type": "text", "required": true},
//       {"label": "Met Person", "type": "text", "required": true},
//       {"label": "Relationship with Applicant", "type": "text", "required": true},
//       {"label": "Designation", "type": "text", "required": true},
//       {"label": "Relationship with Applicant", "type": "text", "required": true},
//       {"label": "Applicant age", "type": "text", "required": true},
//       {"label": "Rented/Owned/Leased", "type": "text", "required": true},
//       {"label": "Amount If Rent/Leased (type)", "type": "text", "required": false},
//       {"label": "Total Family Members", "type": "text", "required": true},
//       {"label": "Department", "type": "text", "required": true},
//       {"label": "Sqft", "type": "text", "required": true},
//       {"label": "Floor", "type": "text", "required": true},
//       {"label": "Status", "type": "text", "required": true},
//     ],

//     "Asset Verification": [
//       {"label": "Name of the asset", "type": "text", "required": true},
//       {"label": "Met Person", "type": "text", "required": true},
//       {"label": "Relationship with Applicant", "type": "text", "required": true},
//       {"label": "Designation", "type": "text", "required": true},
//       {"label": "Relationship with Applicant", "type": "text", "required": true},
//       {"label": "Applicant age", "type": "text", "required": true},
//       {"label": "Rented/Owned/Leased", "type": "text", "required": true},
//       {"label": "Amount If Rent/Leased (type)", "type": "text", "required": false},
//       {"label": "Sqft", "type": "text", "required": true},
//       {"label": "No of members Working", "type": "text", "required": true},
//       {"label": "No of members dependent", "type": "text", "required": true},
//       {"label": "Designation", "type": "text", "required": true},
//       {"label": "Status", "type": "text", "required": true},
//     ],
//   };

//   String? _traceable;
//   String? _untraceableReason;
//   final List<String> _traceableOptions = ['traceable', 'untraceable'];
//   final List<String> _untraceableReasons = [
//     'address insufficient',
//     'address insufficient and difficult to locate',
//     'applicant not responding phonecall',
//     'loan cancel',
//   ];

//   final Map<String, dynamic> answers = {};

//   @override
//   void initState() {
//     super.initState();
//     final fields = formSchema[widget.sectionKey] ?? [];
//     for (var f in fields) {
//       answers[f['label']] = null;
//     }
//     answers['is_traceable'] = null;
//     answers['untraceable_reason'] = null;
//     _requestPermissions();
//   }

//   // Request necessary permissions
//   Future<void> _requestPermissions() async {
//     await Permission.camera.request();
//     await Permission.location.request();
//   }

//   // Get current location and address
//   Future<Map<String, dynamic>?> _getCurrentLocationData() async {
//     try {
//       // Check if location services are enabled
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

//       // Check location permission
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

//       // Show loading indicator
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

//       // Get current position
//       Position position = await Geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy.high,
//       );

//       // Get address from coordinates
//       String address = 'Address not available';
//       try {
//         List<Placemark> placemarks = await placemarkFromCoordinates(
//           position.latitude,
//           position.longitude,
//         );
        
//         if (placemarks.isNotEmpty) {
//           Placemark place = placemarks[0];
//           address = '${place.street ?? ''}, ${place.subLocality ?? ''}, ${place.locality ?? ''}, ${place.administrativeArea ?? ''}, ${place.postalCode ?? ''}, ${place.country ?? ''}'
//               .replaceAll(RegExp(r',\s*,'), ',')
//               .replaceAll(RegExp(r'^,\s*|,\s*$'), '')
//               .trim();
//         }
//       } catch (e) {
//         debugPrint('Error getting address: $e');
//         address = 'Lat: ${position.latitude.toStringAsFixed(6)}, Long: ${position.longitude.toStringAsFixed(6)}';
//       }

//       // Get current date and time
//       DateTime now = DateTime.now();
//       String formattedDateTime = DateFormat('dd-MM-yyyy HH:mm:ss').format(now);

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

//   // Camera capture function with location data - Opens custom camera with watermark
//   Future<void> _captureImage() async {
//     try {
//       // First get location data
//       final locationData = await _getCurrentLocationData();
      
//       if (locationData == null) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(
//             content: Text('Cannot capture image without location data'),
//             backgroundColor: Colors.red,
//           ),
//         );
//         return;
//       }

//       // Open custom camera with watermark
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

//       final XFile? photo = await Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => CameraWithWatermark(
//             camera: cameras.first,
//             locationData: locationData,
//           ),
//         ),
//       );
      
//       if (photo != null) {
//         setState(() {
//           _capturedImages.add({
//             'image': photo,
//             'latitude': locationData['latitude'],
//             'longitude': locationData['longitude'],
//             'address': locationData['address'],
//             'timestamp': locationData['timestamp'],
//             'raw_timestamp': locationData['raw_timestamp'],
//           });
//         });
        
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text('Image ${_capturedImages.length} captured with location'),
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

//   // Remove image function
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

//   // Show image details dialog - FIXED: Added proper constraints
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
//                     Text('Image ${index + 1} Details', 
//                       style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
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
//                       _buildDetailRow(Icons.calendar_today, 'Date & Time', imageData['timestamp']),
//                       const Divider(),
//                       _buildDetailRow(Icons.my_location, 'Latitude', imageData['latitude'].toStringAsFixed(6)),
//                       const Divider(),
//                       _buildDetailRow(Icons.location_on, 'Longitude', imageData['longitude'].toStringAsFixed(6)),
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

//   // Document picker function
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

//   // Remove document function
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

//   Widget _buildField(Map<String, dynamic> field) {
//     final label = field['label'] as String;
//     final type = field['type'] as String;
//     final required = field['required'] as bool? ?? true;

//     if (type == 'dropdown') {
//       final List<dynamic> opts = field['options'] ?? [];
//       return Padding(
//         padding: const EdgeInsets.only(bottom: 16.0),
//         child: DropdownButtonFormField<String>(
//           decoration: InputDecoration(
//             labelText: required ? '$label *' : label,
//             labelStyle: TextStyle(color: Appcolors.kblackcolor.withOpacity(0.7)),
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(12),
//               borderSide: const BorderSide(color: Appcolors.kbordercolor),
//             ),
//             enabledBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(12),
//               borderSide: BorderSide(color: Appcolors.kbordercolor.withOpacity(0.5)),
//             ),
//             focusedBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(12),
//               borderSide: const BorderSide(color: Appcolors.kprimarycolor, width: 2),
//             ),
//             filled: true,
//             fillColor: Appcolors.kwhitecolor,
//             contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
//           ),
//           items: opts.map((o) => DropdownMenuItem(value: o.toString(), child: Text(o.toString()))).toList(),
//           value: answers[label],
//           onChanged: (v) => setState(() => answers[label] = v),
//           validator: required ? (v) => (v == null || v.isEmpty) ? 'Please select $label' : null : null,
//         ),
//       );
//     } else {
//       return Padding(
//         padding: const EdgeInsets.only(bottom: 16.0),
//         child: TextFormField(
//           initialValue: answers[label],
//           decoration: InputDecoration(
//             labelText: required ? '$label *' : label,
//             labelStyle: TextStyle(color: Appcolors.kblackcolor.withOpacity(0.7)),
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(12),
//               borderSide: const BorderSide(color: Appcolors.kbordercolor),
//             ),
//             enabledBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(12),
//               borderSide: BorderSide(color: Appcolors.kbordercolor.withOpacity(0.5)),
//             ),
//             focusedBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(12),
//               borderSide: const BorderSide(color: Appcolors.kprimarycolor, width: 2),
//             ),
//             filled: true,
//             fillColor: Appcolors.kwhitecolor,
//             contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
//           ),
//           onChanged: (v) => answers[label] = v,
//           validator: required ? (v) => (v == null || v.trim().isEmpty) ? 'Please enter $label' : null : null,
//         ),
//       );
//     }
//   }

//   // Image gallery widget with location info
//   Widget _buildImageGallery() {
//     return Container(
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Appcolors.kwhitecolor,
//         borderRadius: BorderRadius.circular(12),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.05),
//             blurRadius: 4,
//             offset: const Offset(0, 2),
//           )
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               Icon(Icons.camera_alt, color: Appcolors.kprimarycolor),
//               const SizedBox(width: 8),
//               const Text(
//                 'Verification Images',
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//               ),
//               const Spacer(),
//               Container(
//                 padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//                 decoration: BoxDecoration(
//                   color: _capturedImages.length >= 5 ? Colors.green : Colors.orange,
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//                 child: Text(
//                   '${_capturedImages.length}/5 min',
//                   style: const TextStyle(
//                     color: Colors.white,
//                     fontSize: 12,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 12),
//           Row(
//             children: [
//               Icon(Icons.location_on, size: 16, color: Colors.grey[600]),
//               const SizedBox(width: 4),
//               Expanded(
//                 child: Text(
//                   'Images captured with GPS location & timestamp',
//                   style: TextStyle(
//                     fontSize: 12,
//                     color: Colors.grey[600],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 8),
//           Text(
//             'Minimum 5 images required *',
//             style: TextStyle(
//               fontSize: 13,
//               color: _capturedImages.length < 5 ? Colors.red : Colors.green,
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//           const SizedBox(height: 16),
          
//           // Display captured images
//           if (_capturedImages.isNotEmpty)
//             GridView.builder(
//               shrinkWrap: true,
//               physics: const NeverScrollableScrollPhysics(),
//               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 3,
//                 crossAxisSpacing: 8,
//                 mainAxisSpacing: 8,
//               ),
//               itemCount: _capturedImages.length,
//               itemBuilder: (context, index) {
//                 final imageData = _capturedImages[index];
//                 return Stack(
//                   children: [
//                     GestureDetector(
//                       onTap: () => _showImageDetails(imageData, index),
//                       child: ClipRRect(
//                         borderRadius: BorderRadius.circular(8),
//                         child: Image.file(
//                           File(imageData['image'].path),
//                           fit: BoxFit.cover,
//                           width: double.infinity,
//                           height: double.infinity,
//                         ),
//                       ),
//                     ),
//                     // Info button
//                     Positioned(
//                       top: 4,
//                       left: 4,
//                       child: GestureDetector(
//                         onTap: () => _showImageDetails(imageData, index),
//                         child: Container(
//                           padding: const EdgeInsets.all(4),
//                           decoration: const BoxDecoration(
//                             color: Colors.blue,
//                             shape: BoxShape.circle,
//                           ),
//                           child: const Icon(
//                             Icons.info,
//                             size: 14,
//                             color: Colors.white,
//                           ),
//                         ),
//                       ),
//                     ),
//                     // Delete button
//                     Positioned(
//                       top: 4,
//                       right: 4,
//                       child: GestureDetector(
//                         onTap: () => _removeImage(index),
//                         child: Container(
//                           padding: const EdgeInsets.all(4),
//                           decoration: const BoxDecoration(
//                             color: Colors.red,
//                             shape: BoxShape.circle,
//                           ),
//                           child: const Icon(
//                             Icons.close,
//                             size: 14,
//                             color: Colors.white,
//                           ),
//                         ),
//                       ),
//                     ),
//                     // Image number
//             Positioned(
//   bottom: 4,
//   left: 4,
//   child: Container(
//     padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
//     decoration: BoxDecoration(
//       color: Colors.black54,
//       borderRadius: BorderRadius.circular(4),
//     ),
//     child: Row(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         const Icon(Icons.location_on, size: 10, color: Colors.white),
//         const SizedBox(width: 2),
//         Text(
//           '${index + 1}',
//           style: const TextStyle(
//             color: Colors.white,
//             fontSize: 10,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//       ],
//     ),
//   ),
// ),

//                   ],
//                 );
//               },
//             ),
          
//           const SizedBox(height: 16),
//           SizedBox(
//             width: double.infinity,
//             height: 50,
//             child: OutlinedButton.icon(
//               onPressed: _captureImage,
//               icon: const Icon(Icons.camera_alt),
//               label: const Text('Capture Image with Location'),
//               style: OutlinedButton.styleFrom(
//                 foregroundColor: Appcolors.kprimarycolor,
//                 side: BorderSide(color: Appcolors.kprimarycolor, width: 2),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // Document upload widget
//   Widget _buildDocumentUpload() {
//     return Container(
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Appcolors.kwhitecolor,
//         borderRadius: BorderRadius.circular(12),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.05),
//             blurRadius: 4,
//             offset: const Offset(0, 2),
//           )
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               Icon(Icons.insert_drive_file, color: Appcolors.kprimarycolor),
//               const SizedBox(width: 8),
//               const Text(
//                 'Supporting Document',
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//               ),
//             ],
//           ),
//           const SizedBox(height: 8),
//           const Text(
//             'Optional - PDF, DOC, DOCX, or Images',
//             style: TextStyle(fontSize: 13, color: Colors.black54),
//           ),
//           const SizedBox(height: 16),
          
//           if (_uploadedDocument != null)
//             Container(
//               padding: const EdgeInsets.all(12),
//               decoration: BoxDecoration(
//                 color: Colors.green.withOpacity(0.1),
//                 borderRadius: BorderRadius.circular(8),
//                 border: Border.all(color: Colors.green, width: 1),
//               ),
//               child: Row(
//                 children: [
//                   const Icon(Icons.check_circle, color: Colors.green, size: 24),
//                   const SizedBox(width: 12),
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           _uploadedDocument!.name,
//                           style: const TextStyle(
//                             fontWeight: FontWeight.w500,
//                             fontSize: 14,
//                           ),
//                           maxLines: 1,
//                           overflow: TextOverflow.ellipsis,
//                         ),
//                         Text(
//                           '${(_uploadedDocument!.size / 1024).toStringAsFixed(2)} KB',
//                           style: const TextStyle(
//                             fontSize: 12,
//                             color: Colors.black54,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   IconButton(
//                     onPressed: _removeDocument,
//                     icon: const Icon(Icons.delete, color: Colors.red),
//                   ),
//                 ],
//               ),
//             )
//           else
//             SizedBox(
//               width: double.infinity,
//               height: 50,
//               child: OutlinedButton.icon(
//                 onPressed: _pickDocument,
//                 icon: const Icon(Icons.upload_file),
//                 label: const Text('Upload Document'),
//                 style: OutlinedButton.styleFrom(
//                   foregroundColor: Appcolors.kprimarycolor,
//                   side: BorderSide(color: Appcolors.kprimarycolor.withOpacity(0.5), width: 1.5),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                 ),
//               ),
//             ),
//         ],
//       ),
//     );
//   }

//   void _onSubmit() {
//     // Validate form fields
//     if (!_formKey.currentState!.validate()) return;

//     // Validate minimum images
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
//       answers['is_traceable'] = 'untraceable';
//       answers['untraceable_reason'] = _untraceableReason;
//     } else {
//       answers['is_traceable'] = 'traceable';
//       answers['untraceable_reason'] = null;
//     }

//     // Prepare images data with location info
//     final imagesData = _capturedImages.map((imgData) => {
//       'image_path': imgData['image'].path,
//       'latitude': imgData['latitude'],
//       'longitude': imgData['longitude'],
//       'address': imgData['address'],
//       'timestamp': imgData['timestamp'],
//       'raw_timestamp': imgData['raw_timestamp'],
//     }).toList();

//     // Log all images data
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
//       'answers': answers,
//       'images': imagesData,
//       'image_count': _capturedImages.length,
//       'document': _uploadedDocument != null ? {
//         'name': _uploadedDocument!.name,
//         'path': _uploadedDocument!.path,
//         'size': _uploadedDocument!.size,
//       } : null,
//     };

//     final jsonStr = jsonEncode(payload);
//     debugPrint(jsonStr);
    
//     showDialog(
//       context: context,
//       builder: (_) => AlertDialog(
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//         title: Row(
//           children: [
//             Icon(Icons.check_circle, color: Appcolors.kprimarycolor, size: 28),
//             const SizedBox(width: 12),
//             const Text('Submitted Successfully', style: TextStyle(fontSize: 18)),
//           ],
//         ),
//         content: SingleChildScrollView(
//           child: Container(
//             padding: const EdgeInsets.all(12),
//             decoration: BoxDecoration(
//               color: Colors.grey[100],
//               borderRadius: BorderRadius.circular(8),
//             ),
//             child: Text(jsonStr, style: const TextStyle(fontSize: 12, fontFamily: 'monospace')),
//           ),
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             style: TextButton.styleFrom(
//               foregroundColor: Appcolors.kprimarycolor,
//               padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
//             ),
//             child: const Text('OK', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
//           )
//         ],
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final fields = formSchema[widget.sectionKey] ?? [];
//     return Scaffold(
//       backgroundColor: Colors.grey[50],
//       appBar: AppBar(
//         backgroundColor: Appcolors.kprimarycolor,
//         foregroundColor: Appcolors.kwhitecolor,
//         elevation: 0,
//         title: Text('Verification - ${widget.sectionKey}'),
//         centerTitle: false,
//       ),
//       body: Form(
//         key: _formKey,
//         child: Column(
//           children: [
//             // Traceable/Untraceable Section
//             Container(
//               width: double.infinity,
//               padding: const EdgeInsets.all(16),
//               decoration: BoxDecoration(
//                 color: Appcolors.kwhitecolor,
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black.withOpacity(0.05),
//                     blurRadius: 4,
//                     offset: const Offset(0, 2),
//                   )
//                 ],
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     'Address Traceability',
//                     style: TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                       color: Appcolors.kblackcolor,
//                     ),
//                   ),
//                   const SizedBox(height: 12),
//                   DropdownButtonFormField<String>(
//                     decoration: InputDecoration(
//                       labelText: 'Is the address traceable? *',
//                       labelStyle: TextStyle(color: Appcolors.kblackcolor.withOpacity(0.7)),
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(12),
//                         borderSide: const BorderSide(color: Appcolors.kbordercolor),
//                       ),
//                       enabledBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(12),
//                         borderSide: BorderSide(color: Appcolors.kbordercolor.withOpacity(0.5)),
//                       ),
//                       focusedBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(12),
//                         borderSide: const BorderSide(color: Appcolors.kprimarycolor, width: 2),
//                       ),
//                       filled: true,
//                       fillColor: Appcolors.kwhitecolor,
//                       contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
//                     ),
//                     items: _traceableOptions.map((o) => DropdownMenuItem(value: o, child: Text(o.toUpperCase()))).toList(),
//                     value: _traceable,
//                     onChanged: (v) => setState(() {
//                       _traceable = v;
//                       answers['is_traceable'] = _traceable;
//                       if (v == 'traceable') {
//                         _untraceableReason = null;
//                         answers['untraceable_reason'] = null;
//                       }
//                     }),
//                     validator: (v) => (v == null || v.isEmpty) ? 'Please select whether address is traceable' : null,
//                   ),
//                 ],
//               ),
//             ),

//             // Main Content Area
//             Expanded(
//               child: _traceable == null
//                   ? Center(
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Icon(Icons.arrow_upward, size: 48, color: Colors.grey[400]),
//                           const SizedBox(height: 16),
//                           Text(
//                             'Please select traceability status above',
//                             style: TextStyle(fontSize: 16, color: Colors.grey[600]),
//                           ),
//                         ],
//                       ),
//                     )
//                   : _traceable == 'traceable'
//                       ? ListView(
//                           padding: const EdgeInsets.all(16),
//                           children: [
//                             Container(
//                               padding: const EdgeInsets.all(16),
//                               decoration: BoxDecoration(
//                                 color: Appcolors.kwhitecolor,
//                                 borderRadius: BorderRadius.circular(12),
//                                 boxShadow: [
//                                   BoxShadow(
//                                     color: Colors.black.withOpacity(0.05),
//                                     blurRadius: 4,
//                                     offset: const Offset(0, 2),
//                                   )
//                                 ],
//                               ),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Row(
//                                     children: [
//                                       Icon(Icons.assignment, color: Appcolors.kprimarycolor),
//                                       const SizedBox(width: 8),
//                                       const Text(
//                                         'Verification Details',
//                                         style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                                       ),
//                                     ],
//                                   ),
//                                   const SizedBox(height: 16),
//                                   ...fields.map((f) => _buildField(f)).toList(),
//                                 ],
//                               ),
//                             ),
//                             const SizedBox(height: 16),
                            
//                             // Image Gallery
//                             _buildImageGallery(),
//                             const SizedBox(height: 16),
                            
//                             // Document Upload
//                             _buildDocumentUpload(),
//                             const SizedBox(height: 24),
                            
//                             SizedBox(
//                               width: double.infinity,
//                               height: 50,
//                               child: ElevatedButton(
//                                 onPressed: _onSubmit,
//                                 style: ElevatedButton.styleFrom(
//                                   backgroundColor: Appcolors.kprimarycolor,
//                                   foregroundColor: Appcolors.kwhitecolor,
//                                   shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(12),
//                                   ),
//                                   elevation: 2,
//                                 ),
//                                 child: const Text('Submit Verification', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
//                               ),
//                             ),
//                             const SizedBox(height: 16),
//                           ],
//                         )
//                       : ListView(
//                           padding: const EdgeInsets.all(16),
//                           children: [
//                             Container(
//                               padding: const EdgeInsets.all(16),
//                               decoration: BoxDecoration(
//                                 color: Appcolors.kwhitecolor,
//                                 borderRadius: BorderRadius.circular(12),
//                                 boxShadow: [
//                                   BoxShadow(
//                                     color: Colors.black.withOpacity(0.05),
//                                     blurRadius: 4,
//                                     offset: const Offset(0, 2),
//                                   )
//                                 ],
//                               ),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Row(
//                                     children: [
//                                       Icon(Icons.warning_amber_rounded, color: Appcolors.ksecondarycolor, size: 28),
//                                       const SizedBox(width: 12),
//                                       const Text(
//                                         'Untraceable Reason',
//                                         style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                                       ),
//                                     ],
//                                   ),
//                                   const SizedBox(height: 16),
//                                   const Text(
//                                     'Please select the reason why the address is untraceable:',
//                                     style: TextStyle(fontSize: 14, color: Colors.black87),
//                                   ),
//                                   const SizedBox(height: 16),
//                                   DropdownButtonFormField<String>(
//                                     decoration: InputDecoration(
//                                       labelText: 'Reason *',
//                                       labelStyle: TextStyle(color: Appcolors.kblackcolor.withOpacity(0.7)),
//                                       border: OutlineInputBorder(
//                                         borderRadius: BorderRadius.circular(12),
//                                         borderSide: const BorderSide(color: Appcolors.kbordercolor),
//                                       ),
//                                       enabledBorder: OutlineInputBorder(
//                                         borderRadius: BorderRadius.circular(12),
//                                         borderSide: BorderSide(color: Appcolors.kbordercolor.withOpacity(0.5)),
//                                       ),
//                                       focusedBorder: OutlineInputBorder(
//                                         borderRadius: BorderRadius.circular(12),
//                                         borderSide: const BorderSide(color: Appcolors.kprimarycolor, width: 2),
//                                       ),
//                                       filled: true,
//                                       fillColor: Appcolors.kwhitecolor,
//                                       contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
//                                     ),
//                                     isExpanded: true,
//                                     items: _untraceableReasons
//                                         .map((r) => DropdownMenuItem(
//                                               value: r,
//                                               child: Text(
//                                                 r,
//                                                 overflow: TextOverflow.ellipsis,
//                                                 maxLines: 2,
//                                               ),
//                                             ))
//                                         .toList(),
//                                     value: _untraceableReason,
//                                     onChanged: (v) => setState(() => _untraceableReason = v),
//                                     validator: (v) => (v == null || v.isEmpty) ? 'Please select reason for untraceable' : null,
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             const SizedBox(height: 16),
                            
//                             // Image Gallery for untraceable
//                             _buildImageGallery(),
//                             const SizedBox(height: 16),
                            
//                             // Document Upload for untraceable
//                             _buildDocumentUpload(),
//                             const SizedBox(height: 24),
                            
//                             SizedBox(
//                               width: double.infinity,
//                               height: 50,
//                               child: ElevatedButton(
//                                 onPressed: _onSubmit,
//                                 style: ElevatedButton.styleFrom(
//                                   backgroundColor: Appcolors.kprimarycolor,
//                                   foregroundColor: Appcolors.kwhitecolor,
//                                   shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(12),
//                                   ),
//                                   elevation: 2,
//                                 ),
//                                 child: const Text('Submit', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
//                               ),
//                             ),
//                             const SizedBox(height: 16),
//                           ],
//                         ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// // Custom Camera Screen with Watermark Overlay
// class CameraWithWatermark extends StatefulWidget {
//   final CameraDescription camera;
//   final Map<String, dynamic> locationData;

//   const CameraWithWatermark({
//     Key? key,
//     required this.camera,
//     required this.locationData,
//   }) : super(key: key);

//   @override
//   State<CameraWithWatermark> createState() => _CameraWithWatermarkState();
// }

// class _CameraWithWatermarkState extends State<CameraWithWatermark> {
//   late CameraController _controller;
//   late Future<void> _initializeControllerFuture;

//   @override
//   void initState() {
//     super.initState();
//     _controller = CameraController(
//       widget.camera,
//       ResolutionPreset.high,
//     );
//     _initializeControllerFuture = _controller.initialize();
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   Future<void> _takePicture() async {
//     try {
//       await _initializeControllerFuture;
//       final image = await _controller.takePicture();
      
//       if (mounted) {
//         Navigator.pop(context, image);
//       }
//     } catch (e) {
//       debugPrint('Error taking picture: $e');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: FutureBuilder<void>(
//         future: _initializeControllerFuture,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.done) {
//             return Stack(
//               children: [
//                 // Camera Preview
//                 Positioned.fill(
//                   child: CameraPreview(_controller),
//                 ),
                
//                 // Watermark Overlay (only visible in preview)
//                 Positioned(
//                   left: 16,
//                   right: 16,
//                   bottom: 120,
//                   child: Container(
//                     padding: const EdgeInsets.all(12),
//                     decoration: BoxDecoration(
//                       color: Colors.black.withOpacity(0.7),
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         _buildWatermarkRow(
//                           Icons.calendar_today,
//                           'Date & Time',
//                           widget.locationData['timestamp'],
//                         ),
//                         const Divider(color: Colors.white24, height: 16),
//                         _buildWatermarkRow(
//                           Icons.my_location,
//                           'Latitude',
//                           widget.locationData['latitude'].toStringAsFixed(6),
//                         ),
//                         const Divider(color: Colors.white24, height: 16),
//                         _buildWatermarkRow(
//                           Icons.location_on,
//                           'Longitude',
//                           widget.locationData['longitude'].toStringAsFixed(6),
//                         ),
//                         const Divider(color: Colors.white24, height: 16),
//                         _buildWatermarkRow(
//                           Icons.home,
//                           'Address',
//                           widget.locationData['address'],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
                
//                 // Close button
//                 Positioned(
//                   top: 40,
//                   left: 16,
//                   child: IconButton(
//                     onPressed: () => Navigator.pop(context),
//                     icon: const Icon(Icons.close, color: Colors.white, size: 32),
//                   ),
//                 ),
                
//                 // Capture button
//                 Positioned(
//                   bottom: 30,
//                   left: 0,
//                   right: 0,
//                   child: Center(
//                     child: GestureDetector(
//                       onTap: _takePicture,
//                       child: Container(
//                         width: 70,
//                         height: 70,
//                         decoration: BoxDecoration(
//                           shape: BoxShape.circle,
//                           border: Border.all(color: Colors.white, width: 4),
//                         ),
//                         child: Container(
//                           margin: const EdgeInsets.all(4),
//                           decoration: const BoxDecoration(
//                             color: Colors.white,
//                             shape: BoxShape.circle,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             );
//           } else {
//             return const Center(
//               child: CircularProgressIndicator(color: Colors.white),
//             );
//           }
//         },
//       ),
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
import 'dart:convert';
import 'dart:io';
import 'package:arthor/core/colors.dart';
import 'package:arthor/core/responsiveutils.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:camera/camera.dart';

/// AddressVerificationPage
/// - Pass `sectionKey` as one of the available sections
/// - Questions marked with required:true are validated before submit
/// - Minimum 5 images required (camera only)
/// - Optional document upload
/// - Captures location, timestamp, and address for each image
/// - Shows watermark in camera preview (not in captured image)
class AddressVerificationPage extends StatefulWidget {
  final String sectionKey;
  const AddressVerificationPage({super.key, required this.sectionKey});

  @override
  State<AddressVerificationPage> createState() => _AddressVerificationPageState();
}

class _AddressVerificationPageState extends State<AddressVerificationPage> {
  final _formKey = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();
  
  // Image and document storage with metadata
  List<Map<String, dynamic>> _capturedImages = [];
  PlatformFile? _uploadedDocument;

  // Cached location data to avoid fetching repeatedly before camera
  Map<String, dynamic>? _cachedLocationData;
  StreamSubscription<Position>? _positionStreamSub;

  /// Form schema with required field validation
  final Map<String, List<Map<String, dynamic>>> formSchema = {
    "Present Residence": [
      {"label": "Entry Allowed", "type": "dropdown", "options": ["Yes", "No"], "required": true},
      {"label": "Met Person", "type": "text", "required": true},
      {"label": "Relationship with Applicant", "type": "text", "required": true},
      {"label": "Applicant age", "type": "text", "required": true},
      {"label": "Rented/Owned/Leased", "type": "text", "required": true},
      {"label": "Amount If Rent/Leased (type)", "type": "text", "required": false},
      {"label": "Total Family Members", "type": "text", "required": true},
      {"label": "No of members Working", "type": "text", "required": true},
      {"label": "Names of Working Person", "type": "text", "required": true},
      {"label": "No of members dependent", "type": "text", "required": true},
      {"label": "Name of Dependent person", "type": "text", "required": false},
      {"label": "Door number Displayed(Yes / No)", "type": "dropdown", "options": ["Yes", "No"], "required": true},
      {"label": "Applicant working company name", "type": "text", "required": true},
      {"label": "Designation", "type": "text", "required": true},
      {"label": "Years of working", "type": "text", "required": true},
      {"label": "Salary", "type": "text", "required": true},
      {"label": "Type of Resi (RCC/ Tiled/ Sheet)", "type": "dropdown", "options": ["RCC", "Tiled", "Sheet"], "required": true},
      {"label": "Independent/Part of independent/ Attached", "type": "text", "required": true},
      {"label": "Floor", "type": "text", "required": true},
      {"label": "Color", "type": "text", "required": true},
      {"label": "Sqft", "type": "text", "required": true},
      {"label": "Type of Area (Middle Class area/ Commercial area/Village area/Negative area/ slum area/Industrial Area)", "type": "text", "required": true},
      {"label": "Landmark", "type": "text", "required": true},
      {"label": "km", "type": "text", "required": true},
      {"label": "Neighbour - 1", "type": "text", "required": true},
      {"label": "Neighbour - 2", "type": "text", "required": true},
      {"label": "Status", "type": "text", "required": true},
    ],

    "Business": [
      {"label": "Entry Allowed", "type": "dropdown", "options": ["Yes", "No"], "required": true},
      {"label": "Met Person", "type": "text", "required": true},
      {"label": "Designation of the person met", "type": "text", "required": true},
      {"label": "Designation of the Applicant", "type": "text", "required": true},
      {"label": "Name of the company", "type": "text", "required": true},
      {"label": "Years of working", "type": "text", "required": true},
      {"label": "Salary", "type": "text", "required": true},
      {"label": "Name board displayed", "type": "text", "required": true},
      {"label": "No of Employees working", "type": "text", "required": true},
      {"label": "Business activity (Good, Average, Poor)", "type": "text", "required": true},
      {"label": "Stock (High, Medium, Less)", "type": "text", "required": true},
      {"label": "Name board is displayed (Yes/No)", "type": "dropdown", "options": ["Yes", "No"], "required": true},
      {"label": "Type of Area (Middle Class area/ Commercial area/Village area/Negative area/ slum area/Industrial Area)", "type": "text", "required": true},
      {"label": "Status", "type": "text", "required": true},
    ],

    "Permanent Residence": [
      {"label": "Entry Allowed", "type": "dropdown", "options": ["Yes", "No"], "required": true},
      {"label": "Met Person", "type": "text", "required": true},
      {"label": "Relationship with Applicant", "type": "text", "required": true},
      {"label": "Applicant age", "type": "text", "required": true},
      {"label": "Rented/Owned/Leased", "type": "text", "required": true},
      {"label": "Amount If Rent/Leased (type)", "type": "text", "required": false},
      {"label": "Total Family Members", "type": "text", "required": true},
      {"label": "No of members Working", "type": "text", "required": true},
      {"label": "Names of Working Person", "type": "text", "required": true},
      {"label": "Name of Dependent person", "type": "text", "required": false},
      {"label": "Neighbour - 1", "type": "text", "required": true},
      {"label": "Neighbour - 2", "type": "text", "required": true},
      {"label": "Status", "type": "text", "required": true},
    ],

    "Resi c...er Verification": [
      {"label": "Document Verification - Name of the document", "type": "text", "required": true},
      {"label": "Met Person", "type": "text", "required": true},
      {"label": "Relationship with Applicant", "type": "text", "required": true},
      {"label": "Property (Yes/No)", "type": "dropdown", "options": ["Yes", "No"], "required": true},
      {"label": "Confirmation on Document(Yes/ No)", "type": "dropdown", "options": ["Yes", "No"], "required": true},
      {"label": "Name board is displayed (Yes/No)", "type": "dropdown", "options": ["Yes", "No"], "required": true},
      {"label": "Name of the asset", "type": "text", "required": true},
      {"label": "Designation", "type": "text", "required": true},
      {"label": "Relationship with Seller", "type": "text", "required": true},
      {"label": "Applicant age", "type": "text", "required": true},
      {"label": "Rented/Owned/Leased", "type": "text", "required": true},
      {"label": "Name board displayed (Yes/No)", "type": "dropdown", "options": ["Yes", "No"], "required": true},
      {"label": "Total Family Members", "type": "text", "required": true},
      {"label": "No of members Working", "type": "text", "required": true},
      {"label": "Sqft", "type": "text", "required": true},
      {"label": "Floor", "type": "text", "required": true},
      {"label": "Status", "type": "text", "required": true},
    ],

    "Document Verification": [
      {"label": "Type of asset", "type": "text", "required": true},
      {"label": "Met Person", "type": "text", "required": true},
      {"label": "Relationship with Applicant", "type": "text", "required": true},
      {"label": "Designation", "type": "text", "required": true},
      {"label": "Relationship with Applicant", "type": "text", "required": true},
      {"label": "Applicant age", "type": "text", "required": true},
      {"label": "Rented/Owned/Leased", "type": "text", "required": true},
      {"label": "Amount If Rent/Leased (type)", "type": "text", "required": false},
      {"label": "Total Family Members", "type": "text", "required": true},
      {"label": "Department", "type": "text", "required": true},
      {"label": "Sqft", "type": "text", "required": true},
      {"label": "Floor", "type": "text", "required": true},
      {"label": "Status", "type": "text", "required": true},
    ],

    "Asset Verification": [
      {"label": "Name of the asset", "type": "text", "required": true},
      {"label": "Met Person", "type": "text", "required": true},
      {"label": "Relationship with Applicant", "type": "text", "required": true},
      {"label": "Designation", "type": "text", "required": true},
      {"label": "Relationship with Applicant", "type": "text", "required": true},
      {"label": "Applicant age", "type": "text", "required": true},
      {"label": "Rented/Owned/Leased", "type": "text", "required": true},
      {"label": "Amount If Rent/Leased (type)", "type": "text", "required": false},
      {"label": "Sqft", "type": "text", "required": true},
      {"label": "No of members Working", "type": "text", "required": true},
      {"label": "No of members dependent", "type": "text", "required": true},
      {"label": "Designation", "type": "text", "required": true},
      {"label": "Status", "type": "text", "required": true},
    ],
  };

  String? _traceable;
  String? _untraceableReason;
  final List<String> _traceableOptions = ['traceable', 'untraceable'];
  final List<String> _untraceableReasons = [
    'address insufficient',
    'address insufficient and difficult to locate',
    'applicant not responding phonecall',
    'loan cancel',
  ];

  final Map<String, dynamic> answers = {};

  @override
  void initState() {
    super.initState();
    final fields = formSchema[widget.sectionKey] ?? [];
    for (var f in fields) {
      answers[f['label']] = null;
    }
    answers['is_traceable'] = null;
    answers['untraceable_reason'] = null;
    _requestPermissions();

    // fetch initial location silently to speed up camera launch
    _fetchInitialLocation();
    // optional: you could start a low-cost position stream here if needed (commented).
  }

  @override
  void dispose() {
    _positionStreamSub?.cancel();
    super.dispose();
  }

  // Request necessary permissions
  Future<void> _requestPermissions() async {
    await Permission.camera.request();
    await Permission.location.request();
  }

  // Fetch initial location silently (no snackbars)
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

      // quick get with timeout
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
          address = '${place.street ?? ''}, ${place.subLocality ?? ''}, ${place.locality ?? ''}, ${place.administrativeArea ?? ''}, ${place.postalCode ?? ''}, ${place.country ?? ''}'
              .replaceAll(RegExp(r',\s*,'), ',')
              .replaceAll(RegExp(r'^,\s*|,\s*$'), '')
              .trim();
        }
      } catch (e) {
        address = 'Lat: ${position.latitude.toStringAsFixed(6)}, Long: ${position.longitude.toStringAsFixed(6)}';
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

  // Original get location function (shows snackbars and performs full reverse-geocode)
  Future<Map<String, dynamic>?> _getCurrentLocationData() async {
    try {
      // Check if location services are enabled
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

      // Check location permission
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

      // Show loading indicator
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Row(
              children: [
                SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                ),
                SizedBox(width: 16),
                Text('Getting location...'),
              ],
            ),
            duration: Duration(seconds: 2),
          ),
        );
      }

      // Get current position
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      // Get address from coordinates
      String address = 'Address not available';
      try {
        List<Placemark> placemarks = await placemarkFromCoordinates(
          position.latitude,
          position.longitude,
        );
        
        if (placemarks.isNotEmpty) {
          Placemark place = placemarks[0];
          address = '${place.street ?? ''}, ${place.subLocality ?? ''}, ${place.locality ?? ''}, ${place.administrativeArea ?? ''}, ${place.postalCode ?? ''}, ${place.country ?? ''}'
              .replaceAll(RegExp(r',\s*,'), ',')
              .replaceAll(RegExp(r'^,\s*|,\s*$'), ' ')
              .trim();
        }
      } catch (e) {
        debugPrint('Error getting address: $e');
        address = 'Lat: ${position.latitude.toStringAsFixed(6)}, Long: ${position.longitude.toStringAsFixed(6)}';
      }

      // Get current date and time
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

  // Camera capture function with location data - Opens custom camera with watermark
  Future<void> _captureImage() async {
    try {
      // Use cached location if available, otherwise fetch one (quick)
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

      // Open custom camera with watermark
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
      
      // result is expected to be Map {'image': XFile, 'locationData': {...}}
      if (result != null && result is Map && result['image'] != null) {
        final XFile photo = result['image'] as XFile;
        final Map<String, dynamic> usedLocation = Map<String, dynamic>.from(result['locationData'] ?? _cachedLocationData!);

        setState(() {
          _capturedImages.add({
            'image': photo,
            'latitude': usedLocation['latitude'],
            'longitude': usedLocation['longitude'],
            'address': usedLocation['address'],
            'timestamp': usedLocation['timestamp'],
            'raw_timestamp': usedLocation['raw_timestamp'],
          });
          // update cached location too so next camera uses newest
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

  // Remove image function
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

  // Show image details dialog - FIXED: Added proper constraints
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
                    Text('Image ${index + 1} Details', 
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
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
                      _buildDetailRow(Icons.my_location, 'Latitude', imageData['latitude'].toStringAsFixed(6)),
                      const Divider(),
                      _buildDetailRow(Icons.location_on, 'Longitude', imageData['longitude'].toStringAsFixed(6)),
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

  // Document picker function
  Future<void> _pickDocument() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'doc', 'docx', 'jpg', 'jpeg', 'png'],
      );

      if (result != null && result.files.isNotEmpty) {
        setState(() {
          _uploadedDocument = result.files.first;
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

  // Remove document function
  void _removeDocument() {
    setState(() {
      _uploadedDocument = null;
    });
    
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Document removed'),
        duration: Duration(seconds: 1),
      ),
    );
  }

  Widget _buildField(Map<String, dynamic> field) {
    final label = field['label'] as String;
    final type = field['type'] as String;
    final required = field['required'] as bool? ?? true;

    if (type == 'dropdown') {
      final List<dynamic> opts = field['options'] ?? [];
      return Padding(
        padding: const EdgeInsets.only(bottom: 16.0),
        child: DropdownButtonFormField<String>(
          decoration: InputDecoration(
            labelText: required ? '$label *' : label,
            labelStyle: TextStyle(color: Appcolors.kblackcolor.withOpacity(0.7)),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Appcolors.kbordercolor),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Appcolors.kbordercolor.withOpacity(0.5)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Appcolors.kprimarycolor, width: 2),
            ),
            filled: true,
            fillColor: Appcolors.kwhitecolor,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          ),
          items: opts.map((o) => DropdownMenuItem(value: o.toString(), child: Text(o.toString()))).toList(),
          value: answers[label],
          onChanged: (v) => setState(() => answers[label] = v),
          validator: required ? (v) => (v == null || v.isEmpty) ? 'Please select $label' : null : null,
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.only(bottom: 16.0),
        child: TextFormField(
          initialValue: answers[label],
          decoration: InputDecoration(
            labelText: required ? '$label *' : label,
            labelStyle: TextStyle(color: Appcolors.kblackcolor.withOpacity(0.7)),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Appcolors.kbordercolor),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Appcolors.kbordercolor.withOpacity(0.5)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Appcolors.kprimarycolor, width: 2),
            ),
            filled: true,
            fillColor: Appcolors.kwhitecolor,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          ),
          onChanged: (v) => answers[label] = v,
          validator: required ? (v) => (v == null || v.trim().isEmpty) ? 'Please enter $label' : null : null,
        ),
      );
    }
  }

  // Image gallery widget with location info
  Widget _buildImageGallery() {
    return Container(
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
              Icon(Icons.camera_alt, color: Appcolors.kprimarycolor),
              const SizedBox(width: 8),
              const Text(
                'Verification Images',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: _capturedImages.length >= 5 ? Colors.green : Colors.orange,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '${_capturedImages.length}/5 min',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Icon(Icons.location_on, size: 16, color: Colors.grey[600]),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  'Images captured with GPS location & timestamp',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Minimum 5 images required *',
            style: TextStyle(
              fontSize: 13,
              color: _capturedImages.length < 5 ? Colors.red : Colors.green,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 16),
          
          // Display captured images
          if (_capturedImages.isNotEmpty)
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount: _capturedImages.length,
              itemBuilder: (context, index) {
                final imageData = _capturedImages[index];
                return Stack(
                  children: [
                    GestureDetector(
                      onTap: () => _showImageDetails(imageData, index),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.file(
                          File(imageData['image'].path),
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                        ),
                      ),
                    ),
                    // Info button
                    Positioned(
                      top: 4,
                      left: 4,
                      child: GestureDetector(
                        onTap: () => _showImageDetails(imageData, index),
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            color: Colors.blue,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.info,
                            size: 14,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    // Delete button
                    Positioned(
                      top: 4,
                      right: 4,
                      child: GestureDetector(
                        onTap: () => _removeImage(index),
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.close,
                            size: 14,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    // Image number with small icon
                    Positioned(
                      bottom: 4,
                      left: 4,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.black54,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.location_on, size: 10, color: Colors.white),
                            const SizedBox(width: 2),
                            Text(
                              '${index + 1}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: OutlinedButton.icon(
              onPressed: _captureImage,
              icon: const Icon(Icons.camera_alt),
              label: const Text('Capture Image with Location'),
              style: OutlinedButton.styleFrom(
                foregroundColor: Appcolors.kprimarycolor,
                side: BorderSide(color: Appcolors.kprimarycolor, width: 2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Document upload widget
  Widget _buildDocumentUpload() {
    return Container(
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
              Icon(Icons.insert_drive_file, color: Appcolors.kprimarycolor),
              const SizedBox(width: 8),
              const Text(
                'Supporting Document',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            'Optional - PDF, DOC, DOCX, or Images',
            style: TextStyle(fontSize: 13, color: Colors.black54),
          ),
          const SizedBox(height: 16),
          
          if (_uploadedDocument != null)
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.green, width: 1),
              ),
              child: Row(
                children: [
                  const Icon(Icons.check_circle, color: Colors.green, size: 24),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _uploadedDocument!.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          '${(_uploadedDocument!.size / 1024).toStringAsFixed(2)} KB',
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: _removeDocument,
                    icon: const Icon(Icons.delete, color: Colors.red),
                  ),
                ],
              ),
            )
          else
            SizedBox(
              width: double.infinity,
              height: 50,
              child: OutlinedButton.icon(
                onPressed: _pickDocument,
                icon: const Icon(Icons.upload_file),
                label: const Text('Upload Document'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Appcolors.kprimarycolor,
                  side: BorderSide(color: Appcolors.kprimarycolor.withOpacity(0.5), width: 1.5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  void _onSubmit() {
    // Validate form fields
    if (!_formKey.currentState!.validate()) return;

    // Validate minimum images
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
      answers['is_traceable'] = 'untraceable';
      answers['untraceable_reason'] = _untraceableReason;
    } else {
      answers['is_traceable'] = 'traceable';
      answers['untraceable_reason'] = null;
    }

    // Prepare images data with location info
    final imagesData = _capturedImages.map((imgData) => {
      'image_path': imgData['image'].path,
      'latitude': imgData['latitude'],
      'longitude': imgData['longitude'],
      'address': imgData['address'],
      'timestamp': imgData['timestamp'],
      'raw_timestamp': imgData['raw_timestamp'],
    }).toList();

    // Log all images data
    debugPrint('========== ALL CAPTURED IMAGES DATA ==========');
    for (int i = 0; i < imagesData.length; i++) {
      debugPrint('--- Image ${i + 1} ---');
      debugPrint('Path: ${imagesData[i]['image_path']}');
      debugPrint('Latitude: ${imagesData[i]['latitude']}');
      debugPrint('Longitude: ${imagesData[i]['longitude']}');
      debugPrint('Address: ${imagesData[i]['address']}');
      debugPrint('Timestamp: ${imagesData[i]['timestamp']}');
      debugPrint('');
    }
    debugPrint('==============================================');

    final payload = {
      'section': widget.sectionKey,
      'answers': answers,
      'images': imagesData,
      'image_count': _capturedImages.length,
      'document': _uploadedDocument != null ? {
        'name': _uploadedDocument!.name,
        'path': _uploadedDocument!.path,
        'size': _uploadedDocument!.size,
      } : null,
    };

    final jsonStr = jsonEncode(payload);
    debugPrint(jsonStr);
    
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            Icon(Icons.check_circle, color: Appcolors.kprimarycolor, size: 28),
            const SizedBox(width: 12),
            const Text('Submitted Successfully', style: TextStyle(fontSize: 18)),
          ],
        ),
        content: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(jsonStr, style: const TextStyle(fontSize: 12, fontFamily: 'monospace')),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            style: TextButton.styleFrom(
              foregroundColor: Appcolors.kprimarycolor,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
            child: const Text('OK', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final fields = formSchema[widget.sectionKey] ?? [];
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Appcolors.kprimarycolor,
        foregroundColor: Appcolors.kwhitecolor,
        elevation: 0,
        title: Text('Verification - ${widget.sectionKey}'),
        centerTitle: false,
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            // Traceable/Untraceable Section
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
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      labelText: 'Is the address traceable? *',
                      labelStyle: TextStyle(color: Appcolors.kblackcolor.withOpacity(0.7)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Appcolors.kbordercolor),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Appcolors.kbordercolor.withOpacity(0.5)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Appcolors.kprimarycolor, width: 2),
                      ),
                      filled: true,
                      fillColor: Appcolors.kwhitecolor,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    ),
                    items: _traceableOptions.map((o) => DropdownMenuItem(value: o, child: Text(o.toUpperCase()))).toList(),
                    value: _traceable,
                    onChanged: (v) => setState(() {
                      _traceable = v;
                      answers['is_traceable'] = _traceable;
                      if (v == 'traceable') {
                        _untraceableReason = null;
                        answers['untraceable_reason'] = null;
                      }
                    }),
                    validator: (v) => (v == null || v.isEmpty) ? 'Please select whether address is traceable' : null,
                  ),
                ],
              ),
            ),

            // Main Content Area
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
                                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 16),
                                  ...fields.map((f) => _buildField(f)).toList(),
                                ],
                              ),
                            ),
                            const SizedBox(height: 16),
                            
                            // Image Gallery
                            _buildImageGallery(),
                            const SizedBox(height: 16),
                            
                            // Document Upload
                            _buildDocumentUpload(),
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
                                child: const Text('Submit Verification', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
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
                                      Icon(Icons.warning_amber_rounded, color: Appcolors.ksecondarycolor, size: 28),
                                      const SizedBox(width: 12),
                                      const Text(
                                        'Untraceable Reason',
                                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 16),
                                  const Text(
                                    'Please select the reason why the address is untraceable:',
                                    style: TextStyle(fontSize: 14, color: Colors.black87),
                                  ),
                                  const SizedBox(height: 16),
                                  DropdownButtonFormField<String>(
                                    decoration: InputDecoration(
                                      labelText: 'Reason *',
                                      labelStyle: TextStyle(color: Appcolors.kblackcolor.withOpacity(0.7)),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: const BorderSide(color: Appcolors.kbordercolor),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: BorderSide(color: Appcolors.kbordercolor.withOpacity(0.5)),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: const BorderSide(color: Appcolors.kprimarycolor, width: 2),
                                      ),
                                      filled: true,
                                      fillColor: Appcolors.kwhitecolor,
                                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                                    ),
                                    isExpanded: true,
                                    items: _untraceableReasons
                                        .map((r) => DropdownMenuItem(
                                              value: r,
                                              child: Text(
                                                r,
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 2,
                                              ),
                                            ))
                                        .toList(),
                                    value: _untraceableReason,
                                    onChanged: (v) => setState(() => _untraceableReason = v),
                                    validator: (v) => (v == null || v.isEmpty) ? 'Please select reason for untraceable' : null,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 16),
                            
                            // Image Gallery for untraceable
                            _buildImageGallery(),
                            const SizedBox(height: 16),
                            
                            // Document Upload for untraceable
                            _buildDocumentUpload(),
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
                                child: const Text('Submit', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                              ),
                            ),
                            const SizedBox(height: 16),
                          ],
                        ),
            ),
          ],
        ),
      ),
    );
  }
}

// Custom Camera Screen with Watermark Overlay
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
    // copy initial location (so camera can update it locally)
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
      Position pos = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      String address = _currentLocationData['address'] ?? 'Address not available';
      try {
        List<Placemark> places = await placemarkFromCoordinates(pos.latitude, pos.longitude);
        if (places.isNotEmpty) {
          final p = places.first;
          address = '${p.street ?? ''}, ${p.subLocality ?? ''}, ${p.locality ?? ''}, ${p.administrativeArea ?? ''}, ${p.postalCode ?? ''}, ${p.country ?? ''}'
              .replaceAll(RegExp(r',\s*,'), ',')
              .replaceAll(RegExp(r'^,\s*|,\s*$'), '')
              .trim();
        }
      } catch (e) {
        address = 'Lat: ${pos.latitude.toStringAsFixed(6)}, Long: ${pos.longitude.toStringAsFixed(6)}';
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
      // small feedback
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Location refreshed'), duration: Duration(seconds: 1)));
      }
    } catch (e) {
      setState(() => _refreshing = false);
      debugPrint('Failed to refresh location: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to refresh location: $e'), backgroundColor: Colors.red));
      }
    }
  }

  Future<void> _takePicture() async {
    try {
      await _initializeControllerFuture;
      final image = await _controller.takePicture();
      
      if (mounted) {
        Navigator.pop(context, {'image': image, 'locationData': _currentLocationData});
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
                // Camera Preview
                Positioned.fill(
                  child: CameraPreview(_controller),
                ),
                
                // Watermark Overlay (only visible in preview)
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
                        Row(
                          children: [
                            Expanded(
                              child: _buildWatermarkRow(
                                Icons.calendar_today,
                                'Date & Time',
                                _currentLocationData['timestamp'] ?? '',
                              ),
                            ),
                            // Refresh button
                            IconButton(
                              onPressed: _refreshing ? null : _refreshLocation,
                              icon: _refreshing
                                  ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                                  : const Icon(Icons.refresh, color: Colors.white),
                              tooltip: 'Refresh location',
                            ),
                          ],
                        ),
                        const Divider(color: Colors.white24, height: 16),
                        _buildWatermarkRow(
                          Icons.my_location,
                          'Latitude',
                          _currentLocationData['latitude'] != null ? _currentLocationData['latitude'].toStringAsFixed(6) : '',
                        ),
                        const Divider(color: Colors.white24, height: 16),
                        _buildWatermarkRow(
                          Icons.location_on,
                          'Longitude',
                          _currentLocationData['longitude'] != null ? _currentLocationData['longitude'].toStringAsFixed(6) : '',
                        ),
                        const Divider(color: Colors.white24, height: 16),
                        _buildWatermarkRow(
                          Icons.home,
                          'Address',
                          _currentLocationData['address'] ?? '',
                        ),
                      ],
                    ),
                  ),
                ),
                
                // Close button
                Positioned(
                  top: 40,
                  left: 16,
                  child: IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close, color: Colors.white, size: 32),
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
}

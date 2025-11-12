
import 'dart:convert';
import 'package:arthor/core/colors.dart';
import 'package:arthor/core/responsiveutils.dart';
import 'package:flutter/material.dart';



/// AddressVerificationPage
/// - Pass `sectionKey` as one of the available sections
/// - Questions marked with required:true are validated before submit
class AddressVerificationPage extends StatefulWidget {
  final String sectionKey;
  const AddressVerificationPage({Key? key, required this.sectionKey}) : super(key: key);

  @override
  State<AddressVerificationPage> createState() => _AddressVerificationPageState();
}

class _AddressVerificationPageState extends State<AddressVerificationPage> {
  final _formKey = GlobalKey<FormState>();

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

  void _onSubmit() {
    if (!_formKey.currentState!.validate()) return;

    if (_traceable == 'untraceable') {
      answers['is_traceable'] = 'untraceable';
      answers['untraceable_reason'] = _untraceableReason;
    } else {
      answers['is_traceable'] = 'traceable';
      answers['untraceable_reason'] = null;
    }

    final payload = {
      'section': widget.sectionKey,
      'answers': answers,
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
                      : Padding(
                          padding: const EdgeInsets.all(15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                                    SizedBox(
                                      width: ResponsiveUtils.wp(90),
                                      child:DropdownButtonFormField<String>(
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
  isExpanded: true,  // Add this line - CRITICAL!
  items: _untraceableReasons
      .map((r) => DropdownMenuItem(
            value: r,
            child: Text(
              r,
              overflow: TextOverflow.ellipsis,  // Add this
              maxLines: 2,  // Add this - allows text to wrap to 2 lines
            ),
          ))
      .toList(),
  value: _untraceableReason,
  onChanged: (v) => setState(() => _untraceableReason = v),
  validator: (v) => (v == null || v.isEmpty) ? 'Please select reason for untraceable' : null,
),
                                    ),
                                  ],
                                ),
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
                                  child: const Text('Submit', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                                ),
                              ),
                            ],
                          ),
                        ),
            ),
          ],
        ),
      ),
    );
  }
}
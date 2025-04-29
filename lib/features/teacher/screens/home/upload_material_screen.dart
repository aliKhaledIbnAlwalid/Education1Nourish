// import 'package:flutter/material.dart';
// import 'package:file_picker/file_picker.dart';

// class TeacherMaterialScreen extends StatefulWidget {
//   const TeacherMaterialScreen({super.key});

//   @override
//   State<TeacherMaterialScreen> createState() => _TeacherMaterialScreenState();
// }

// class _TeacherMaterialScreenState extends State<TeacherMaterialScreen> {
//   String? _selectedFilePath;
//   String? _youtubeLink;

//   String selectedClass = 'Class 1';
//   String selectedType = 'Documents';
//   bool isUploading = false;

//   Future<void> _pickFile() async {
//     if (selectedType == 'Documents') {
//       FilePickerResult? result =  await FilePicker.platform.pickFiles(
//         type: FileType.custom,
//         allowedExtensions: ['Documents'],
//       );
//       if (result != null && result.files.isNotEmpty) {
//         setState(() {
//           _selectedFilePath = result.files.first.path;
//         });
//       }
//     } else {
//       final linkController = TextEditingController();
//       final result = await showDialog<String>(
//         context: context,
//         builder: (context) => AlertDialog(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(16),
//           ),
//           title: const Text(
//             'Enter YouTube Link',
//             style: TextStyle(fontWeight: FontWeight.bold),
//           ),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               TextField(
//                 controller: linkController,
//                 decoration: InputDecoration(
//                   hintText: 'https://youtube.com/...',
//                   border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(12)),
//                   prefixIcon: const Icon(Icons.link),
//                 ),
//                 keyboardType: TextInputType.url,
//               ),
//             ],
//           ),
//           actionsPadding:
//               const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.pop(context, null),
//               child: const Text('Cancel'),
//             ),
//             ElevatedButton(
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: const Color(0xFF00B8B0),
//                 foregroundColor: Colors.white,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//               ),
//               onPressed: () {
//                 final link = linkController.text.trim();
//                 if (link.isNotEmpty) {
//                   Navigator.pop(context, link);
//                 }
//               },
//               child: const Text('OK'),
//             ),
//           ],
//         ),
//       );
//       if (result != null) {
//         setState(() {
//           _youtubeLink = result;
//         });
//       }
//     }
//   }

//   Future<void> _uploadFile() async {
//     if (selectedType == 'Documents' && _selectedFilePath == null) return;
//     if (selectedType == 'YouTube' && _youtubeLink == null) return;

//     setState(() {
//       isUploading = true;
//     });

//     await Future.delayed(const Duration(seconds: 3));

//     setState(() {
//       isUploading = false;
//       _selectedFilePath = null;
//       _youtubeLink = null;
//     });
//   }

//   final List<String> classes = [
//     'Class 1',
//     'Class 2',
//     'Class 3',
//     'Class 4',
//     'Class 5',
//     'Class 6',
//   ];

//   final List<String> materialTypes = ['Documents', 'YouTube'];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Upload Teaching Materials'),
//         backgroundColor: const Color(0xFF00B8B0),
//         foregroundColor: Colors.white,
//         elevation: 0,
//       ),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.all(16),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Card(
//                 elevation: 4,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(16),
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.all(20),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       const Text(
//                         'Add New Material',
//                         style: TextStyle(
//                           fontSize: 20,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       const SizedBox(height: 20),
//                       DropdownButtonFormField<String>(
//                         value: selectedType,
//                         items: materialTypes
//                             .map((type) => DropdownMenuItem(
//                                   value: type,
//                                   child: Text(type),
//                                 ))
//                             .toList(),
//                         onChanged: (value) {
//                           setState(() {
//                             selectedType = value!;
//                           });
//                         },
//                         decoration: InputDecoration(
//                           labelText: 'Material Type',
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                           prefixIcon: const Icon(Icons.category),
//                         ),
//                       ),
//                       const SizedBox(height: 16),
//                       DropdownButtonFormField<String>(
//                         value: selectedClass,
//                         items: classes
//                             .map((cls) => DropdownMenuItem(
//                                   value: cls,
//                                   child: Text(cls),
//                                 ))
//                             .toList(),
//                         onChanged: (value) {
//                           setState(() {
//                             selectedClass = value!;
//                           });
//                         },
//                         decoration: InputDecoration(
//                           labelText: 'Select Class',
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                           prefixIcon: const Icon(Icons.class_),
//                         ),
//                       ),
//                       const SizedBox(height: 16),
//                       TextField(
//                         decoration: InputDecoration(
//                           labelText: 'Title',
//                           hintText: 'Enter material title',
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                           prefixIcon: const Icon(Icons.title),
//                         ),
//                       ),
//                       const SizedBox(height: 16),
//                       TextField(
//                         maxLines: 3,
//                         decoration: InputDecoration(
//                           labelText: 'Description',
//                           hintText: 'Enter material description',
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                           prefixIcon: const Icon(Icons.description),
//                         ),
//                       ),
//                       const SizedBox(height: 16),
//                       GestureDetector(
//                         onTap: _pickFile,
//                         child: Container(
//                           padding: const EdgeInsets.all(16),
//                           decoration: BoxDecoration(
//                             border: Border.all(color: Colors.grey.shade300),
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                           child: Row(
//                             children: [
//                               Icon(
//                                 Icons.upload_file,
//                                 color: Theme.of(context).primaryColor,
//                               ),
//                               const SizedBox(width: 16),
//                               Expanded(
//                                 child: Text(
//                                   selectedType == 'Documents'
//                                       ? (_selectedFilePath != null
//                                           ? _selectedFilePath!.split('/').last
//                                           : 'Choose Documents')
//                                       : (_youtubeLink ?? 'Enter YouTube Link'),
//                                   style: TextStyle(
//                                     color: Colors.grey.shade600,
//                                   ),
//                                   overflow: TextOverflow.ellipsis,
//                                 ),
//                               ),
//                               const Icon(Icons.attach_file),
//                             ],
//                           ),
//                         ),
//                       ),
//                       const SizedBox(height: 20),
//                       SizedBox(
//                         width: double.infinity,
//                         height: 50,
//                         child: ElevatedButton(
//                           onPressed: _uploadFile,
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: const Color(0xFF00B8B0),
//                             foregroundColor: Colors.white,
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(12),
//                             ),
//                           ),
//                           child: isUploading
//                               ? const CircularProgressIndicator(
//                                   valueColor: AlwaysStoppedAnimation<Color>(
//                                       Colors.white),
//                                 )
//                               : const Text('Upload Material'),
//                         ),
//                       ),
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
// }

import 'package:edunourish/features/teacher/screens/home/notifiactions_screen.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class TeacherMaterialScreen extends StatefulWidget {
  const TeacherMaterialScreen({super.key});

  @override
  State<TeacherMaterialScreen> createState() => _TeacherMaterialScreenState();
}

class _TeacherMaterialScreenState extends State<TeacherMaterialScreen> {
  String? _selectedFilePath;
  String? _youtubeLink;

  String selectedClass = 'Class 1';
  String selectedType = 'Documents';
  bool isUploading = false;

  Future<void> _pickFile() async {
    if (selectedType == 'Documents') {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'doc', 'docx'],
      );
      if (result != null && result.files.isNotEmpty) {
        setState(() {
          _selectedFilePath = result.files.first.path;
        });
      }
    } else {
      final linkController = TextEditingController();
      final result = await showDialog<String>(
        context: context,
        builder: (context) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Text(
            'Enter YouTube Link',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: linkController,
                decoration: InputDecoration(
                  hintText: 'https://youtube.com/...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  prefixIcon: const Icon(Icons.link),
                ),
                keyboardType: TextInputType.url,
              ),
            ],
          ),
          actionsPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, null),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF00B8B0),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                final link = linkController.text.trim();
                if (link.isNotEmpty) {
                  Navigator.pop(context, link);
                }
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
      if (result != null) {
        setState(() {
          _youtubeLink = result;
        });
      }
    }
  }

  Future<void> _uploadFile() async {
    if (selectedType == 'Documents' && _selectedFilePath == null) return;
    if (selectedType == 'YouTube' && _youtubeLink == null) return;

    setState(() {
      isUploading = true;
    });

    await Future.delayed(const Duration(seconds: 3));

    setState(() {
      isUploading = false;
      _selectedFilePath = null;
      _youtubeLink = null;
    });

    // Optionally show a success message
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Material uploaded successfully!')),
    );
  }

  final List<String> classes = [
    'Class 1',
    'Class 2',
    'Class 3',
    'Class 4',
    'Class 5',
    'Class 6',
  ];

  final List<String> materialTypes = ['Documents', 'YouTube'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff2f2f2),
      appBar: AppBar(
        title: const Text('Upload Materials'),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.notifications_none_outlined, size: 30),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => NeoNotificationsTeacherScreen(),
              ),
            );
          },
        ),
        actions: const [
          Image(
            image: AssetImage('assets/Intro_Screen_login/EduIcon.png'),
            height: 50,
            width: 50,
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                color: const Color(0xfff5f5f5),
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Add New Material',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      DropdownButtonFormField<String>(
                        value: selectedType,
                        items: materialTypes
                            .map((type) => DropdownMenuItem(
                                  value: type,
                                  child: Text(type),
                                ))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedType = value!;
                          });
                        },
                        decoration: InputDecoration(
                          labelText: 'Material Type',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          prefixIcon: const Icon(Icons.category),
                        ),
                      ),
                      const SizedBox(height: 16),
                      DropdownButtonFormField<String>(
                        value: selectedClass,
                        items: classes
                            .map((cls) => DropdownMenuItem(
                                  value: cls,
                                  child: Text(cls),
                                ))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedClass = value!;
                          });
                        },
                        decoration: InputDecoration(
                          labelText: 'Select Class',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          prefixIcon: const Icon(Icons.class_),
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        decoration: InputDecoration(
                          labelText: 'Title',
                          hintText: 'Enter material title',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          prefixIcon: const Icon(Icons.title),
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        maxLines: 3,
                        decoration: InputDecoration(
                          labelText: 'Description',
                          hintText: 'Enter material description',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          prefixIcon: const Icon(Icons.description),
                        ),
                      ),
                      const SizedBox(height: 16),
                      GestureDetector(
                        onTap: _pickFile,
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade300),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.upload_file,
                                color: Theme.of(context).primaryColor,
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Text(
                                  selectedType == 'Documents'
                                      ? (_selectedFilePath != null
                                          ? _selectedFilePath!.split('/').last
                                          : 'Choose Document')
                                      : (_youtubeLink ?? 'Enter YouTube Link'),
                                  style: TextStyle(
                                    color: Colors.grey.shade600,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              const Icon(Icons.attach_file),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: _uploadFile,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF00B8B0),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: isUploading
                              ? const CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white),
                                )
                              : const Text('Upload Material'),
                        ),
                      ),
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
}

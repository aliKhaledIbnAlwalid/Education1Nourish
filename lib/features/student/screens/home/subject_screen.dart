// import 'package:flutter/material.dart';

// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:dio/dio.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:permission_handler/permission_handler.dart';

// class SubjectScreen extends StatelessWidget {
//   final List<Map<String, dynamic>> subjects = [
//     {'title': 'Math', 'icon': Icons.calculate},
//     {'title': 'Science', 'icon': Icons.science},
//     {'title': 'RE', 'icon': Icons.self_improvement},
//     {'title': 'English', 'icon': Icons.language},
//     {'title': 'ICT', 'icon': Icons.computer},
//     {'title': 'Arabic', 'icon': Icons.translate},
//     {'title': 'PE', 'icon': Icons.sports_soccer},
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.blue.shade800,
//         title: const Text('Simple Steps to College Success'),
//         centerTitle: true,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: GridView.builder(
//           itemCount: subjects.length,
//           gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//             crossAxisCount: 2,
//             crossAxisSpacing: 16,
//             mainAxisSpacing: 16,
//             childAspectRatio: 1.2,
//           ),
//           itemBuilder: (context, index) {
//             return GestureDetector(
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (_) => SubjectDetailsScreen(
//                       subject: subjects[index]['title'],
//                       subjectId: '',
//                       subjectTitle: '',
//                     ),
//                   ),
//                 );
//               },
//               child: Container(
//                 decoration: BoxDecoration(
//                   color: Colors.blue.shade400,
//                   borderRadius: BorderRadius.circular(16),
//                   boxShadow: const [
//                     BoxShadow(
//                       color: Colors.black12,
//                       blurRadius: 6,
//                       offset: Offset(0, 4),
//                     ),
//                   ],
//                 ),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Icon(subjects[index]['icon'],
//                         size: 50, color: Colors.white),
//                     const SizedBox(height: 12),
//                     Text(
//                       subjects[index]['title'],
//                       style: const TextStyle(
//                         color: Colors.white,
//                         fontSize: 20,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }

// class SubjectDetailsScreen extends StatefulWidget {
//   final String subjectId;
//   final String subjectTitle;

//   const SubjectDetailsScreen(
//       {required this.subjectId, required this.subjectTitle, required subject});

//   @override
//   State<SubjectDetailsScreen> createState() => _SubjectDetailsScreenState();
// }

// class _SubjectDetailsScreenState extends State<SubjectDetailsScreen> {
//   late Future<Map<String, dynamic>> subjectContent;

//   @override
//   void initState() {
//     super.initState();
//     subjectContent = fetchSubjectContent();
//   }

//   Future<Map<String, dynamic>> fetchSubjectContent() async {
//     final response = await http
//         .get(Uri.parse('https://yourapi.com/subjects/${widget.subjectId}'));

//     if (response.statusCode == 200) {
//       return json.decode(response.body);
//     } else {
//       throw Exception('Failed to load subject content');
//     }
//   }

//   Future<void> downloadPDF(String url, String title) async {
//     final status = await Permission.storage.request();
//     if (!status.isGranted) {
//       ScaffoldMessenger.of(context)
//           .showSnackBar(SnackBar(content: Text('Storage permission denied')));
//       return;
//     }

//     final dir = await getExternalStorageDirectory();
//     final savePath = '${dir!.path}/$title.pdf';

//     try {
//       await Dio().download(url, savePath);
//       ScaffoldMessenger.of(context)
//           .showSnackBar(SnackBar(content: Text('Downloaded $title')));
//     } catch (e) {
//       ScaffoldMessenger.of(context)
//           .showSnackBar(SnackBar(content: Text('Download failed')));
//     }
//   }

//   void openYouTube(String url) async {
//     final uri = Uri.parse(url);
//     if (await canLaunchUrl(uri)) {
//       await launchUrl(uri, mode: LaunchMode.externalApplication);
//     } else {
//       ScaffoldMessenger.of(context)
//           .showSnackBar(SnackBar(content: Text('Could not open YouTube')));
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text(widget.subjectTitle)),
//       body: FutureBuilder<Map<String, dynamic>>(
//         future: subjectContent,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting)
//             return Center(child: CircularProgressIndicator());
//           if (snapshot.hasError)
//             return Center(child: Text('Error: ${snapshot.error}'));

//           final pdfs = snapshot.data!['pdfs'] as List<dynamic>;
//           final youtubeLinks = snapshot.data!['youtube_links'] as List<dynamic>;

//           return SingleChildScrollView(
//             padding: EdgeInsets.all(16),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text('📄 PDF Resources',
//                     style: Theme.of(context).textTheme.titleMedium),
//                 SizedBox(height: 8),
//                 ...pdfs.map((pdf) => Card(
//                       child: ListTile(
//                         leading: Icon(Icons.picture_as_pdf, color: Colors.red),
//                         title: Text(pdf['title']),
//                         trailing: ElevatedButton.icon(
//                           onPressed: () =>
//                               downloadPDF(pdf['url'], pdf['title']),
//                           icon: Icon(Icons.download),
//                           label: Text('Download'),
//                         ),
//                       ),
//                     )),
//                 SizedBox(height: 24),
//                 Text('🎥 YouTube Lessons',
//                     style: Theme.of(context).textTheme.titleMedium),
//                 SizedBox(height: 8),
//                 ...youtubeLinks.map((yt) => Card(
//                       child: ListTile(
//                         leading: Icon(Icons.ondemand_video, color: Colors.red),
//                         title: Text(yt['title']),
//                         trailing: ElevatedButton.icon(
//                           onPressed: () => openYouTube(yt['url']),
//                           icon: Icon(Icons.open_in_new),
//                           label: Text('Watch'),
//                         ),
//                       ),
//                     )),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }





// old code UI

// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:http/http.dart' as http;

// import '../../providers/student_provider.dart';

// /// Shows all subjects in a grid.
// class SubjectScreen extends StatelessWidget {
//   const SubjectScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final prov = context.watch<StudentProvider>();

//     // 1) Still loading?
//     if (prov.isLoading) {
//       return Scaffold(
//         appBar: AppBar(title: const Text('Subjects')),
//         body: const Center(child: CircularProgressIndicator()),
//       );
//     }

//     // 2) No subjects?
//     final subjects = prov.subjects;
//     if (subjects.isEmpty) {
//       return Scaffold(
//         appBar: AppBar(title: const Text('Subjects')),
//         body: const Center(child: Text('No subjects available.')),
//       );
//     }

//     // 3) Show the grid
//     return Scaffold(
//       appBar: AppBar(title: const Text('Subjects')),
//       body: GridView.builder(
//         padding: const EdgeInsets.all(16),
//         itemCount: subjects.length,
//         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 2,
//           mainAxisSpacing: 16,
//           crossAxisSpacing: 16,
//           childAspectRatio: 1.2,
//         ),
//         itemBuilder: (ctx, i) {
//           final s = subjects[i];
//           return GestureDetector(
//             onTap: () => Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (_) => SubjectDetailsScreen(subjectId: s.subjectId),
//               ),
//             ),
//             child: Container(
//               decoration: BoxDecoration(
//                 color: Colors.blue.shade400,
//                 borderRadius: BorderRadius.circular(16),
//                 boxShadow: const [
//                   BoxShadow(
//                     blurRadius: 4,
//                     offset: Offset(0, 2),
//                     color: Colors.black26,
//                   )
//                 ],
//               ),
//               child: Center(
//                 child: Text(
//                   s.name, //
//                   textAlign: TextAlign.center,
//                   style: const TextStyle(
//                     color: Colors.white,
//                     fontSize: 20,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

// /// Fetches and displays details for one subject (PDFs & YouTube links).
// class SubjectDetailPage extends StatelessWidget {
//   final Subject subject;

//   const SubjectDetailPage({Key? key, required this.subject}) : super(key: key);

//   /// Opens a URL in the external browser/app.
//   Future<void> _openUrl(String url) async {
//     if (await canLaunch(url)) {
//       await launch(url);
//     } else {
//       // You might show an error Snackbar here.
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(subject.name),
//       ),
//       body: ListView(
//         padding: const EdgeInsets.all(16),
//         children: [
//           _buildInfoRow('Code', subject.code),
//           _buildInfoRow('Category', subject.category),
//           _buildInfoRow('Grade Level', subject.gradeLevel),
//           _buildInfoRow('Semester', subject.semester),
//           const SizedBox(height: 16),
//           Text('Description', style: Theme.of(context).textTheme.subtitle1),
//           const SizedBox(height: 8),
//           Text(subject.description, style: Theme.of(context).textTheme.bodyText2),
//         ],
//       ),
//       bottomNavigationBar: BottomAppBar(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               if (subject.photoUrls.isNotEmpty)
//                 IconButton(
//                   icon: const Icon(Icons.photo),
//                   tooltip: 'View Photos',
//                   onPressed: () => Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (_) => PhotoGalleryPage(urls: subject.photoUrls),
//                     ),
//                   ),
//                 ),
//               if (subject.youtubeUrl.isNotEmpty)
//                 IconButton(
//                   icon: const Icon(Icons.video_library),
//                   tooltip: 'Watch on YouTube',
//                   onPressed: () => _openUrl(subject.youtubeUrl),
//                 ),
//               if (subject.pdfUrl.isNotEmpty)
//                 IconButton(
//                   icon: const Icon(Icons.picture_as_pdf),
//                   tooltip: 'Open PDF',
//                   onPressed: () => _openUrl(subject.pdfUrl),
//                 ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   /// Reusable info‐row widget.
//   Widget _buildInfoRow(String label, String value) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 4),
//       child: Row(
//         children: [
//           Text('$label: ',
//               style: const TextStyle(fontWeight: FontWeight.bold)),
//           Expanded(child: Text(value)),
//         ],
//       ),
//     );
//   }
// }

// /// Simple gallery page for showing photos.
// class PhotoGalleryPage extends StatelessWidget {
//   final List<String> urls;
//   const PhotoGalleryPage({Key? key, required this.urls}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Photos')),
//       body: GridView.builder(
//         padding: const EdgeInsets.all(8),
//         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 3,
//           crossAxisSpacing: 8,
//           mainAxisSpacing: 8,
//         ),
//         itemCount: urls.length,
//         itemBuilder: (ctx, i) => Image.network(urls[i], fit: BoxFit.cover),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:edunourish/features/student/providers/student_provider.dart';
import 'package:edunourish/core/models/subject_info.dart';
import 'package:edunourish/features/student/screens/home/profile_screen.dart';

class SubjectScreen extends StatelessWidget {
  const SubjectScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final prov = context.watch<StudentProvider>();

    // 1) loading
    if (prov.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    final subjects = prov.subjects;
    // 2) empty state
    if (subjects.isEmpty) {
      return const Center(child: Text('No subjects available.'));
    }

    return Scaffold(
      body: Stack(
        children: [
          // Background gradient
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xffcdc9cf), Color(0xffe8e6e9)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  _buildAppBar(context),
                  const SizedBox(height: 20),
                  _buildSearchField(),
                  const SizedBox(height: 20),
                  // 3) grid of subjects
                  Expanded(
                    child: GridView.builder(
                      itemCount: subjects.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        childAspectRatio: 0.8,
                      ),
                      itemBuilder: (ctx, i) => _buildSubjectCard(
                        context,
                        subjects[i],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // back
        IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        const Text(
          "Subjects",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        // profile
        GestureDetector(
          child: CircleAvatar(
            backgroundColor: Colors.grey.shade300,
            child: const Icon(Icons.person, color: Colors.black54),
          ),
          onTap: () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => const ProfilePageStudent(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSearchField() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
      ),
      child: const TextField(
        decoration: InputDecoration(
          hintText: "Search subjects…",
          prefixIcon: Icon(Icons.search),
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(15),
        ),
      ),
    );
  }

  Widget _buildSubjectCard(BuildContext context, SubjectInfo s) {
    IconData icon;
    switch (s.category.toLowerCase()) {
      case 'math':
        icon = Icons.calculate;
        break;
      case 'science':
        icon = Icons.science;
        break;
      case 'english':
        icon = Icons.language;
        break;
      case 'arabic':
        icon = Icons.translate;
        break;
      case 'ict':
        icon = Icons.computer;
        break;
      case 'pe':
        icon = Icons.sports_soccer;
        break;
      case 're':
        icon = Icons.self_improvement;
        break;
      default:
        icon = Icons.book;
    }

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 4,
      child: InkWell(
        borderRadius: BorderRadius.circular(15),
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => SubjectDetailScreen(subject: s),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // icon at top
            Expanded(
              child: Center(
                child: Icon(icon, size: 48, color: Colors.blueGrey),
              ),
            ),
            const SizedBox(height: 8),
            // subject name
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                s.name,
                style: const TextStyle(
                    fontSize: 16, fontWeight: FontWeight.bold),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            // optional description
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Text(
                s.description,
                style:
                    const TextStyle(fontSize: 14, color: Colors.black54),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}


class SubjectDetailScreen extends StatelessWidget {
  final SubjectInfo subject;

  const SubjectDetailScreen({Key? key, required this.subject})
      : super(key: key);

  Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('$label:', style: const TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(width: 8),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(subject.name)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _infoRow('Code', subject.code),
            _infoRow('Category', subject.category),
            _infoRow('Grade Level', subject.gradeLevel),
            _infoRow('Semester', subject.semester),
            const SizedBox(height: 12),
            const Text('Description:',
                style: TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 4),
            Text(subject.description),
          ],
        ),
      ),
    );
  }
}

import 'package:edunourish/core/models/news.dart';
import 'package:edunourish/features/student/providers/student_provider.dart';
import 'package:edunourish/features/student/screens/home/notifiactions_student_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class Activities extends StatelessWidget {
  final List<Map<String, String>> categories = [
    {'title': 'general', 'image': "assets/student/Home_Student/general.jpg"},
    {
      'title': 'competition',
      'image': "assets/student/Home_Student/competition.jpg"
    },
    {'title': 'trip', 'image': "assets/student/Home_Student/Trips.png"},
    {'title': 'concert', 'image': "assets/student/Home_Student/Parties.png"},
  ];

  Activities({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff2f2f2),
      appBar: AppBar(
        title: const Text(
          "Activities",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        leading: IconButton(
          icon: const Icon(Icons.notifications_none_outlined, size: 30),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => NotificationsStudentScreen(),
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
      body: ListView.builder(
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return CategoryCard(
            title: categories[index]['title']!,
            image: categories[index]['image']!,
          );
        },
      ),
    );
  }
}

// ---------- Category Card ----------
class CategoryCard extends StatelessWidget {
  final String title;
  final String image;

  const CategoryCard({super.key, required this.title, required this.image});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LoadingScreen(title: title),
          ),
        );
      },
      child:
       Card(
        margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
      //  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        color: Colors.white.withOpacity(0.2),
        
        child: Column(
          children: [
             const SizedBox(height: 30),
            Image.asset(
              image,
              height: 250,
             width: double.infinity,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(
                color: Color(0xff008f99),
                fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}

// ---------- Loading Screen ----------


class LoadingScreen extends StatefulWidget {
  final String title;

  const LoadingScreen({super.key, required this.title});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();

    // Wait 2 seconds then navigate
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => NewsScreen(category: widget.title),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 223, 222, 222),
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.title,  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),),
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        leading: const BackButton(),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Loading...", style: TextStyle(fontSize: 16)),
            SizedBox(height: 20),
            LinearProgressIndicator(
              minHeight: 4,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.teal),
              backgroundColor: Color.fromARGB(255, 255, 255, 255),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------- News Screen ----------

class NewsScreen extends StatelessWidget {
  final String category;
  const NewsScreen({Key? key, required this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final prov = context.watch<StudentProvider>();
    if (prov.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    final newsList = prov.newsList.where((n) => n.type == category).toList();
    if (newsList.isEmpty) {
      return Center(child: Text('No articles available in $category.'));
    }

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 223, 222, 222),
      appBar: AppBar(
        
        leading: const BackButton(),
        title: Text(
          category,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        itemCount: newsList.length,
        itemBuilder: (context, index) {
          final article = newsList[index];
          return _NewsCard(article: article);
        },
      ),
    );
  }
}

class _NewsCard extends StatelessWidget {
  final News article;
  const _NewsCard({Key? key, required this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          article.photo.startsWith('http')
              ? Image.network(article.photo, fit: BoxFit.cover)
              : Image.asset(article.photo, fit: BoxFit.cover),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              article.title,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              article.title,
              style: const TextStyle(fontSize: 16),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            child: Text(
              article.content,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            child: Text(
              DateFormat.yMMMd().format(article.date),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 13, color: Colors.teal),
            ),
          ),
        ],
      ),
    );
  }
}
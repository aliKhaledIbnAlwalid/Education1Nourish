import 'dart:convert';
import 'package:edunourish/features/student/providers/student_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:edunourish/features/auth/models/login_response.dart';
import 'package:edunourish/features/student/widgets/btm_nav_bar_student.dart';
import 'package:edunourish/features/teacher/widgets/btm_nav_bar.dart';
import 'package:jwt_decoder/jwt_decoder.dart'; 

class AuthProvider extends ChangeNotifier {
  final String role;
  AuthProvider({required this.role});

  final TextEditingController idController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isLoading = false;

  Future<void> login(BuildContext context) async {
    final id = idController.text.trim();
    final password = passwordController.text;
    if (id.isEmpty || password.isEmpty) return;

    isLoading = true;
    notifyListeners();

    try {
      final uri = Uri.parse('http://54.242.19.19:3000/api/Login/');
      final resp = await http.post(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'id': id, 'password': password}),
      );

      if (resp.statusCode == 200) {
        final loginResp = LoginResponse.fromJson(jsonDecode(resp.body));

        // save token
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('auth_token', loginResp.token);

        // Preload student data
        final studentProv =
            Provider.of<StudentProvider>(context, listen: false);
        await studentProv.loadInitialData();

        // navigate based on server‑returned role 
        if (loginResp.role == 'teacher') {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const BtmNavBarTeacher()),
          );
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const BtmNavBarStudent()),
          );
        }
      } else {
        final err = jsonDecode(resp.body) as Map<String, dynamic>;
        _showError(context, err['message'] ?? 'Login failed');
      }
    } catch (e) {
      _showError(context, 'Error: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void _showError(BuildContext ctx, String msg) {
    ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(content: Text(msg)));
  }

  @override
  void dispose() {
    idController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}

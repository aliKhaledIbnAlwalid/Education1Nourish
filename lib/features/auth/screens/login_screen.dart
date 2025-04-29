import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login';
  final String role;
  const LoginScreen({Key? key, required this.role}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with TickerProviderStateMixin {
  late final AnimationController _formController;
  late final Animation<Offset> _idFieldAnim,
      _passwordAnim,
      _forgetAnim,
      _loginBtnAnim;
  bool _obscureText = true;
  bool _rememberMe = false;

  @override
  void initState() {
    super.initState();
    _formController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _idFieldAnim =
        Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero).animate(
      CurvedAnimation(
          parent: _formController,
          curve: const Interval(0.0, 0.25, curve: Curves.easeOut)),
    );
    _passwordAnim =
        Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero).animate(
      CurvedAnimation(
          parent: _formController,
          curve: const Interval(0.25, 0.5, curve: Curves.easeOut)),
    );
    _forgetAnim =
        Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero).animate(
      CurvedAnimation(
          parent: _formController,
          curve: const Interval(0.5, 0.75, curve: Curves.easeOut)),
    );
    _loginBtnAnim =
        Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero).animate(
      CurvedAnimation(
          parent: _formController,
          curve: const Interval(0.75, 1.0, curve: Curves.easeOut)),
    );

    _formController.forward();
  }

  @override
  void dispose() {
    _formController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ChangeNotifierProvider<AuthProvider>(
      create: (_) => AuthProvider(role: widget.role),
      child: Consumer<AuthProvider>(
        builder: (ctx, auth, _) => Scaffold(
          resizeToAvoidBottomInset: false,
          body: SingleChildScrollView(
            child: Column(
              children: [
                // Header
                Stack(
                  children: [
                    Container(
                      height: size.height * 0.35,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: Color(0xFF008f99),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30),
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 24),
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Spacer(),
                          Text(
                            'Welcome Back!',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Log in to continue',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      top: size.height * 0.10,
                      left: size.width / 2 - 50,
                      child: Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                          border: Border.all(color: Colors.white, width: 4),
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.school,
                            size: 48,
                            color:Color(0xFF008f99),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 60),
                // Form
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // ID Number
                      SlideTransition(
                        position: _idFieldAnim,
                        child: TextField(
                          controller: auth.idController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: 'ID Number',
                            border: OutlineInputBorder(
                              
                                borderRadius: BorderRadius.circular(12)),
                            prefixIcon: const Icon(Icons.perm_identity,color: Color(0xFF008f99),),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      // Password
                      SlideTransition(
                        position: _passwordAnim,
                        child: TextField(
                          controller: auth.passwordController,
                          obscureText: _obscureText,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12)),
                            prefixIcon: const Icon(Icons.lock_outline_rounded,color: Color(0xFF008f99)),
                            suffixIcon: IconButton(
                              icon: Icon(_obscureText
                                  ? Icons.visibility_off
                                  : Icons.visibility,color: Color(0xFF008f99),),
                              onPressed: () =>
                                  setState(() => _obscureText = !_obscureText),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      // Remember & Forgot
                      SlideTransition(
                        position: _forgetAnim,
                        child: Row(
                          children: [
                            Checkbox(
                              value: _rememberMe,
                              onChanged: (val) =>
                                  setState(() => _rememberMe = val ?? false),
                            ),
                            const Text('Remember me',
                                style: TextStyle(
                                  color: Color(0xFF008f99),
                                )),
                            const Spacer(),
                            TextButton(
                              onPressed: () {},
                              child: const Text(
                                'Forgot password?',
                                style: TextStyle(
                                  color: Color(0xFF008f99),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 24),
                      // Login Button
                      SlideTransition(
                        position: _loginBtnAnim,
                        child: SizedBox(
                          height: 50,
                          child: ElevatedButton(
                      
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF008f99),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)),
                              iconColor: const Color(0xFF009688),
                            ),
                            onPressed: auth.isLoading
                                ? null
                                : () => auth.login(context),
                            child: auth.isLoading
                                ? const CircularProgressIndicator(
                                    color: Colors.white)
                                : const Text('Log In',
                                    style: TextStyle(fontSize: 18,color: Colors.white)),
                          ),
                        ),
                      ),

                      const SizedBox(height: 16),
                      // Register Link
                      Center(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text("Don't have an account?"),
                            TextButton(
                              onPressed: () {/* TODO: register */},
                              child: const Text('Register',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold,color: Color(0xFF008f99),)
                                      
                                      
                                      ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
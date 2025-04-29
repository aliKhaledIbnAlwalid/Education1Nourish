import 'package:flutter/material.dart';

class LoginForm extends StatelessWidget {
  // renamed “emailAnim” → “idAnim” and “emailController” → “idController”
  final Animation<Offset> idAnim;
  final Animation<Offset> passwordAnim;
  final Animation<Offset> forgetAnim;
  final Animation<Offset> loginAnim;

  final VoidCallback    onLoginPressed;
  final bool            isLoading;
  final TextEditingController idController;
  final TextEditingController passwordController;

  const LoginForm({
    Key? key,
    required this.idAnim,
    required this.passwordAnim,
    required this.forgetAnim,
    required this.loginAnim,
    required this.onLoginPressed,
    required this.isLoading,
    required this.idController,
    required this.passwordController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Spacer(flex: 3),

        // ID Number field
        SlideTransition(
          position: idAnim,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              controller: idController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "ID Number",
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                prefixIcon: const Icon(Icons.perm_identity),
              ),
            ),
          ),
        ),

        const SizedBox(height: 20),

        // Password
        SlideTransition(
          position: passwordAnim,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: "Password",
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                prefixIcon: const Icon(Icons.lock),
              ),
            ),
          ),
        ),

        const SizedBox(height: 10),

        // Remember & Forgot
        SlideTransition(
          position: forgetAnim,
          child: Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.only(right: 30),
              child: TextButton(
                onPressed: () {},
                child: const Text("Forget Password",
                    style: TextStyle(color: Colors.white)),
              ),
            ),
          ),
        ),

        const SizedBox(height: 20),

        // Login button
        SlideTransition(
          position: loginAnim,
          child: isLoading
              ? const CircularProgressIndicator()
              : ElevatedButton(
                  onPressed: onLoginPressed,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 15),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    backgroundColor: Colors.white,
                  ),
                  child: const Text("Log In",
                      style:
                          TextStyle(fontSize: 18, color: Colors.blueGrey)),
                ),
        ),

        const Spacer(flex: 4),
      ],
    );
  }
}

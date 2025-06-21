import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'home_page.dart';
import 'SignupScreen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _obscurePassword = true;

  Future<void> _submitForm(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(_formKey.currentContext!).showSnackBar(
        const SnackBar(content: Text('Form submitted successfully')),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    }
  }

  
  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }

    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Enter a valid email address';
    }

    return null;
  }

  
  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }

    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 250, 240),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(
              'assets/famous.png',
              height: 290,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Log in",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 6, 65, 113),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    
                    Material(
                      elevation: 10,
                      borderRadius: BorderRadius.circular(10),
                      shadowColor: Colors.black.withOpacity(1),
                      child: TextFormField(
                        controller: _emailController,
                        cursorColor: Color.fromARGB(255, 6, 65, 113),
                        keyboardType: TextInputType.emailAddress,
                        decoration: _buildInput("Email", Icons.email),
                        validator: _validateEmail,
                      ),
                    ),
                    const SizedBox(height: 16),

                    
                    Material(
                      elevation: 10,
                      borderRadius: BorderRadius.circular(10),
                      shadowColor: Colors.black.withOpacity(1),
                      child: TextFormField(
                        controller: _passwordController,
                        cursorColor: Color.fromARGB(255, 6, 65, 113),
                        obscureText: _obscurePassword,
                        decoration: _buildPasswordInput(),
                        validator: _validatePassword,
                      ),
                    ),
                    const SizedBox(height: 24),

                    // زر تسجيل الدخول
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                        ),
                        onPressed: () => _submitForm(context),
                        child: const Text(
                          "Log in",
                          style: TextStyle(
                            fontSize: 20,
                            color: Color.fromARGB(255, 6, 65, 113),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 25),

                    // رابط تسجيل حساب
                    Center(
                      child: RichText(
                        text: TextSpan(
                          children: [
                            const TextSpan(
                              text: 'First time on the app?  ',
                              style: TextStyle(
                                color: Color.fromARGB(255, 6, 65, 113),
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(
                              text: 'Sign up here',
                              style: const TextStyle(
                                color: Colors.orange,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                        builder: (context) => SignupScreen()),
                                    (route) => false,
                                  );
                                },
                            ),
                          ],
                        ),
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

  // ديكوريشن لحقل الإيميل
  InputDecoration _buildInput(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(
        icon,
        color: const Color.fromARGB(255, 6, 65, 113),
      ),
      filled: true,
      fillColor: const Color.fromARGB(255, 255, 250, 240),
      labelStyle: const TextStyle(color: Colors.grey),
      floatingLabelStyle: const TextStyle(color: Colors.orange),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(
          color: Color.fromARGB(255, 6, 65, 113),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Colors.orange),
      ),
    );
  }

  // ديكوريشن لحقل الباسوورد مع زر "العين"
  InputDecoration _buildPasswordInput() {
    return InputDecoration(
      labelText: "Password",
      prefixIcon: const Icon(
        Icons.lock,
        color: Color.fromARGB(255, 6, 65, 113),
      ),
      suffixIcon: IconButton(
        icon: Icon(
          _obscurePassword ? Icons.visibility : Icons.visibility_off,
          color: Color.fromARGB(255, 6, 65, 113),
        ),
        onPressed: () {
          setState(() {
            _obscurePassword = !_obscurePassword;
          });
        },
      ),
      filled: true,
      fillColor: const Color.fromARGB(255, 255, 250, 240),
      labelStyle: const TextStyle(color: Colors.grey),
      floatingLabelStyle: const TextStyle(color: Colors.orange),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(
          color: Color.fromARGB(255, 6, 65, 113),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Colors.orange),
      ),
    );
  }
}

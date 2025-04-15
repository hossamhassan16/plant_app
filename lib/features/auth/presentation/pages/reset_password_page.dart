import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:plant_app/helper/show_snack_bar.dart';
import 'package:plant_app/features/auth/presentation/widgets/custom_text_form_field.dart';
import 'package:plant_app/features/onboarding/presentation/widgets/next_animated_button.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  String? email;
  final formKey = GlobalKey<FormState>();
  bool isSending = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 171, 210, 249), // Light Blue
              Color(0xFFF5F7DC), // Light Yellow
              Color(0xFFDFFFE0), // Very Light Green
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                const SizedBox(height: 100),
                Image.asset("assets/images/reset_password.png"),
                const SizedBox(height: 32),
                const Text(
                  'Enter your email to receive password reset link',
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 30),
                CustomTextFormField(
                  prefixIcon: const Icon(Icons.email),
                  hintText: 'Email',
                  onChanged: (value) {
                    email = value;
                  },
                ),
                const SizedBox(height: 20),
                NextAnimatedButton(
                  text: isSending ? 'Sending...' : 'Send Reset Email',
                  onTap: () async {
                    if (formKey.currentState!.validate()) {
                      setState(() => isSending = true);
                      try {
                        await FirebaseAuth.instance
                            .sendPasswordResetEmail(email: email!);
                        ShowSnackBar(context,
                            'Password reset email sent! Check your inbox.');
                        Navigator.pop(context); // Return to login
                      } on FirebaseAuthException catch (e) {
                        ShowSnackBar(context, e.message ?? 'Error occurred');
                      } finally {
                        setState(() => isSending = false);
                      }
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

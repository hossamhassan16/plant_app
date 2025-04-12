import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:plant_app/features/auth/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:plant_app/features/auth/presentation/widgets/custom_text_form_field.dart';
import 'package:plant_app/features/home/presentation/pages/main_page.dart';
import 'package:plant_app/features/onboarding/presentation/widgets/next_animated_button.dart';
import 'package:plant_app/helper/show_snack_bar.dart';

class RegisterationPage extends StatefulWidget {
  const RegisterationPage({super.key});

  @override
  State<RegisterationPage> createState() => _RegisterationPageState();
}

class _RegisterationPageState extends State<RegisterationPage> {
  String? email;
  String? password;
  GlobalKey<FormState> formKey = GlobalKey();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is RegisterLoading) {
          isLoading = true;
        } else if (state is RegisterSuccess) {
          Navigator.pushNamed(
            context,
            main_page.id,
            arguments: email,
          );
          isLoading = false;
        } else if (state is RegisterFailure) {
          ShowSnackBar(context, state.errMessage);
          isLoading = false;
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: isLoading,
          child: Scaffold(
            body: Container(
              decoration: BoxDecoration(
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
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Form(
                  key: formKey,
                  child: ListView(
                    children: [
                      const SizedBox(height: 150),
                      Image.asset(
                        "assets/images/signup.png",
                        height: 200,
                      ),
                      SizedBox(
                        height: 32,
                      ),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Create new account",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 24,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      CustomTextFormField(
                        prefixIcon: Icon(Icons.email),
                        onChanged: (data) {
                          email = data;
                        },
                        hintText: "Email",
                      ),
                      const SizedBox(height: 10),
                      CustomTextFormField(
                        prefixIcon: Icon(Icons.lock),
                        obsecureText: true,
                        hintText: "Password",
                        onChanged: (data) {
                          password = data;
                        },
                      ),
                      const SizedBox(height: 10),
                      const SizedBox(height: 20),
                      Center(
                        child: NextAnimatedButton(
                          onTap: () async {
                            if (formKey.currentState!.validate()) {
                              BlocProvider.of<AuthBloc>(context).add(
                                RegisterEvent(
                                    email: email!, password: password!),
                              );
                            }
                          },
                          text: "Sign up",
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Already have an account? ",
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text(
                              "Login",
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

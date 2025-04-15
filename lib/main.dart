import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plant_app/features/auth/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:plant_app/features/auth/presentation/pages/login_page.dart';
import 'package:plant_app/features/auth/presentation/pages/registeration_page.dart';
import 'package:plant_app/features/auth/presentation/pages/reset_password_page.dart';
import 'package:plant_app/features/home/presentation/pages/cubits/articles_cubit/articles_cubit.dart';
import 'package:plant_app/features/home/presentation/pages/cubits/chat_cubit/chat_cubit.dart';
import 'package:plant_app/features/home/presentation/pages/home/articles_page.dart';
import 'package:plant_app/features/home/presentation/pages/home/chatbot_page.dart';
import 'package:plant_app/features/home/presentation/pages/home/greenhouse_page.dart';
import 'package:plant_app/features/home/presentation/pages/home/settings/cubits/change_password_cubit/change_password_cubit.dart';
import 'package:plant_app/features/home/presentation/pages/main_page.dart';
import 'package:plant_app/features/home/presentation/pages/home/settings/setting_page.dart';
import 'package:plant_app/features/onboarding/presentation/pages/onboard_page.dart';
import 'package:plant_app/features/onboarding/presentation/pages/onboard_screen.dart';
import 'package:plant_app/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const PlantApp());
}

class PlantApp extends StatelessWidget {
  const PlantApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc(),
        ),
        BlocProvider(
          create: (context) => ChatCubit(),
        ),
        BlocProvider(
          create: (context) => ArticlesCubit(),
        ),
        BlocProvider(
          create: (context) => ChangePasswordCubit(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: OnboardScreen.routeName,
        routes: {
          OnboardScreen.routeName: (context) => OnboardPage(),
          "LoginPage": (context) => const LoginPage(),
          "RegisterationPage": (context) => const RegisterationPage(),
          "HomePage": (context) => const main_page(),
          "GreenhousePage": (context) => const GreenhousePage(),
          "ArticlesPage": (context) => const ArticlesPage(),
          "SettingsPage": (context) => const SettingsPage(),
          ChatbotPage.id: (context) => const ChatbotPage(),
          ArticlesPage.id: (context) => const ArticlesPage(),
          "ResetPasswordPage": (context) => const ResetPasswordPage(),
        },
      ),
    );
  }
}

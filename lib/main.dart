import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/home.dart';
import 'package:flutter_application_1/profile_view.dart';
import 'package:flutter_application_1/screens/welcome_screen.dart';
import 'package:flutter_application_1/screens/signin_screen.dart';
import 'package:flutter_application_1/screens/signup_screen.dart';
import 'package:flutter_application_1/Onboboarding/onboarding_view.dart';
import 'package:flutter_application_1/theme/theme.dart';
import 'package:flutter_application_1/water_quality_charts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'theme/colo.dart';
import 'package:flutter_application_1/main_tab_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_application_1/noti_service.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  AwesomeNotifications().initialize(
    null,
  [
    NotificationChannel(
      channelGroupKey: 'reminders',
      channelKey: 'instant_notification',
      channelName: 'Basic Instant Notification',
      channelDescription:
      'Notification channel that can trigger notification instantly.',
      defaultColor: const Color(0xFF9D50DD),
      ledColor: Colors.white,
    ),
  ],
  );
  WidgetsFlutterBinding.ensureInitialized();
  NotificationService().initNotification();
  runApp(const MyApp());
}
class Notify {
  static Future<bool> instantNotify(String Val) async {
  final AwesomeNotifications awesomeNotifications = AwesomeNotifications();
  return awesomeNotifications.createNotification(
  content: NotificationContent(
  id: 100,
  title: "Water Quality Monitoring",
  body: "Water quality is bad. Please fix it quickly. The value of $Val is Unsafe",
  channelKey: 'instant_notification',
  ),
  );
  }
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    
    return FutureBuilder<bool>(
      future: _checkOnboardingCompleted(), // Check if onboarding is completed
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator(); 
        } else {
          final bool onboardingCompleted = snapshot.data ?? false;
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primaryColor: TColor.primaryColor1,
              fontFamily: "Poppins"
            ),
            home: const OnboardingView(),
            
            //debugShowCheckedModeBanner: false,
            //title: 'Flutter Demo',
            //theme: lightMode,
            //initialRoute: onboardingCompleted ? '/' : '/onboarding', // Navigate based on onboarding completion
            //routes: {
              //'/': (context) => const WelcomeScreen(),
              //'/signin': (context) => const SignInScreen(),
              //'/signup': (context) => const SignUpScreen(),
              //'/onboarding': (context) => const OnboardingView(), // Add route to the onboarding page
            //},
            
          );
        }
      },
    );
  }

  Future<bool> _checkOnboardingCompleted() async {
    //final prefs = await SharedPreferences.getInstance();
    final preferences = await SharedPreferences.getInstance();
    await preferences.clear();
    return false;
    //return prefs.getBool('onboarding') ?? false; // Return true if onboarding is completed, false otherwise
  }
}


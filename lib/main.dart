import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hombuddy/pages/ExpertPages/ExpertHomePageNew.dart';
import 'package:hombuddy/pages/FlowsCreation/Flow1.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'firebase_options.dart';
import 'pages/First Flow Pages/SplashPage.dart';
import 'pages/FlowsBooking/CartModel.dart';
import 'pages/UserPages/ActivityPage.dart';
import 'pages/ExpertPages/ExpertWallet.dart';
import 'pages/ExpertPages/ExpertAccount.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Initialize local notifications
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  const InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
  );

  await flutterLocalNotificationsPlugin.initialize(initializationSettings);

  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isFirstLaunch = prefs.getBool('first_launch') ?? true;

  if (isFirstLaunch) {
    await prefs.setBool('first_launch', false);
  }

  User? initialUser = FirebaseAuth.instance.currentUser;

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartModel()),
      ],
      child: MyApp(initialUser: initialUser, isFirstLaunch: isFirstLaunch),
    ),
  );
}

class MyApp extends StatelessWidget {
  final User? initialUser;
  final bool isFirstLaunch;

  const MyApp(
      {super.key, required this.initialUser, required this.isFirstLaunch});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: isFirstLaunch
          ? const SplashScreen()
          : initialUser == null
              ? const SignUpHomePage()
              : const AuthenticationWrapper(),
      routes: {
        '/activity': (context) => const ActivityPage(),
        '/expertHome': (context) => ExpertHomePage(
            email: ModalRoute.of(context)!.settings.arguments as String),
        '/expertWallet': (context) => ExpertWallet(
            email: ModalRoute.of(context)!.settings.arguments as String),
        '/expertAccount': (context) => ExpertAccount(
            email: ModalRoute.of(context)!.settings.arguments as String),
      },
    );
  }
}

class AuthenticationWrapper extends StatelessWidget {
  const AuthenticationWrapper({super.key, Key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        User? user = snapshot.data;

        if (user == null) {
          return const SignUpHomePage();
        } else {
          // Determine user type and navigate accordingly
          return FutureBuilder<DocumentSnapshot>(
            future: FirebaseFirestore.instance
                .collection('User')
                .doc(user.uid)
                .get(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }

              if (snapshot.hasData) {
                var userData = snapshot.data!.data() as Map<String, dynamic>;

                if (userData['userType'] == 'expert') {
                  return ExpertHomePage(email: user.email!);
                } else {
                  return const ActivityPage();
                }
              } else {
                return const ActivityPage();
              }
            },
          );
        }
      },
    );
  }
}

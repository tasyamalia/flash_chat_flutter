import 'package:firebase_core/firebase_core.dart';
import 'package:flash_chat_flutter/firebase_options.dart';
import 'package:flash_chat_flutter/screens/chat_screen.dart';
import 'package:flash_chat_flutter/screens/login_screen.dart';
import 'package:flash_chat_flutter/screens/registration_screen.dart';
import 'package:flash_chat_flutter/screens/welcome_screen.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const FlashChat());
}

class FlashChat extends StatelessWidget {
  const FlashChat({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const WelcomeScreen(),
      initialRoute: WelcomeScreen.routeName,
      routes: {
        WelcomeScreen.routeName: (context) => WelcomeScreen(),
        LoginScreen.routeName: (context) => LoginScreen(),
        RegistrationScreen.routeName: (context) => RegistrationScreen(),
        ChatScreen.routeName: (context) => ChatScreen()
      },
    );
  }
}

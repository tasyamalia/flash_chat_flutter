import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat_flutter/components/loading.dart';
import 'package:flash_chat_flutter/components/rounded_button.dart';
import 'package:flash_chat_flutter/constants.dart';
import 'package:flash_chat_flutter/screens/chat_screen.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/LoginScreen';
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  String email = '';
  String password = '';
  bool _isLoading = false;

  void setLoading(bool isLoading) {
    setState(() {
      _isLoading = isLoading;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Flexible(
                  child: Hero(
                    tag: 'logo',
                    child: SizedBox(
                      height: 200.0,
                      child: Image.asset('images/logo.png'),
                    ),
                  ),
                ),
                SizedBox(
                  height: 48.0,
                ),
                TextField(
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (value) {
                      email = value;
                    },
                    decoration: kTextFieldDecoration.copyWith(
                        hintText: 'Enter your email')),
                SizedBox(
                  height: 8.0,
                ),
                TextField(
                    obscureText: true,
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      password = value;
                    },
                    decoration: kTextFieldDecoration.copyWith(
                        hintText: 'Enter your password.')),
                SizedBox(
                  height: 24.0,
                ),
                RoundedButton(
                  color: Colors.lightBlueAccent,
                  title: 'Log In',
                  onPressed: () async {
                    try {
                      if (email.isNotEmpty && password.isNotEmpty) {
                        setLoading(true);
                        await _auth.signInWithEmailAndPassword(
                            email: email, password: password);
                        if (mounted) {
                          setLoading(false);
                          Navigator.pushNamed(context, ChatScreen.routeName);
                        }
                      }
                    } catch (e) {
                      setLoading(false);
                      print(e);
                    }
                  },
                ),
              ],
            ),
          ),
          if (_isLoading) const Loading()
        ],
      ),
    );
  }
}

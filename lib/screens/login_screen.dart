import 'package:currencyConverter/providers/auth_provider.dart';
import 'package:currencyConverter/screens/add_base_currency.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  static const String route = 'loginscreen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  Auth auth;
  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    auth = Provider.of<Auth>(context);
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: Center(
          child: MaterialButton(
            color: Colors.white,
            onPressed: () {
              auth.handleSignIn(context);
            },
            child: Text('Google Sign In'),
          ),
        ),
      ),
    );
  }
}

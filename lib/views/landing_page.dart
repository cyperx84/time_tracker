
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker/services/auth.dart';
import 'package:time_tracker/views/home_page.dart';
import 'package:time_tracker/views/sign_in/sign_in_page.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthBase>(context);
    return StreamBuilder<User>(
      stream: auth.onAuthStateChanged,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          User user = snapshot.data;
          if (user == null) {
            return SignInPage(
            );
          }
          return HomePage(
          );
        } else {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(
                strokeWidth: 10.0,
              ),
            ),
          );
        }
      },
    );
  }
}

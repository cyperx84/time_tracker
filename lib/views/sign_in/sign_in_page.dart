import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker/services/auth.dart';
import 'package:time_tracker/views/sign_in/email_sign_in_page.dart';
import 'package:time_tracker/views/sign_in/sign_in_button.dart';
import 'package:time_tracker/views/sign_in/social_sign_in_button.dart';

class SignInPage extends StatelessWidget {
  Future<void> _signInAnonymously(BuildContext context) async {
    try {
      final auth = Provider.of<AuthBase>(context);
      await auth.signInAnonymously();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _signInWithGoogle(BuildContext context) async {
    try {
      final auth = Provider.of<AuthBase>(context);
      await auth.signinWithGoogle();
    } catch (e) {
      print(e.toString());
    }
  }

  // Future<void> _signInWithFacebook(BuildContext context) async {
  //   try {
  //     final auth = Provider.of<AuthBase>(context);
  //     await auth.signInWithFacebook();
  //   } catch (e) {
  //     print(e.toString());
  //   }
  // }

  void _signInWithEmail(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute<void>(
      fullscreenDialog: true,
      builder: (context) => EmailSignInPage(),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text('Time Tracker'),
        elevation: 3.0,
      ),
      body: _buildContent(context),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            'Sign In',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 45,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(
            height: 48,
          ),
          SocialSignInButton(
            assetImgName: 'images/google-logo.png',
            text: 'Sign in with Google',
            textColor: Colors.black87,
            color: Colors.white,
            onPressed:() => _signInWithGoogle(context),
          ),
          SizedBox(
            height: 10,
          ),
          SocialSignInButton(
            assetImgName: 'images/facebook-logo.png',
            text: 'Sign in with Facebook',
            textColor: Colors.white,
            color: Color(0xFF334D92),
            onPressed: () {},
          ),
          SizedBox(
            height: 10,
          ),
          SignInButton(
            text: 'Sign in with Email',
            textColor: Colors.white,
            color: Colors.teal,
            onPressed: () => _signInWithEmail(context),
          ),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Text(
              'or',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20.0, color: Colors.black87),
            ),
          ),
          SignInButton(
            text: 'Sign in without credentials',
            textColor: Colors.black,
            color: Colors.lightGreenAccent,
            onPressed:() => _signInAnonymously(context),
          ),
        ],
      ),
    );
  }
}

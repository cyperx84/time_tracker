import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker/services/auth.dart';
import 'package:time_tracker/views/sign_in/email_sign_in_page.dart';
import 'package:time_tracker/views/sign_in/sign_in_button.dart';
import 'package:time_tracker/views/sign_in/social_sign_in_button.dart';
import 'package:time_tracker/widgets/platform_exception_alert_dialog.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  bool _isLoading = false;

  void _showSignInError(BuildContext context, PlatformException exception) {
    PlatformExceptionAlertDialog(
      title: "Sign in failed",
      exception: exception,
    );
  }

  Future<void> _signInAnonymously(BuildContext context) async {
    try {
      setState(() => _isLoading = true);
      final auth = Provider.of<AuthBase>(context);
      await auth.signInAnonymously();
    } on PlatformException catch (e) {
      _showSignInError(context, e);
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _signInWithGoogle(BuildContext context) async {
    try {
      setState(() => _isLoading = true);
      final auth = Provider.of<AuthBase>(context);
      await auth.signinWithGoogle();
    } on PlatformException catch (e) {
      if (e.code != 'ERROR_ABORTED_BY_USER') {
        _showSignInError(context, e);
      }
    } finally {
      setState(() => _isLoading = false);
    }
  }

  // Future<void> _signInWithFacebook(BuildContext context) async {
  //   try {
  //     setState(() => _isLoading = true);
  //     final auth = Provider.of<AuthBase>(context);
  //     await auth.signinWithFacebook();
  //   } on PlatformException catch (e) {
  //     if (e.code != 'ERROR_ABORTED_BY_USER') {
  //       _showSignInError(context, e);
  //     }
  //   } finally {
  //     setState(() => _isLoading = false);
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
          SizedBox(
            height: 50,
            child: _buildHeader(),
          ),
          SizedBox(
            height: 48,
          ),
          SocialSignInButton(
            assetImgName: 'images/google-logo.png',
            text: 'Sign in with Google',
            textColor: Colors.black87,
            color: Colors.white,
            onPressed: _isLoading ? null : () => _signInWithGoogle(context),
          ),
          SizedBox(
            height: 10,
          ),
          SocialSignInButton(
            assetImgName: 'images/facebook-logo.png',
            text: 'Sign in with Facebook',
            textColor: Colors.white,
            color: Color(0xFF334D92),
            onPressed:_isLoading ? null : () {},
          ),
          SizedBox(
            height: 10,
          ),
          SignInButton(
            text: 'Sign in with Email',
            textColor: Colors.white,
            color: Colors.teal,
            onPressed: _isLoading ? null : () => _signInWithEmail(context),
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
            onPressed: _isLoading ? null : () => _signInAnonymously(context),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    if (_isLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    return Text(
      'Sign In',
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 45,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}

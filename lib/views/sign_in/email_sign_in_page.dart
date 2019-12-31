import 'package:flutter/material.dart';
// import 'package:time_tracker/views/sign_in/email_sign_in_form.dart';
import 'package:time_tracker/views/sign_in/email_sign_in_form_bloc_based.dart';
import 'package:time_tracker/views/sign_in/email_sign_in_form_change_notifier.dart';

class EmailSignInPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text('Time Tracker'),
        elevation: 3.0,
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
              child: Padding(
          padding: EdgeInsets.all(30.0),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
            child: EmailSignInFormChangeNotifier.create(context),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'package:time_tracker/app/home/jobs/edit_job_page.dart';
import 'package:time_tracker/app/home/jobs/job_list_tile.dart';
import 'package:time_tracker/app/home/jobs/list_items_builder.dart';
import 'package:time_tracker/app/home/models/job.dart';
import 'package:time_tracker/services/auth.dart';
import 'package:time_tracker/services/database.dart';
import 'package:time_tracker/widgets/platform_alert_dialog.dart';
import 'package:time_tracker/widgets/platform_exception_alert_dialog.dart';

class JobsPage extends StatelessWidget {
  Future<void> _signOut(BuildContext context) async {
    try {
      final auth = Provider.of<AuthBase>(context);
      await auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _confirmSignOut(BuildContext context) async {
    final didRequestSignOut = await PlatformAlertDialog(
      title: 'Logout',
      content: "Are you sure you want to logout?",
      cancelActionText: 'Cancel',
      defaultActionText: 'Logout',
    ).show(context);
    if (didRequestSignOut == true) {
      _signOut(context);
    }
  }

  Future<void> _delete(BuildContext context, Job job) async {
    try {
      final database = Provider.of<Database>(context);
      await database.deleteJob(job);
    } on PlatformException catch (e) {
      PlatformExceptionAlertDialog(
          title: 'Operation failed',
          exception: e,
        ).show(context);
    }
  }

  // Future<void> _createJob(BuildContext context) async {
  //   try {
  //     final database = Provider.of<Database>(context);
  //     database.createJob(Job(
  //       name: 'Blogging',
  //       ratePerHour: 10,
  //     ));
  //   } on PlatformException catch (e) {
  //     PlatformExceptionAlertDialog(
  //       title: 'Operation failed',
  //       exception: e,
  //     ).show(context);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Jobs'),
        actions: <Widget>[
          FlatButton(
            child: Text(
              'Logout',
              style: TextStyle(fontSize: 18.0, color: Colors.white),
            ),
            onPressed: () => _confirmSignOut(context),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => EditJobPage.show(context),
      ),
      body: _buildContents(context),
    );
  }

  Widget _buildContents(BuildContext context) {
    final database = Provider.of<Database>(context);
    return StreamBuilder<List<Job>>(
      stream: database.jobsStream(),
      builder: (context, snapshot) {
        return ListItemBuilder<Job>(
            snapshot: snapshot,
            itemBuilder: (context, job) => Dismissible(
                  background: Container(
                    color: Colors.red,
                  ),
                  direction: DismissDirection.endToStart,
                  onDismissed: (direction) => _delete(context, job),
                  key: Key('job-0${job.id}'),
                  child: JobListTile(
                    job: job,
                    onTap: () => EditJobPage.show(context, job: job),
                  ),
                ));
      },
    );
  }
}

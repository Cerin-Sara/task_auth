import 'package:authentication/model/intern.dart';
import 'package:authentication/screens/home/settings_form.dart';
import 'package:authentication/service/auth.dart';
import 'package:authentication/service/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'intern_list.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    void _showSettingsPanel() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
                color: Colors.red[100],
                child: Padding(
                    padding: EdgeInsets.all(15), child: SettingsForm()));
          });
    }

    return StreamProvider<List<Intern>>.value(
      value: DatabaseService().interns,
      child: Scaffold(
        backgroundColor: Colors.red[100],
        appBar: AppBar(
          backgroundColor: Colors.red[600],
          title: Text('Interns'),
          actions: [
            FlatButton.icon(
              onPressed: () async {
                await _auth.logOut();
              },
              icon: Icon(
                Icons.person,
                color: Colors.white,
              ),
              label: Text(
                'Sign Out',
                style: TextStyle(color: Colors.white),
              ),
            ),
            FlatButton.icon(
              onPressed: () => _showSettingsPanel(),
              icon: Icon(
                Icons.settings,
                color: Colors.white,
              ),
              label: Text('Settings', style: TextStyle(color: Colors.white)),
            )
          ],
        ),
        body: InternList(),
      ),
    );
  }
}

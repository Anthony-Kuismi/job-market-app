import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/theme_provider.dart';
import '../service/login_service.dart';
import '../viewmodel/settings_viewmodel.dart';
import 'component/drawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'login.dart';

class SettingsPage extends StatefulWidget {
  final TextEditingController settingsController = TextEditingController();
  final SettingsViewModel viewModel;

  var username;

  SettingsPage({super.key, required this.viewModel, required this.username});

  @override
  _settingsPage createState() => _settingsPage();
}

class _settingsPage extends State<SettingsPage> {
  late LoginService logInService =
      Provider.of<LoginService>(context, listen: false);

  void refresh() {
    setState(() {});
  }

  late Future _loadFuture;

  @override
  void initState() {
    super.initState();
    
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<SettingsViewModel>(context, listen: true);
    
    
    
        return Scaffold(
          appBar: AppBar(
            title: const Text('Settings'),
            automaticallyImplyLeading: true,
            backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          ),
          drawer: AppDrawer(
              key: const Key('AppDrawer'),
              currentPage: 'SettingsPage',
              user: widget.username),
          body: ListView(
            children: <Widget>[
              Container(
                margin: const EdgeInsets.all(8.0),
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondaryContainer,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: ListTile(
                  title: const Text('LinkedIn'),
                  subtitle: Text(viewModel.getLinkedIn() == '' ? 'Not Set' : widget.viewModel.getLinkedIn()),
                  trailing: const Icon(Icons.person),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProfileSettingsPage(
                            username: widget.username,
                          )),
                    );
                  },
                ),
              ),
              Container(
                margin: const EdgeInsets.all(8.0),
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondaryContainer,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: ListTile(
                  title: const Text('Dark Mode'),
                  trailing: Switch(
                    value: Theme.of(context).brightness == Brightness.dark,
                    onChanged: (value) {
                      Provider.of<ThemeProvider>(context, listen: false)
                          .toggleTheme();
                    },
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(8.0),
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondaryContainer,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: ListTile(
                  title: const Text('Logout'),
                  trailing: const Icon(Icons.logout),
                  onTap: () {
                    logInService.logOut();
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => GoogleLogin()),
                            (route) => false);
                  },
                ),
              ),
              Container(
                margin: const EdgeInsets.all(8.0),
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondaryContainer,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: ListTile(
                  title: const Text('Delete Account'),
                  trailing: const Icon(Icons.delete_forever),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Delete Account?'),
                          content: const Text(
                              'Are you sure you want to delete your account? This action cannot be undone.'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () {
                                logInService.logOut();
                                logInService.deleteUser();
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(builder: (context) => GoogleLogin()),
                                        (route) => false);
                              },
                              child: const Text('Delete'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ),
          Container(
            margin: const EdgeInsets.all(8.0),
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondaryContainer,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: const ListTile(
              title: Text(
                  'Acknowledgement: We would like to acknowledge the original authors of our datasets for this app. Bruno Bonfrisco, '
                      'Franco Seveso with the Software Development data, and Abhay Kumar with the AI/ML data.\n\n'
                      'Home Page Image @spencerbergen via Unsplash using the Unsplash License'),
            ),
          )
        ],
      ),
    );
  }
}

class ProfileSettingsPage extends StatefulWidget {
  final String username;

  ProfileSettingsPage({super.key, required this.username});

  @override
  _profileSettingsPage createState() => _profileSettingsPage();
}

class _profileSettingsPage extends State<ProfileSettingsPage> {
  void refresh() {
    setState(() {});
  }

  late Future _loadFuture;

  
  final _linkedinController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<SettingsViewModel>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('LinkedIn'),
        automaticallyImplyLeading: true,
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _linkedinController,
              decoration: const InputDecoration(labelText: 'LinkedIn URL'),
            ),
            ElevatedButton(
              onPressed: () {
                String linkedIn = _linkedinController.text;
                viewModel.setLinkedIn(linkedIn);
                viewModel.load();
                Navigator.of(context).pop();
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}

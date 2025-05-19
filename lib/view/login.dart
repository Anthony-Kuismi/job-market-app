import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../service/login_service.dart';
import 'homepage_view.dart';
import '../viewmodel/homepage_viewmodel.dart';

class GoogleLogin extends StatefulWidget {
  const GoogleLogin({super.key});

  @override
  State<GoogleLogin> createState() => _GoogleLogin();
}

class _GoogleLogin extends State<GoogleLogin> {
  

  @override
  Widget build(BuildContext context) {
    LoginService loginService = Provider.of<LoginService>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(5),
                child: Text(
                  'SWE Job Tracker',
                  style: Theme.of(context)
                      .textTheme
                      .displayMedium
                      ?.copyWith(fontWeight: FontWeight.w900),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5),
                child: Icon(
                  Icons.work,
                  size: 150,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    (loginService.userCred == null)
                        ? ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.black,
                              backgroundColor: Colors.white,
                              minimumSize:
                                  const Size(double.infinity, 50), 
                            ),
                            icon: Image.asset(
                              'lib/assets/google_logo.png',
                              height: 24,
                            ),
                            label: const Text('Log in with Google'),
                            onPressed: () async {
                              await loginService.logIn();
                              UserCredential? userCred = loginService.userCred;
                              if (userCred?.user != null) {
                                
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        ChangeNotifierProvider<
                                            HomePageViewModel>(
                                          create: (_) => HomePageViewModel(),
                                          builder: (context, child) {
                                            return HomePage(
                                              username:
                                              userCred!.user!.displayName ?? '',
                                              viewModel:
                                              Provider.of<HomePageViewModel>(
                                                  context),
                                            );
                                          },
                                        ),
                                  ),
                                );
                              }else{log("usercred?.user is null");}
                              
                            })
                        : Container(),
                  ],
                ),
              )
            ],
          ),
        
      );
    
  }
}

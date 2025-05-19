import 'package:flutter/material.dart';
import 'package:job_market_app/provider/theme_provider.dart';
import 'package:job_market_app/view/city_search_view.dart';
import 'package:job_market_app/view/career_goal_view.dart';
import 'package:job_market_app/view/job_search_view.dart';
import 'package:job_market_app/view/settings_view.dart';
import 'package:job_market_app/viewmodel/career_goal_viewmodel.dart';
import 'package:job_market_app/service/firestore_service.dart';
import 'provider/app_provider.dart';
import 'package:job_market_app/view/homepage_view.dart';
import 'package:job_market_app/viewmodel/homepage_viewmodel.dart';
import 'package:job_market_app/viewmodel/job_search_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';
import 'view/login.dart';
import 'service/navigator_service.dart';
import 'view/search_view.dart';
import 'viewmodel/settings_viewmodel.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final NavigatorService navigatorService = NavigatorService();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: MyApp(
        navigatorService: navigatorService,
        isLoggedIn: isLoggedIn,
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  final NavigatorService navigatorService;
  final bool isLoggedIn;

  MyApp({
    super.key,
    required this.navigatorService,
    required this.isLoggedIn,
  });

  var firestore = FirestoreService();

  @override
  Widget build(context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return AppProvider(
        navigatorService: navigatorService,
        child: MaterialApp(
          title: 'Job Search App',
          theme:  ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.blueGrey,
              brightness: Brightness.light,
            ),
            primarySwatch: Colors.red,
          ),
          darkTheme:  ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.blueGrey,
              brightness: Brightness.dark,
            ),
            primarySwatch: Colors.red,
          ),
          themeMode: themeProvider.isDarkMode ? ThemeMode.dark : ThemeMode.light,


          home: isLoggedIn
              ? FutureBuilder<String?>(
                  future: firestore.getUserName(),
                  builder: (context, snapshot) {
                    return ChangeNotifierProvider<HomePageViewModel>(
                      create: (_) => HomePageViewModel(),
                      builder: (context, child) {
                        return HomePage(
                          username: snapshot.data ?? '',
                          viewModel: Provider.of<HomePageViewModel>(context),
                        );
                      },
                    );
                  })
              : const GoogleLogin(),
          navigatorKey: navigatorService.navigatorKey,
          routes: {
            'MyHomePage': (context) => HomePage(
                  username: '',
                  viewModel: Provider.of<HomePageViewModel>(context),
                ),
            'CareerGoalPage': (context) => CareerGoalPage(
                  viewModel: Provider.of<CareerGoalViewModel>(context),
                  username: '',
                ),
            'JobSearchView': (context) => JobSearchView(
                  viewModel: Provider.of<JobSearchViewModel>(context),
                  username: '',
                ),
            'SettingsPage': (context) => SettingsPage(
              viewModel: Provider.of<SettingsViewModel>(context),
              username: '',
            ),
            'CitySearchView': (context) => CitySearchView(username: ''),
          },
        ));
  }
}

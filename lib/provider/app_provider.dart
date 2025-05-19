import 'package:flutter/material.dart';
import 'package:job_market_app/viewmodel/calendar_viewmodel.dart';
import 'package:job_market_app/viewmodel/city_arena_viewmodel.dart';
import 'package:job_market_app/service/login_service.dart';
import 'package:job_market_app/viewmodel/city_search_viewmodel.dart';
import 'package:job_market_app/viewmodel/settings_viewmodel.dart';
import 'package:provider/provider.dart';

import '../service/navigator_service.dart';
import '../viewmodel/application_tracking_viewmodel.dart';
import '../viewmodel/homepage_viewmodel.dart';

class AppProvider extends StatelessWidget {
  final Widget child;
  final NavigatorService navigatorService;

  const AppProvider(
      {super.key, required this.child, required this.navigatorService});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<NavigatorService>(create: (context) => navigatorService),
        ChangeNotifierProvider<CitySearchViewModel>(
            create: (context) => CitySearchViewModel()),
        ChangeNotifierProvider(
          create: (context) => HomePageViewModel(),
        ),
        ChangeNotifierProvider<CityArenaViewModel>(create: (context)=> CityArenaViewModel()),
        ChangeNotifierProvider(
          create: (context) => ApplicationTrackingViewModel(navigatorService),
        ),
        ChangeNotifierProvider<SettingsViewModel>(
            create: (context) => SettingsViewModel()),
        ChangeNotifierProvider(create: (context) => LoginService()),
        ChangeNotifierProvider<CalendarViewModel>(create:(context)=>CalendarViewModel()),
      ],
      child: child,
    );
  }
}

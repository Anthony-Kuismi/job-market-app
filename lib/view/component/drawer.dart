import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:job_market_app/view/city_search_view.dart';
import 'package:job_market_app/view/job_search_view.dart';
import 'package:job_market_app/viewmodel/career_goal_viewmodel.dart';
import 'package:job_market_app/viewmodel/homepage_viewmodel.dart';
import 'package:job_market_app/viewmodel/job_search_viewmodel.dart';
import 'package:provider/provider.dart';

import '../../service/navigator_service.dart';
import '../../viewmodel/application_tracking_viewmodel.dart';
import '../../viewmodel/settings_viewmodel.dart';
import '../application_tracking_view.dart';
import '../calendar_view.dart';
import '../career_goal_view.dart';
import '../city_arena_view.dart';
import '../homepage_view.dart';
import '../settings_view.dart';

class AppDrawer extends StatelessWidget {
  final String currentPage;
  final String user;

  final VoidCallback? callback;

  const AppDrawer(
      {required Key key, required this.currentPage, required this.user, this.callback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<NavigatorService>(
        builder: (context, navigatorService, child) {
      return Drawer(
          child: Container(
        color: Theme.of(context).colorScheme.background,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                ),
                child: Text(
                  'Welcome Back,\n$user!',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                )),
            Container(
              margin: const EdgeInsets.fromLTRB(15, 5, 15, 5),
              decoration: BoxDecoration(
                color: currentPage == 'HomePage'
                    ? Theme.of(context).colorScheme.secondaryContainer
                    : null,
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                title: const Text('My Dashboard'),
                onTap: () {
                  if(callback!=null)callback!();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ChangeNotifierProvider<HomePageViewModel>(
                        create: (_) => HomePageViewModel(),
                        builder: (context, child) {
                          return HomePage(
                            username: user,
                            viewModel: Provider.of<HomePageViewModel>(context),
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(15, 5, 15, 5),
              decoration: BoxDecoration(
                color: currentPage == 'JobSearchView'
                    ? Theme.of(context).colorScheme.secondaryContainer
                    : null,
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                title: const Text('Search AI/ML Jobs'),
                onTap: () {
                  if(callback!=null)callback!();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ChangeNotifierProvider<JobSearchViewModel>(
                        create: (_) => JobSearchViewModel(),
                        builder: (context, child) {
                          return JobSearchView(
                            username: user,
                            viewModel: Provider.of<JobSearchViewModel>(context),
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(15, 5, 15, 5),
              decoration: BoxDecoration(
                color: currentPage == 'CareerGoalPage'
                    ? Theme.of(context).colorScheme.secondaryContainer
                    : null,
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                title: const Text('Career Goals'),
                onTap: () {
                  if(callback!=null)callback!();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ChangeNotifierProvider<CareerGoalViewModel>(
                        create: (_) => CareerGoalViewModel(),
                        builder: (context, child) {
                          return CareerGoalPage(
                            username: user ?? '',
                            viewModel:
                                Provider.of<CareerGoalViewModel>(context),
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(15, 5, 15, 5),
              decoration: BoxDecoration(
                color: currentPage == 'ApplicationTracking'
                    ? Theme.of(context).colorScheme.secondaryContainer
                    : null,
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                title: const Text('Application Tracking'),
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ChangeNotifierProvider<ApplicationTrackingViewModel>(
                        create: (_) =>
                            ApplicationTrackingViewModel(navigatorService),
                        builder: (context, child) {
                          return ApplicationTracking(
                            username: user ?? '',
                            viewModel:
                                Provider.of<ApplicationTrackingViewModel>(
                                    context),
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(15, 5, 15, 5),
              decoration: BoxDecoration(
                color: currentPage == 'CitySearchView'
                    ? Theme.of(context).colorScheme.secondaryContainer
                    : null,
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                title: const Text('Search Cities'),
                onTap: () {
                  if(callback!=null)callback!();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CitySearchView(username: user ?? ''),
                    ),
                  );
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(15, 5, 15, 5),
              decoration: BoxDecoration(
                color: currentPage == 'CityArenaView'
                    ? Theme.of(context).colorScheme.secondaryContainer
                    : null,
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                title: const Text('Compare Job Markets'),
                onTap: () {
                  if(callback!=null)callback!();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CityArenaView(username: user ?? ''),
                    ),
                  );
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(15, 5, 15, 5),
              decoration: BoxDecoration(
                color: currentPage == 'CalendarView'
                    ? Theme.of(context).colorScheme.secondaryContainer
                    : null,
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                title: const Text('Calendar'),
                onTap: () {
                  if(callback!=null)callback!();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CalendarView(username: user ?? ''),
                    ),
                  );
                },
              ),
            ),

            Container(
              margin: const EdgeInsets.fromLTRB(15, 5, 15, 5),
              decoration: BoxDecoration(
                color: currentPage == ''
                    ? Theme.of(context).colorScheme.secondaryContainer
                    : null,
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                title: const Text('Settings'),
                onTap: () {
                  if(callback!=null)callback!();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ChangeNotifierProvider<SettingsViewModel>(
                        create: (_) => SettingsViewModel(),
                        builder: (context, child) {
                          return SettingsPage(
                            username: user ?? '',
                            viewModel: Provider.of<SettingsViewModel>(context),
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ));
    });
  }
}

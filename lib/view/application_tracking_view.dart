import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:job_market_app/service/navigator_service.dart';
import 'package:job_market_app/viewmodel/calendar_viewmodel.dart';
import 'package:provider/provider.dart';

import '../model/application.dart';
import '../provider/app_provider.dart';
import '../viewmodel/application_tracking_viewmodel.dart';
import '../viewmodel/homepage_viewmodel.dart';
import 'component/application_list_tile.dart';
import 'component/drawer.dart';

class ApplicationTracking extends StatefulWidget {
  ApplicationTrackingViewModel viewModel;
  final NavigatorService navigatorService = NavigatorService();

  final String username;

  ApplicationTracking(
      {super.key, required this.username, required this.viewModel});

  @override
  _ApplicationTrackingState createState() => _ApplicationTrackingState();
}

class _ApplicationTrackingState extends State<ApplicationTracking> {
  

  void refresh() {
    setState(() {});
  }

  late Future _loadFuture;

  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    _loadFuture = widget.viewModel.load();
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now()
          .add(const Duration(days: 3650)), 
    ).then((pickedDate) {
      if (pickedDate == null) return;
      setState(() {
        log('updated selected date to $pickedDate');
        selectedDate = pickedDate;
        
        log('selected date: $selectedDate');
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final viewModel =
        Provider.of<ApplicationTrackingViewModel>(context, listen: true);
    final calendarViewModel = Provider.of<CalendarViewModel>(context);
    return AppProvider(
      navigatorService: widget.navigatorService,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Application Tracker'),
          automaticallyImplyLeading: true,
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        ),
        drawer: AppDrawer(
            key: const Key('AppDrawer'),
            currentPage: 'ApplicationTracking',
            user: widget.username),
        body: FutureBuilder(
          future: _loadFuture,
          builder: (context, snapshot) {
            return SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  ExpansionTile(
                    title: Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.secondaryContainer,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        'Apply Soon',
                        style: TextStyle(
                          fontSize: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.fontSize,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    iconColor: Theme.of(context).colorScheme.primaryContainer,
                    collapsedIconColor: Theme.of(context).colorScheme.primary,
                    children: viewModel.readyToApply().map((application) {
                      return Container(
                        margin: const EdgeInsets.fromLTRB(10, 3, 10, 3),
                        child: ApplicationListTile(
                            viewModel: viewModel, app: application),
                      );
                    }).toList(),
                  ),
                  ExpansionTile(
                    title: Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.secondaryContainer,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        'Applied',
                        style: TextStyle(
                          fontSize: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.fontSize,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    iconColor: Theme.of(context).colorScheme.primaryContainer,
                    collapsedIconColor: Theme.of(context).colorScheme.primary,
                    children: viewModel.applied().map((application) {
                      return Container(
                        margin: const EdgeInsets.fromLTRB(10, 3, 10, 3),
                        child: ApplicationListTile(
                            viewModel: viewModel, app: application),
                      );
                    }).toList(),
                  ),
                  ExpansionTile(
                    title: Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.secondaryContainer,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        'Interviewing',
                        style: TextStyle(
                          fontSize: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.fontSize,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    iconColor: Theme.of(context).colorScheme.primaryContainer,
                    collapsedIconColor: Theme.of(context).colorScheme.primary,
                    children: viewModel.interviewing().map((application) {
                      return Container(
                        margin: const EdgeInsets.fromLTRB(10, 3, 10, 3),
                        child: ApplicationListTile(
                            viewModel: viewModel, app: application),
                      );
                    }).toList(),
                  ),
                  ExpansionTile(
                    title: Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.secondaryContainer,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        'Received Offer',
                        style: TextStyle(
                          fontSize: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.fontSize,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    iconColor: Theme.of(context).colorScheme.primaryContainer,
                    collapsedIconColor: Theme.of(context).colorScheme.primary,
                    children: viewModel.offer().map((application) {
                      return Container(
                        margin: const EdgeInsets.fromLTRB(10, 3, 10, 3),
                        child: ApplicationListTile(
                            viewModel: viewModel, app: application),
                      );
                    }).toList(),
                  ),
                ],
              ),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                int currentPage = 0;
                String jobTitle = '';
                String companyName = '';
                String location = '';
                String payRate = '';
                String? applicationStage = '';
                final pageController = PageController();

                return StatefulBuilder(
                  builder: (context, setState) {
                    void _presentDatePicker() {
                      showDatePicker(
                        context: context,
                        initialDate: selectedDate,
                        firstDate: DateTime(2000),
                        lastDate: DateTime.now().add(const Duration(
                            days: 3650)), 
                      ).then((pickedDate) {
                        if (pickedDate != null) {
                          setState(() {
                            selectedDate = pickedDate;
                          });
                        }
                      });
                    }
                    return AlertDialog(
                      title: const Text('Add an Application'),
                      content: SizedBox(
                        height: currentPage != 4 ? 75 : 330,
                        width: MediaQuery.of(context).size.width - 40,
                        child: PageView(
                          controller: pageController,
                          onPageChanged: (value) {
                            setState(() {
                              currentPage = value;
                            });
                          },
                          children: [
                            TextField(
                              onChanged: (value) => jobTitle = value,
                              decoration:
                                  const InputDecoration(labelText: 'Job Title'),
                            ),
                            TextField(
                              onChanged: (value) => companyName = value,
                              decoration: const InputDecoration(
                                  labelText: 'Company Name'),
                            ),
                            TextField(
                              onChanged: (value) => location = value,
                              decoration:
                                  const InputDecoration(labelText: 'Location'),
                            ),
                            TextField(
                              onChanged: (value) => payRate = value,
                              decoration:
                                  const InputDecoration(labelText: 'Salary'),
                              keyboardType: TextInputType.number,
                            ),
                            Column(
                              children: <Widget>[
                                if (selectedDate != null)
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8.0),
                                    child: Text(
                                        'Selected date: ${DateFormat('yMMMd').format(selectedDate)}'),
                                  ),
                                ElevatedButton(
                                  onPressed: _presentDatePicker,
                                  child: const Text('Choose Date'),
                                ),
                                RadioListTile<String>(
                                  title: const Text('Ready to Apply'),
                                  value: 'Ready to Apply',
                                  groupValue: applicationStage,
                                  onChanged: (value) {
                                    setState(() {
                                      applicationStage = value;
                                    });
                                  },
                                ),
                                RadioListTile<String>(
                                  title: const Text('Applied'),
                                  value: 'Applied',
                                  groupValue: applicationStage,
                                  onChanged: (value) {
                                    setState(() {
                                      applicationStage = value;
                                    });
                                  },
                                ),
                                RadioListTile<String>(
                                  title: const Text('Interviewing'),
                                  value: 'Interviewing',
                                  groupValue: applicationStage,
                                  onChanged: (value) {
                                    setState(() {
                                      applicationStage = value;
                                    });
                                  },
                                ),
                                RadioListTile<String>(
                                  title: const Text('Received Offer'),
                                  value: 'Received Offer',
                                  groupValue: applicationStage,
                                  onChanged: (value) {
                                    setState(() {
                                      applicationStage = value;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      actions: [
                        if (currentPage < 4)
                          TextButton(
                            child: const Text('Next'),
                            onPressed: () {
                              switch (currentPage) {
                                case 0:
                                  if (jobTitle.isEmpty) {
                                    return;
                                  }
                                  break;
                                case 1:
                                  if (companyName.isEmpty) {
                                    return;
                                  }
                                  break;
                                case 2:
                                  if (location.isEmpty) {
                                    return;
                                  }
                                  break;
                                case 3:
                                  if (payRate.isEmpty) {
                                    return;
                                  }
                                  break;
                              }
                              pageController.nextPage(
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.ease,
                              );
                            },
                          ),
                        if (currentPage == 4)
                          TextButton(
                            child: const Text('Add'),
                            onPressed: () {
                              if (applicationStage == null) {
                                return;
                              }
                              viewModel.addApplication(
                                  jobTitle,
                                  companyName,
                                  location,
                                  double.parse(payRate),
                                  applicationStage!,
                                selectedDate
                              );
                              calendarViewModel.updateEvents();
                              Navigator.of(context).pop();
                            },
                          ),
                      ],
                    );
                  },
                );
              },
            );
          },
          backgroundColor: Theme.of(context).colorScheme.primary,
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}

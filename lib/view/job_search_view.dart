import 'dart:async';
import 'package:flutter/material.dart';
import 'package:job_market_app/model/job.dart';
import 'package:job_market_app/viewmodel/job_search_viewmodel.dart';

import '../provider/app_provider.dart';
import '../service/navigator_service.dart';
import 'component/drawer.dart';

class JobSearchView extends StatefulWidget {
  final JobSearchViewModel viewModel;
  final NavigatorService navigatorService = NavigatorService();
  final String username;

  JobSearchView({super.key, required this.username, required this.viewModel});

  @override
  JobSearchViewState createState() => JobSearchViewState();
}

class JobSearchViewState extends State<JobSearchView> {
  List<Job> searchResults = [];

  void onQueryChanged(String query) async {
    final results = await widget.viewModel.getSearchResults(query);
    setState(() {
      searchResults = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppProvider(
        navigatorService: widget.navigatorService,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Search AI/ML Jobs'),
            automaticallyImplyLeading: true,
            backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          ),
          drawer: AppDrawer(
              key: const Key('AppDrawer'),
              currentPage: 'JobSearchView',
              user: widget.username),
          body: Column(
            children: [
              const Padding(padding: EdgeInsets.all(7)),
              GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      String? selectedSearch = widget.viewModel.searchType;
                      return StatefulBuilder(
                        builder: (context, setState) {
                          return AlertDialog(
                            title: const Text('Set Your Search Type'),
                            content: SingleChildScrollView(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  RadioListTile<String>(
                                    title: const Text('Title'),
                                    value: 'Title',
                                    groupValue: selectedSearch,
                                    onChanged: (value) {
                                      setState(() {
                                        selectedSearch = value;
                                      });
                                    },
                                  ),
                                  RadioListTile<String>(
                                    title: const Text('Company'),
                                    value: 'Company',
                                    groupValue: selectedSearch,
                                    onChanged: (value) {
                                      setState(() {
                                        selectedSearch = value;
                                      });
                                    },
                                  ),
                                  RadioListTile<String>(
                                    title: const Text('State'),
                                    value: 'State',
                                    groupValue: selectedSearch,
                                    onChanged: (value) {
                                      setState(() {
                                        selectedSearch = value;
                                      });
                                    },
                                  ),
                                  RadioListTile<String>(
                                    title: const Text('Region'),
                                    value: 'Region',
                                    groupValue: selectedSearch,
                                    onChanged: (value) {
                                      setState(() {
                                        selectedSearch = value;
                                      });
                                    },
                                  ),
                                  RadioListTile<String>(
                                    title: const Text('Position'),
                                    value: 'Position',
                                    groupValue: selectedSearch,
                                    onChanged: (value) {
                                      setState(() {
                                        selectedSearch = value;
                                      });
                                    },
                                  ),
                                  RadioListTile<String>(
                                    title: const Text('Description'),
                                    value: 'Description',
                                    groupValue: selectedSearch,
                                    onChanged: (value) {
                                      setState(() {
                                        selectedSearch = value;
                                      });
                                    },
                                  ),
                                  RadioListTile<String>(
                                    title: const Text('Salary'),
                                    value: 'Salary',
                                    groupValue: selectedSearch,
                                    onChanged: (value) {
                                      setState(() {
                                        selectedSearch = value;
                                      });
                                    },
                                  ),
                                  RadioListTile<String>(
                                    title: const Text('Skills'),
                                    value: 'Skills',
                                    groupValue: selectedSearch,
                                    onChanged: (value) {
                                      setState(() {
                                        selectedSearch = value;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  if (selectedSearch != null) {
                                    widget.viewModel
                                        .setSearchType(selectedSearch);
                                  }
                                  Navigator.of(context).pop();
                                },
                                child: const Text('OK'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  );
                },
                child: Container(
                  width: MediaQuery.of(context).size.width * .5,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Theme.of(context).colorScheme.primaryContainer,
                  ),
                  child: Text(
                    'Select Search Type',
                    style: TextStyle(
                      fontSize:
                          Theme.of(context).textTheme.titleSmall?.fontSize,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SearchBar(onQueryChanged: onQueryChanged),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(8.0),
                  children: searchResults.map((Job job) {
                    return JobContainer(job: job);
                  }).toList(),
                ),
              ),
            ],
          ),
        ));
  }
}

class JobContainer extends StatefulWidget {
  final Job job;

  const JobContainer({super.key, required this.job});

  @override
  JobContainerState createState() => JobContainerState();
}

class JobContainerState extends State<JobContainer> {
  bool collapsed = true;

  void expand() {
    setState(() {
      collapsed = !collapsed;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        expand();
      },
      child: Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${widget.job.company} (${widget.job.location})',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              '${widget.job.title} \$${widget.job.salary.toStringAsFixed(0)}',
              style:
                  const TextStyle(fontSize: 15, fontWeight: FontWeight.normal),
            ),
            Text(
              'Skills: ${widget.job.getSkillsAsString()}',
              style:
                  const TextStyle(fontSize: 15, fontWeight: FontWeight.normal),
            ),
            Text(
              collapsed ? '' : widget.job.description,
              style:
                  const TextStyle(fontSize: 12, fontWeight: FontWeight.normal),
            ),
          ],
        ),
      ),
    );
  }
}

class SearchBar extends StatefulWidget {
  final Function onQueryChanged;

  const SearchBar({super.key, required this.onQueryChanged});

  @override
  SearchBarState createState() => SearchBarState();
}

class SearchBarState extends State<SearchBar> {
  String query = '';
  Timer? searchTimer;

  void onQueryChanged(String newQuery) {
    setState(() {
      query = newQuery;
    });

    if (searchTimer?.isActive ?? false) {
      searchTimer?.cancel();
    }

    searchTimer = Timer(const Duration(milliseconds: 500), () {
      widget.onQueryChanged(newQuery);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: TextField(
        onChanged: onQueryChanged,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          prefixIcon: Icon(Icons.search),
        ),
      ),
    );
  }
}

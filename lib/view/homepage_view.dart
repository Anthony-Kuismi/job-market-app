import 'package:flutter/material.dart';
import 'package:job_market_app/service/navigator_service.dart';
import 'package:provider/provider.dart';

import '../provider/app_provider.dart';
import '../viewmodel/homepage_viewmodel.dart';
import '../viewmodel/job_search_viewmodel.dart';
import 'component/drawer.dart';
import 'job_search_view.dart';

class HomePage extends StatefulWidget {
  HomePageViewModel viewModel;
  final NavigatorService navigatorService = NavigatorService();

  final String username;

  HomePage({super.key, required this.username, required this.viewModel});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void refresh() {
    setState(() {});
  }

  late Future _loadFuture;

  @override
  void initState() {
    super.initState();
    _loadFuture = widget.viewModel.load();
  }


  @override
  Widget build(BuildContext context) {
    return AppProvider(
      navigatorService: widget.navigatorService,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('SWE Job Tracker'),
          automaticallyImplyLeading: true,
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        ),
        drawer: AppDrawer(
            key: const Key('AppDrawer'),
            currentPage: 'HomePage',
            user: widget.username),
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('lib/assets/spencer-bergen-jC1HwWiys5g-unsplash.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  Theme.of(context).colorScheme.secondaryContainer.withOpacity(0.5),
                  Theme.of(context).colorScheme.secondaryContainer.withOpacity(0.95),
                ],
              ),
            ),
            child: FutureBuilder(
              future: _loadFuture,
              builder: (context, snapshot) {
                return Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          "Welcome Back,\n${widget.username}",
                          style: const TextStyle(fontSize: 42, fontWeight: FontWeight.w900),
                        ),
                      ),
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Container(
                          height: 150,
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.background.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              const Padding(
                                padding: EdgeInsets.fromLTRB(12, 12, 12, 4),
                                child: Text(
                                  "Find Your Next Career",
                                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              ChangeNotifierProvider<JobSearchViewModel>(
                                                create: (_) => JobSearchViewModel(),
                                                builder: (context, child) {
                                                  return JobSearchView(
                                                    username: widget.username,
                                                    viewModel: Provider.of<JobSearchViewModel>(context),
                                                  );
                                                },
                                              ),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      height: 150,
                                      decoration: BoxDecoration(
                                        color: Theme.of(context).colorScheme.secondaryContainer.withOpacity(0.8),
                                        borderRadius: BorderRadius.circular(10.0),
                                      ),
                                      child: const Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Padding(
                                            padding: EdgeInsets.all(16.0),
                                            child: Icon(
                                              Icons.search,
                                              size: 40,
                                            )
                                          ),
                                          Padding(
                                            padding: EdgeInsets.all(16.0),
                                            child: Text(
                                              'Search Jobs',
                                              style: TextStyle(
                                                fontSize: 20.0,
                                                fontWeight: FontWeight.w800,
                                              ),
                                            )
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

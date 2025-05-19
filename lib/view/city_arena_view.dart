import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:job_market_app/view/component/city_comparison_table.dart';
import 'package:job_market_app/viewmodel/city_arena_viewmodel.dart';
import 'package:job_market_app/viewmodel/city_search_viewmodel.dart';
import 'package:provider/provider.dart';

import 'component/city_search_bar.dart';
import 'component/city_search_results.dart';
import 'component/drawer.dart';

class CityArenaView extends StatelessWidget {
  final String username;

  CityArenaView({super.key, required this.username});

  @override
  Widget build(BuildContext context) {
    CityArenaViewModel viewModel = Provider.of<CityArenaViewModel>(context);
    CitySearchViewModel citySearchViewModel = Provider.of<CitySearchViewModel>(context);

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Compare Cities'),
          automaticallyImplyLeading: true,
          backgroundColor: Theme
              .of(context)
              .colorScheme
              .primaryContainer,
        ),
        drawer: AppDrawer(
            key: Key('AppDrawer'), currentPage: 'CityArenaView', user: username, callback: ()=>citySearchViewModel.query='',
        ),
        body: Column(
          children: [
            CityComparisonTable(username: username,viewModel: viewModel, citySearchViewModel: citySearchViewModel),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:job_market_app/view/component/city_list_sort_toggle_button.dart';
import 'package:job_market_app/viewmodel/city_search_viewmodel.dart';
import 'package:provider/provider.dart' show Provider;

import '../model/city.dart';
import '../model/city_search.dart';
import 'component/city_search_bar.dart';
import 'component/city_search_results.dart';
import 'component/drawer.dart';

class CitySearchView extends StatelessWidget {
  String username;
  Function(City)? callback;

  String? title;
  String? currentPage;

  CitySearchView({super.key, required this.username, this.callback, this.title, this.currentPage});

  late CitySearchViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    viewModel = Provider.of<CitySearchViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(title??'Search by City'),
        automaticallyImplyLeading: true,
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      drawer: AppDrawer(
          key: Key('AppDrawer'), currentPage: currentPage??'CitySearchView', user: username,callback:(){viewModel.query='';}),
      body: Column(
        children: [
          CitySearchBar(viewModel: viewModel),
          CityListSortToggleButton(viewModel: viewModel),
          CitySearchResults(viewModel: viewModel, callback: callback),
        ],
      ),
    );
  }
}

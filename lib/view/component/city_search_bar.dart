import 'package:flutter/material.dart';

import '../../viewmodel/city_search_viewmodel.dart';

class CitySearchBar extends StatelessWidget {
  CitySearchViewModel viewModel;

  CitySearchBar({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: TextField(
        onChanged: (newQuery) => viewModel.query = newQuery,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          prefixIcon: Icon(Icons.search),
        ),
      ),
    );
  }
}

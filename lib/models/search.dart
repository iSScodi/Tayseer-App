import 'package:flutter/material.dart';
import 'package:tayseer__app/models/municipalityInfo.dart';
import 'package:tayseer__app/screens/MunicipalityDetails_screen.dart';

class MunicipalitySearch extends SearchDelegate {
  final Map<int, MunicipalityInfo> data;

  MunicipalitySearch(this.data);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [IconButton(icon: const Icon(Icons.clear), onPressed: () => query = '')];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => close(context, null));
  }

  @override
  Widget buildResults(BuildContext context) {
    return _buildListView(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return _buildListView(context);
  }

  Widget _buildListView(BuildContext context) {
    final filtered = data.entries
        .where((entry) => entry.value.name.toLowerCase().contains(query.toLowerCase()))
        .toList();

    if (filtered.isEmpty) {
      return const Center(child: Text("No results found"));
    }

    return ListView.builder(
      itemCount: filtered.length,
      itemBuilder: (context, index) {
        final entry = filtered[index];
        final info = entry.value;
        return ListTile(
          leading: Image.asset(info.imagePath, width: 50, height: 50, fit: BoxFit.cover),
          title: Text(info.name),
          onTap: () {
            close(context, null);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MunicipalityDetailsScreen(id: entry.key)),
            );
          },
        );
      },
    );
  }
}
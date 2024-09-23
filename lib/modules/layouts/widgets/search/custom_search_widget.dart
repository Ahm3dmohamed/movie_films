import 'package:flutter/material.dart';
import 'package:movie_app/modules/layouts/widgets/search/movie_card.dart';
import 'package:movie_app/provider/main_provider.dart';
import 'package:provider/provider.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MainProvider>(context, listen: false);

    return Expanded(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            child: TextFormField(
              controller: provider.controller,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(24),
                    ),
                    borderSide: BorderSide(color: Colors.white, width: 3)),
                hintText: "Search for Movies",
                hintStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    decorationStyle: TextDecorationStyle.wavy),
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.white,
                ),
              ),
              onFieldSubmitted: (query) {
                if (query.isNotEmpty) {
                  provider.performSearch(query);
                }
              },
            ),
          ),
          Consumer<MainProvider>(
            builder: (context, provider, child) {
              if (provider.isLoading) {
                return const CircularProgressIndicator();
              }

              if (provider.searchResult != null &&
                  provider.searchResult!.results != null &&
                  provider.searchResult!.results!.isNotEmpty) {
                return Expanded(
                  child: ListView.builder(
                    itemCount: provider.searchResult!.results!.length,
                    itemBuilder: (context, index) {
                      final movie = provider.searchResult!.results![index];
                      return MovieCard(movie: movie);
                    },
                  ),
                );
              }
              return const Text("");
            },
          ),
        ],
      ),
    );
  }
}

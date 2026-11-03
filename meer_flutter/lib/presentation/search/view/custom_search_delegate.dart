import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meer_flutter/presentation/search/bloc/search_bloc.dart';
import 'package:meer_flutter/presentation/search/components/list_products_search.dart';

class CustomSearchDelegate extends SearchDelegate {
  final SearchBloc searchBloc;

  String? _lastRequestedQuery;

  CustomSearchDelegate({
    required this.searchBloc,
  }) : super(
         searchFieldLabel: 'ابحث عن منتجاتك المفضلة',
       );

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        tooltip: 'مسح البحث',
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
          _lastRequestedQuery = null;

          searchBloc.add(
            const SearchEvent.clearSearch(),
          );

          showSuggestions(context);
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      tooltip: 'رجوع',
      icon: const Icon(Icons.arrow_back),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    _searchIfNeeded();

    return _buildSearchResultsAndStates();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final currentQuery = query.trim();

    if (currentQuery.isEmpty) {
      return const Center(
        child: Text('ابحث عن منتجاتك المفضلة'),
      );
    }

    // لا تعرض نتائج الاستعلام السابق أثناء كتابة استعلام جديد.
    if (currentQuery != _lastRequestedQuery) {
      return const Center(
        child: Text('اضغط بحث من لوحة المفاتيح لعرض النتائج'),
      );
    }

    return _buildSearchResultsAndStates();
  }

  /// إرسال استعلام واحد لكل نص بحث جديد.
  void _searchIfNeeded() {
    final currentQuery = query.trim();

    if (currentQuery.isEmpty) {
      if (_lastRequestedQuery != '') {
        _lastRequestedQuery = '';

        searchBloc.add(
          const SearchEvent.clearSearch(),
        );
      }

      return;
    }

    if (_lastRequestedQuery == currentQuery) {
      return;
    }

    _lastRequestedQuery = currentQuery;

    searchBloc.add(
      SearchEvent.queryChanged(currentQuery),
    );
  }

  Widget _buildSearchResultsAndStates() {
    return BlocBuilder<SearchBloc, SearchState>(
      bloc: searchBloc,
      builder: (context, state) {
        return state.status.when(
          initial: () => const Center(
            child: Text('ابحث عن منتجاتك المفضلة'),
          ),
          loading: () => const Center(
            child: CircularProgressIndicator(),
          ),
          notFound: () => const Center(
            child: Padding(
              padding: EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.search_off,
                    size: 48,
                  ),
                  SizedBox(height: 12),
                  Text(
                    'لم نجد منتجات تطابق بحثك.',
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
          failure: (error) => Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Text(
                error,
                textAlign: TextAlign.center,
              ),
            ),
          ),
          loaded: () => ListProductsSearch(
            products: state.searchResults,
          ),
        );
      },
    );
  }
}

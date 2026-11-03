import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:meer_client/meer_client.dart';
import 'package:meer_flutter/repository/search_repository.dart';

part 'search_event.dart';
part 'search_state.dart';
part 'search_bloc.freezed.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchRepository searchRepository; // المستودع الخاص بالبحث

  SearchBloc(this.searchRepository) : super(const SearchState()) {
    on<QueryChanged>(_onQueryChanged);
    on<ClearSearch>(_onClearSearch);
  }

  Future<void> _onQueryChanged(
    QueryChanged event,
    Emitter<SearchState> emit,
  ) async {
    if (event.query.isEmpty) {
      emit(
        state.copyWith(status: const SearchStatus.initial(), searchResults: []),
      );
      return;
    }

    emit(state.copyWith(status: const SearchStatus.loading()));

    final response = await searchRepository.searchResults(event.query);

    response.fold(
      (failure) =>
          emit(state.copyWith(status: SearchStatus.failure(failure.message))),
      (data) {
        if (data.isEmpty) {
          emit(
            state.copyWith(
              status: const SearchStatus.notFound(),
              searchResults: [],
            ),
          );
        } else {
          emit(
            state.copyWith(
              status: const SearchStatus.loaded(),
              searchResults: data,
            ),
          );
        }
      },
    );
  }

  void _onClearSearch(ClearSearch event, Emitter<SearchState> emit) {
    emit(
      state.copyWith(status: const SearchStatus.initial(), searchResults: []),
    );
  }
}

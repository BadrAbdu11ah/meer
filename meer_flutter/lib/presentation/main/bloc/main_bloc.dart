import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'main_event.dart';
part 'main_state.dart';
part 'main_bloc.freezed.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  static const int pageCount = 4;

  MainBloc()
    : super(
        const MainState(
          currentPage: 0,
          visitedPages: {0},
        ),
      ) {
    on<_PageChanged>(_onPageChanged);
  }

  void _onPageChanged(
    _PageChanged event,
    Emitter<MainState> emit,
  ) {
    // التحقق من صحة رقم الصفحة.
    if (event.page < 0 || event.page >= pageCount) {
      return;
    }

    // لا حاجة لإصدار حالة جديدة إذا كانت الصفحة نفسها مفتوحة.
    if (event.page == state.currentPage) {
      return;
    }

    // الاحتفاظ بالصفحات التي سبق للمستخدم فتحها.
    final visitedPages = <int>{
      ...state.visitedPages,
      event.page,
    };

    emit(
      state.copyWith(
        currentPage: event.page,
        visitedPages: visitedPages,
      ),
    );
  }
}
